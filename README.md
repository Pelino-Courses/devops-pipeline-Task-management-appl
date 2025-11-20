## Branching Strategy

- `main`: Production-ready code, protected
- `develop`: Integration branch for features
- `feature/*`: New features (branch from develop)
- `bugfix/*`: Bug fixes (branch from develop)
- `hotfix/*`: Emergency fixes (branch from main)
- `release/*`: Release preparation (branch from develop)

## Workflow
1. Create feature branch from develop
2. Develop and commit changes
3. Push branch and create Pull Request to develop
4. Pass all CI checks
5. Obtain 2 peer reviews
6. Merge to develop
7. Periodically merge develop to main through release branch

## Dockerized Development

1. Copy `env.sample` to `.env` (or edit `env.sample`) and keep the provided `DB_URL`. Adjust `PORT` or `VITE_API_URL` if you need different values.
2. Build and run both services:
   ```bash
   docker compose up --build
   ```
   - Backend: `http://localhost:2000`
   - Frontend (Vite build served via Nginx): `http://localhost:5173`
3. Update the frontend API origin by passing `VITE_API_URL` at build time if you deploy elsewhere, e.g.
   ```bash
   docker compose build frontend \
     --build-arg VITE_API_URL=https://api.example.com/api
   ```