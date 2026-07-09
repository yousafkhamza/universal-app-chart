# Releasing a New Chart Version

This repo is both the Helm chart source **and** the chart repository — the
packaged `.tgz` files and `index.yaml` live in `main` and are served by
GitHub Pages at `https://yousafkhamza.github.io/universal-app-chart`
(classic "Deploy from a branch" Pages, not an Actions-based Pages deploy —
that part is unchanged).

Releasing is now handled by a **manual** GitHub Actions workflow. Nothing
runs automatically on push — you decide exactly when a new version goes
out.

---

## Releasing via GitHub Actions (recommended)

1. Go to **Actions → Release Helm Chart → Run workflow**.
2. Fill in the inputs:
   | Input | What it does |
   |---|---|
   | `bump` | `patch` / `minor` / `major` auto-increments `Chart.yaml`'s `version`. Use `custom` to set an exact version. |
   | `custom_version` | Only used when `bump = custom`, e.g. `1.4.0`. |
   | `release_notes` | Free text — becomes the `CHANGELOG.md` entry and the GitHub Release body. |
   | `dry_run` | `true` = lint, render, and package only. Nothing is committed, tagged, or pushed. Use this to sanity-check before a real release. |
3. Run it. On a real (non-dry-run) run, the workflow will:
   - bump `version` (and `appVersion`) in `Chart.yaml`
   - `helm lint` and `helm template` (default values + `complete-utilized.yaml`) as a sanity check
   - `helm package .`
   - `helm repo index . --merge index.yaml` — regenerates the index without losing older versions
   - prepend an entry to `CHANGELOG.md`
   - commit + push `Chart.yaml`, `index.yaml`, `CHANGELOG.md`, and the new `.tgz` to `main`
   - create and push a `vX.Y.Z` git tag
   - create a GitHub Release with the notes you provided and the `.tgz` attached

GitHub Pages picks up the updated `index.yaml` within a minute or two of the
push — no separate deploy step needed.

**Always do a `dry_run: true` pass first** if you're at all unsure — it
exercises the whole pipeline (lint/template/package) without touching git.

### Version bump guide ([SemVer](https://semver.org/))

- **patch** — bug fixes, doc/example tweaks, no template behavior change
- **minor** — new feature/values field, backward compatible
- **major** — breaking change to `values.yaml` structure or rendered manifests

---

## Manual release (fallback, e.g. Actions is down or you need finer control)

```bash
git checkout main && git pull origin main

# 1. Bump Chart.yaml `version` (and `appVersion` if the default app version changed) — manual edit
# 2. Add an entry to CHANGELOG.md — manual edit

helm lint .
helm template release-check . > /tmp/rendered.yaml   # eyeball it
helm package .

helm repo index . \
  --url https://yousafkhamza.github.io/universal-app-chart \
  --merge index.yaml

git add Chart.yaml CHANGELOG.md universal-app-*.tgz index.yaml
git commit -m "release: vX.Y.Z"
git push origin main

git tag -a vX.Y.Z -m "vX.Y.Z"
git push origin vX.Y.Z
```

Then, optionally, create a GitHub Release from that tag manually (Releases
→ Draft a new release → pick the tag → attach the `.tgz`).

---

## Verifying a release (either path)

Treat yourself like an outside consumer pulling the chart fresh:

```bash
helm repo add universal-app https://yousafkhamza.github.io/universal-app-chart
helm repo update
helm search repo universal-app -l        # -l lists ALL versions — confirm the new one is there

helm install --dry-run --debug test-app universal-app/universal-app --version X.Y.Z
```

If `helm repo update` doesn't show the new version immediately, give Pages
a minute to rebuild and retry.

---

## Common mistakes

| Mistake | Result |
|---|---|
| Running `helm repo index .` **without** `--merge` | Wipes out every previous version from `index.yaml` |
| Deleting old `.tgz` files | Breaks `helm install --version <old>` for anyone pinned to it |
| Adding `index.yaml` / `*.tgz` to `.gitignore` | New releases silently never get committed — **this repo's `.gitignore` intentionally excludes them from ignore rules, don't re-add them** |
| Editing `index.yaml` by hand | Digest mismatch — Helm refuses to install. Always regenerate with `helm repo index` |
| Running the release workflow twice for the same version | Second run fails fast — the workflow checks for an existing `vX.Y.Z` tag before doing anything |
