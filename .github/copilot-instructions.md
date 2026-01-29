<!-- Copilot / AI agent instructions for contributors -->
# Copilot instructions — maxperrigo.github.io

Purpose: Help AI coding assistants make safe, minimal, high-impact edits for this static GitHub Pages site.

- **Big picture:** This is a single-page static site (root `index.html`) that showcases a rental property. Assets live under `images/` (subfolders: `hero`, `gallery`, `thumbnails/`, `thumbnails/living-room`). There's no build tool or package manager — changes are committed directly to the repo and published via GitHub Pages.

- **Key files & directories:**
  - `index.html` — single-page markup + embedded CSS and light client JS behavior. Example: the hero background is set with `url('images/hero/hero-background.jpg')`.
  - `Convert-To-WebP.ps1` — Windows PowerShell helper used to convert JPGs → WebP using ImageMagick. Use this instead of adding large raw images.
  - `CNAME` — domain mapping for GitHub Pages. Do NOT modify without explicit owner approval.
  - `images/` — source images and thumbnails. Maintain directory structure; many image paths in `index.html` are relative and rely on these names.

- **Common editing tasks & how to do them:**
  - Preview locally: run a static server from the repo root, e.g. `python -m http.server 8000` and open `http://localhost:8000`.
  - Convert/optimize images (Windows): ensure ImageMagick is installed, then run:

    PowerShell -ExecutionPolicy RemoteSigned -File Convert-To-WebP.ps1 -InputFolder images/gallery -OutputFolder webp -CreateThumbnails

    The script expects JPG/JPEG inputs and writes `.webp` outputs; it can also create thumbnails under a `thumbnails` folder.
  - Update hero image: replace the file in `images/hero/` (keep filename or update `index.html` reference). Prefer WebP versions for performance.
  - Update gallery: add optimized webp files to `images/gallery` (or the `webp` output and then update references). CSS relies on `.gallery-item` and `.gallery-item.featured` classes — preserve those semantics.

- **Conventions & project-specific rules:**
  - Keep edits minimal and local to the site — avoid introducing Node, bundlers, or new runtime environments.
  - Image workflow: convert high-resolution JPGs to WebP using `Convert-To-WebP.ps1` + ImageMagick; commit only optimized images or small thumbnails.
  - Use relative paths in `index.html` — do not convert them to absolute or externalized paths.
  - Keep `CNAME` unchanged unless instructed.

- **Deployment & CI notes:**
  - This repo is intended for GitHub Pages from the repository root. No CI or build step is present.

- **Debugging tips:**
  - Inspect `index.html` for inline CSS that controls layout (hero, gallery, lightbox). Many behaviors are CSS-driven; small CSS edits can adjust layout without JS changes.
  - For image problems verify the file name, folder, and case-sensitivity (GitHub Pages is case-sensitive).

- **When to open a PR vs direct commit:**
  - Open a PR for any content, layout, or image changes larger than a single-line copy edit. Small fixes (typos, tiny CSS tweaks) may be committed directly if urgent, but prefer PRs for review.

- **What not to do:**
  - Don’t add large raw images to the repo. Use the included conversion script and commit optimized outputs.
  - Don’t change `CNAME` or the publishing strategy without owner consent.

If anything here is unclear or you want additional examples (e.g., exact `index.html` snippets to update for gallery items), tell me which area to expand and I will iterate.
