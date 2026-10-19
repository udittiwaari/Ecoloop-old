<div align="center">
  <img src="assets/ecoloop-mark.png" alt="EcoLoop Logo" width="250">

  <h1>EcoLoop</h1>
  <p>Smart Waste Management for a Cleaner Future 🌱</p>
</div>

EcoLoop — Smart Waste, Clear Value
Turning everyday waste into clear value for a cleaner, greener future.

♻️ EcoLoop is a smart waste management and sustainability platform that helps people reduce waste, report garbage problems, discover ways to reuse everyday items, and promote responsible recycling for a cleaner, greener future. 

EcoLoop is an all-in-one smart waste management and sustainability platform. It empowers individuals and communities to reduce daily waste, report local garbage issues, discover creative ways to upcycle household items, check transparent scrap rates, and organize personal collection schedules—all from a fast, zero-database web interface.

EcoLoop is a single-page guide for smart waste management, reuse ideas, sample scrap rates, and personal collection planning.

## Project layout

```text
ecoloop/
├── frontend/        # Static website and visual assets
├── backend/         # Node.js static server and small JSON API
├── edge/            # Minimal Python edge health handler
├── .github/workflows/ # GitHub Pages deployment automation
├── .gitignore
└── README.md
```

## Run locally

1. Install Node.js 18 or later.
2. Open a terminal in `backend/`.
3. Run `npm start`.
4. Visit `http://localhost:4173`.

The backend also exposes:

- `GET /api/health`
- `GET /api/info`

The frontend currently stores collection plans in the browser, so it works without a database.

## Backup server

If port 4173 is already in use, run `npm run start:backup` from `backend/`. It starts EcoLoop on port 4174.

## Publish on GitHub Pages

1. Create an empty repository on GitHub, such as `ecoloop`.
2. Push this folder's `main` branch to that repository.
3. In the repository **Settings → Pages**, set the source to **GitHub Actions**.
4. Every push to `main` deploys the `frontend/` folder automatically.

The backend and edge handler are included in the repository for later hosting on a Node/Python-capable service. GitHub Pages hosts the static frontend only. 

🌍 Why EcoLoop? (The Problem & Solution)
    
    The Problem: Millions of tons of recyclable material end up in landfills simply because people don't know what their scrap is worth, how to reuse common          items, or when to schedule their waste pickups.

    The Solution: EcoLoop bridges the gap between household habits and responsible recycling. By combining a Reuse Guide, Transparent Scrap Pricing, and a            Browser-Based Collection Planner, it makes sustainable living practical and rewarding.

✨ What You Can Do on EcoLoop

    🚮 Report Garbage Issues: Quickly flag local waste and sanitation problems to help keep neighborhoods clean.

    💡 Discover Reuse & Upcycling Ideas: Learn practical, creative ways to give everyday household items a second life before throwing them out.

    💰 Check Sample Scrap Rates: View transparent reference prices for paper, plastic, metal, and e-waste so you know the exact value of your recyclables.

    📅 Plan Personal Collections: Schedule and track your waste pickups directly in your browser using localStorage—no sign-ups or external database required.

    ⚡ Hybrid Architecture: Works as a standalone static web app on GitHub Pages while supporting a lightweight Node.js API and Python edge health checks for             cloud scaling.

🛠️ Tech Stack
    Frontend: HTML5, CSS3, Vanilla JavaScript, Custom SVG Brand Assets (ecoloop-wordmark.svg, gemini-svg.svg)   
    Backend Server: Node.js (v18+) static file server & RESTful JSON API
    Edge Handler: Python (minimal edge health check service)
    Storage: Client-side Browser Storage (localStorage)
    CI/CD & Hosting: GitHub Actions & GitHub Pages



  🌐 Deploying to GitHub Pages
  
 1.  Create a new repository on GitHub named ecoloop.
 2.  Push your code to the main branch.
 3.  Go to Settings → Pages in your GitHub repository and set the source to GitHub Actions.
 4.  Every push to main automatically deploys the frontend/ folder live!

   🗺️ Future Roadmap
[ ] Interactive map integration for pinning reported garbage spots.

[ ] Live scrap rate calculator based on weight (kg) and material type.

[ ] Cloud database sync for sharing collection schedules across devices.

[ ] Dark/Light theme toggle using the custom EcoLoop SVG icons.

🤝 Contributing
Contributions, issues, and feature requests are welcome! Feel free to fork the repository, open an issue, or submit a pull request to help make EcoLoop even better.
