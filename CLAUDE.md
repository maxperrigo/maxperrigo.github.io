# Perrigo Rentals — CLAUDE.md

## Project Overview

**Site:** www.perrigorentals.com  
**Owner:** Max Perrigo  
**Purpose:** Marketing website for a residential rental property. The primary audience is prospective renters who want to learn about the property, see photos, understand pricing and availability, and get in contact.

## Tech Stack

- Plain HTML, CSS, and JavaScript — no build tools, no frameworks, no npm
- All files must work when opened directly in a browser or served from a basic static host
- Keep dependencies minimal; prefer vanilla JS over libraries unless there is a strong reason

## Site Goals

1. Make a strong first impression — clean, professional, and welcoming
2. Give renters the information they need to decide: photos, bedrooms/bathrooms, square footage, amenities, location, and price
3. Make it easy to contact the owner or submit an inquiry
4. Be fast and mobile-friendly (many users will view on a phone)

## Intended Pages / Sections

- **Home / Hero** — attention-grabbing photo and tagline
- **Property Details** — specs, amenities list, floor plan if available
- **Photo Gallery** — high-quality images of every room and the exterior
- **Availability / Pricing** — rent amount, lease terms, move-in date
- **Location** — neighborhood description, nearby amenities, embedded map
- **Contact / Inquiry Form** — name, email, phone, message; no server-side required (mailto: or a free form service like Formspree is fine)

## Design Principles

- Mobile-first responsive layout
- Simple, readable typography — no more than two font families
- Neutral/warm color palette that feels like home, not a corporate site
- Images should be optimized for web (compressed, reasonable dimensions)
- Accessibility: use semantic HTML, alt text on all images, sufficient color contrast

## Code Conventions

- One HTML file per page; shared styles in `css/style.css`; shared scripts in `js/main.js`
- Use semantic HTML5 elements (`<header>`, `<main>`, `<section>`, `<footer>`, `<nav>`, etc.)
- No inline styles; keep all CSS in the stylesheet
- No `console.log` left in production code
- Indent with 2 spaces

## File Structure

```
perrigorentals/
├── index.html          # Home page (main entry point)
├── css/
│   └── style.css
├── js/
│   └── main.js
├── images/             # All photos and graphics
└── CLAUDE.md
```

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
| Availability | Currently unavailable — available September 2026 |
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

## Things to Avoid

- Do not add backend code, databases, or server-side logic — this is a static site
- Do not use heavy JavaScript frameworks (React, Vue, etc.) for what is essentially a brochure site
- Do not add cookie banners, analytics scripts, or tracking unless explicitly requested
- Do not invent property details — use the values in the Property Facts section above; ask the owner if something is missing
