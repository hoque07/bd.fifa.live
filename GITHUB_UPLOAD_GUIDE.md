# Publish the FIFA World Cup 2026 BD Website

The project has two parts:

1. GitHub Pages hosts the static website.
2. A Cloudflare Worker securely requests live scores from API-Football.

GitHub Pages cannot safely store an API key. Never put the API-Football key in `index.html`, `live-config.js`, GitHub commits, or screenshots.

## Project Files to Upload

Upload the complete project, including:

- `index.html`
- `schedule-data.js`
- `squad-data.js`
- `live-config.js`
- `FIFA_World_Cup_2026_BD_Schedule_Bangla_Styled.pdf`
- `FIFA_World_Cup_2026_Official_Squads.pdf`
- `README.md`
- `.gitignore`
- `worker/worker.js`
- `worker/wrangler.toml`

Do not upload `.dev.vars`, `.env`, API keys, or `node_modules`.

## Part 1: Create the Live-Score API

### 1. Get an API-Football key

1. Create an account at [API-Football](https://www.api-football.com/).
2. Open the dashboard and copy your API key.
3. Confirm that the account plan includes FIFA World Cup fixtures and enough requests for your refresh interval.

The website defaults to one request every 60 seconds. A low-quota/free plan may require a larger value such as `900` seconds in `live-config.js`.

### 2. Deploy the Cloudflare Worker

1. Create a free [Cloudflare](https://dash.cloudflare.com/) account.
2. Open **Workers & Pages**.
3. Create a Worker named `fifa-world-cup-2026-live-score`.
4. Replace its code with the contents of `worker/worker.js` and deploy it.
5. Open the Worker **Settings > Variables and Secrets**.
6. Add an encrypted secret:

```text
API_FOOTBALL_KEY = your-real-api-key
```

7. Add these ordinary variables:

```text
API_FOOTBALL_LEAGUE_ID = 1
API_FOOTBALL_SEASON = 2026
ALLOWED_ORIGIN = *
```

After GitHub Pages is working, replace `*` with your exact Pages origin, for example:

```text
https://tanvirnibir.github.io
```

8. Copy the Worker URL, for example:

```text
https://fifa-world-cup-2026-live-score.your-account.workers.dev/
```

### 3. Connect the website

Open `live-config.js` and paste the Worker URL:

```js
window.FIFA_LIVE_SCORE_ENDPOINT = "https://fifa-world-cup-2026-live-score.your-account.workers.dev/";
window.FIFA_LIVE_REFRESH_SECONDS = 60;
```

Open the Worker URL directly. A working response contains JSON with `provider`, `updatedAt`, and `fixtures`.

## Part 2: Upload to GitHub

### Browser upload method

1. Sign in to [GitHub](https://github.com/).
2. Select **New repository**.
3. Enter a repository name such as `fifa-world-cup-2026-bd`.
4. Set it to **Public** and create it.
5. Select **Add file > Upload files**.
6. Upload all project files and folders listed above.
7. Commit the files to the `main` branch.

### Git command method

Run these commands from the project folder after replacing the repository URL:

```powershell
git init
git add .
git commit -m "Publish FIFA World Cup 2026 BD website"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/fifa-world-cup-2026-bd.git
git push -u origin main
```

## Part 3: Enable GitHub Pages

1. Open the GitHub repository.
2. Select **Settings > Pages**.
3. Under **Build and deployment**, choose **Deploy from a branch**.
4. Select branch `main` and folder `/ (root)`.
5. Select **Save**.
6. Wait a few minutes for deployment.

The website URL will be:

```text
https://YOUR-USERNAME.github.io/fifa-world-cup-2026-bd/
```

After changing `live-config.js`, commit and push it again. GitHub Pages will redeploy automatically.

## Final Test Checklist

1. Open the GitHub Pages URL in Chrome.
2. Log in with `admin` / `admin123`.
3. Confirm that Bangladesh time changes every second.
4. Confirm that the main timer targets the next match.
5. During a match, confirm the live card says `Live data: API-Football` and displays provider scores.
6. Open the Worker URL and check for provider errors if scores are missing.
7. Test searches for `Brazil`, `Argentina`, `Norway`, and `Final`.
8. Test favorites, watch list, language switching, and dark mode.
9. Refresh the page and confirm browser history remains.

## Important Accuracy Notes

- FIFA and Google do not provide a public browser API through their search/result pages.
- The Worker uses API-Football as the live data provider; accuracy and update speed depend on that provider and your plan.
- The local schedule remains the fallback for match names, Bangladesh times, venues, and countdowns.
- If the provider returns no fixture, the site displays `--` instead of inventing a result.
- The current login system is a local browser profile, not secure community authentication.
