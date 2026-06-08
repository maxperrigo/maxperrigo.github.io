# Perrigo Rentals — CLAUDE.md

## Project Overview

**Site:** www.perrigorentals.com  
**Owner:** Max Perrigo  
**Purpose:** Marketing website for a residential rental property. The primary audience is prospective renters who want to learn about the property, see photos, understand pricing and availability, and get in contact.

## Tech Stack

- Plain HTML, CSS, and JavaScript — no build tools, no frameworks, no npm
- Single-page site (`index.html` at repo root) with embedded CSS and light client JS
- Deployed via GitHub Pages from the repository root
- All files must work when opened directly in a browser or served from a basic static host
- Keep dependencies minimal; prefer vanilla JS over libraries unless there is a strong reason

## Site Goals

1. Make a strong first impression — clean, professional, and welcoming
2. Give renters the information they need to decide: photos, bedrooms/bathrooms, square footage, amenities, location, and price
3. Make it easy to contact the owner or submit an inquiry
4. Be fast and mobile-friendly (many users will view on a phone)

## File Structure

```
perrigorentals/
├── index.html              # Single-page markup + embedded CSS and light client JS
├── Convert-To-WebP.ps1     # PowerShell helper: converts JPGs → WebP via ImageMagick
├── CNAME                   # Domain mapping for GitHub Pages — do NOT modify without owner approval
├── images/
│   ├── hero/               # Hero background (e.g. hero-background.jpg)
│   ├── gallery/            # Full-size gallery images
│   └── thumbnails/         # Thumbnail versions (including thumbnails/living-room)
└── CLAUDE.md
```

## Design Principles

- Mobile-first responsive layout
- Simple, readable typography — no more than two font families
- Neutral/warm color palette that feels like home, not a corporate site
- Images should be optimized for web (WebP preferred, use Convert-To-WebP.ps1)
- Accessibility: use semantic HTML, alt text on all images, sufficient color contrast

## Code Conventions

- No inline styles; keep CSS in the `<style>` block in `index.html`
- Use relative paths for all images — do not convert to absolute or external paths
- No `console.log` left in production code
- Indent with 2 spaces

## Common Tasks

**Preview locally:**
```
python -m http.server 8000
```
Then open `http://localhost:8000`.

**Convert/optimize images (Windows):**
Ensure ImageMagick is installed, then run:
```powershell
PowerShell -ExecutionPolicy RemoteSigned -File Convert-To-WebP.ps1 -InputFolder images/gallery -OutputFolder webp -CreateThumbnails
```
Script expects JPG/JPEG inputs and writes `.webp` outputs; also creates thumbnails under a `thumbnails/` folder.

**Update hero image:** Replace the file in `images/hero/` (keep filename or update the `url('images/hero/...')` reference in `index.html`). Prefer WebP.

**Update gallery:** Add optimized WebP files to `images/gallery`. CSS relies on `.gallery-item` and `.gallery-item.featured` classes — preserve those semantics.

## Property Facts (sourced from live site, 2026-06-07)

Use these when writing or editing site content — do not invent values.

| Field | Value |
|---|---|
| Address | 412 W 14th Ave, Ellensburg, WA |
| Monthly Rent | $1,900 |
| Security Deposit | $1,900 |
| Bedrooms | 3 |
| Bathrooms | 1.5 |
| Square Footage | 1,176 sq ft |
| Lot Size | 7,000 sq ft |
| Availability | Currently unavailable — available August 1, 2026 |
| Pets | Conditional (additional fees/rent apply) |

**Included in rent:** Trash/recycle pickup, single-car carport with storage

**Recent renovations:**
- Mohawk laminate flooring throughout
- Stainless steel kitchen appliances
- Quartz countertops
- LED lighting throughout
- Updated bathrooms
- Walk-in closet with slider door in primary bedroom

**Amenities:**
- Wood stove (energy savings)
- Individual room heating systems
- High-speed internet-ready underground wiring
- Fully fenced backyard
- Professional landscaping
- Attached carport

**Location highlights:** Walking distance to Central Washington University and downtown Ellensburg

**Contact:** No public phone/email listed — inquiries via "Schedule Tour" and "Send Message" buttons on the site

## Debugging Tips

- Inspect `index.html` for inline CSS that controls layout (hero, gallery, lightbox). Many behaviors are CSS-driven; small CSS edits can adjust layout without JS changes.
- For image problems verify the file name, folder, and case-sensitivity (GitHub Pages is case-sensitive).

## Things to Avoid

- Do not add backend code, databases, or server-side logic — this is a static site
- Do not use heavy JavaScript frameworks (React, Vue, etc.) for what is essentially a brochure site
- Do not add cookie banners, analytics scripts, or tracking unless explicitly requested
- Do not invent property details — use the values in the Property Facts section above; ask the owner if something is missing
- Do not add large raw images to the repo — use Convert-To-WebP.ps1 and commit optimized outputs only
- Do not modify `CNAME` or the GitHub Pages publishing strategy without owner consent
