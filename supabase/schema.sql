-- EcoLoop Supabase schema
-- Run this entire file in Supabase Dashboard -> SQL Editor.
-- Then enable the Before User Created Auth Hook (instructions in README below).
-- IMPORTANT: Never store raw passwords in public tables. Supabase Auth manages passwords.

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text not null,
  created_at timestamptz not null default now(),
  constraint profiles_username_length check (char_length(username) between 3 and 24)
);

create unique index if not exists profiles_username_lower_unique
  on public.profiles (lower(username));

alter table public.profiles enable row level security;

grant select, update on public.profiles to authenticated;

drop policy if exists "Users can view their own profile" on public.profiles;
create policy "Users can view their own profile"
  on public.profiles for select
  to authenticated
  using ((select auth.uid()) = id);

drop policy if exists "Users can update their own profile" on public.profiles;
create policy "Users can update their own profile"
  on public.profiles for update
  to authenticated
  using ((select auth.uid()) = id)
  with check ((select auth.uid()) = id);

-- Create one private profile automatically for each Auth account.
create or replace function public.create_ecoloop_profile()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  chosen_username text;
begin
  chosen_username := coalesce(
    nullif(trim(new.raw_user_meta_data ->> 'username'), ''),
    'user_' || substr(new.id::text, 1, 8)
  );

  insert into public.profiles (id, username)
  values (new.id, chosen_username);

  return new;
end;
$$;

drop trigger if exists on_ecoloop_auth_user_created on auth.users;
create trigger on_ecoloop_auth_user_created
  after insert on auth.users
  for each row execute procedure public.create_ecoloop_profile();

-- Enforce a maximum of 50 Auth accounts on the server side.
-- Configure this function as Supabase Auth's "Before User Created" hook.
create or replace function public.ecoloop_limit_50_accounts(event jsonb)
returns jsonb
language plpgsql
security definer
set search_path = ''
as $$
declare
  total_accounts bigint;
begin
  -- Serialize concurrent signup checks so two simultaneous signups cannot both
  -- pass the limit check at the same time.
  perform pg_advisory_xact_lock(741205, 50);

  select count(*) into total_accounts from auth.users;

  if total_accounts >= 50 then
    return jsonb_build_object(
      'error',
      jsonb_build_object(
        'http_code', 403,
        'message', 'EcoLoop has reached its 50-account limit. Registration is closed.'
      )
    );
  end if;

  return '{}'::jsonb;
end;
$$;

grant usage on schema public to supabase_auth_admin;
grant execute on function public.ecoloop_limit_50_accounts(jsonb) to supabase_auth_admin;
revoke execute on function public.ecoloop_limit_50_accounts(jsonb) from public, anon, authenticated;

-- Emails and password hashes remain in Supabase's protected Auth schema.
-- Do not expose auth.users to the browser and never add a service_role key to frontend code.
