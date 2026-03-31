---
name: aired-artifact
description: "Builds premium React artifacts and publishes them to aired.sh as shareable single-file HTML. Anti-slop design system with shadcn/ui + Framer Motion."
when_to_use: "Use when asked to create dashboards, reports, presentations, interactive tools, landing pages, or shareable HTML artifacts. Triggers: 'build an artifact', 'create a dashboard', 'publish to aired', 'make a report', 'interactive tool'."
argument-hint: "<project-name or description>"
allowed-tools:
  - Bash(bash:*)
  - Bash(npm:*)
  - Bash(npx:*)
  - Bash(node:*)
  - Bash(aired:*)
  - Bash(cd:*)
  - Bash(ls:*)
  - Read
  - Write
  - Edit
  - Glob
  - Grep
---

# Aired Artifact Builder

Build premium React artifacts and publish them to shareable URLs on aired.sh.

**Stack:** React 18 + TypeScript + Tailwind + shadcn/ui + Framer Motion, bundled to single HTML.

## Workflow

### 1. Scaffold (if no project exists)

```bash
bash scripts/init-artifact.sh <project-name>
cd <project-name>
```

**Success criteria**: `package.json` exists, `npm run dev` starts without errors, `src/App.tsx` renders the starter template.

### 2. Commit to a direction

Before writing code, decide: what's the ONE thing someone will remember about this artifact? A dramatic typography treatment? An unusual layout? A rich data visualization? Say it out loud, then build toward it.

**Success criteria**: One sentence describing the artifact's signature moment. Written down, not just thought.

### 3. Build components

Write React components in `src/` — use shadcn/ui components from `@/components/ui/`, Framer Motion for animations, Tailwind for styling. Follow the design system in [references/design-system.md](references/design-system.md).

Read [references/anti-slop.md](references/anti-slop.md) before writing any UI code — it has the ban list.

**Success criteria**: Components render without errors. No banned patterns from anti-slop list. Typography uses display + body + mono hierarchy.

### 4. Preview and validate

```bash
npm run dev
```

Run through the pre-output checklist before proceeding:
- No banned fonts, colors, or patterns from the anti-slop list
- Typography has clear hierarchy (display > heading > body > caption)
- Colors use CSS variables, not hardcoded hex
- At least one orchestrated entrance animation sequence
- Semantic HTML (`main`, `section`, `article`, `header`)
- `prefers-reduced-motion` media query present
- Print styles (`@media print`) included
- Layout is responsive (works at 375px)
- Dark mode works (if applicable)
- No console errors
- All interactive elements have hover/focus/active states
- Would someone say "AI made this"? If yes, fix it.

**Success criteria**: All checklist items pass. Dev server runs clean with zero console errors.

### 5. Bundle to single HTML

```bash
bash scripts/bundle-artifact.sh
```

Verify before publishing:
```bash
ls -lh bundle.html  # Should be 200-800KB. Over 1MB = something wrong.
```

If bundle is too large, check for unnecessary dependencies or unoptimized images.

**Success criteria**: `bundle.html` exists and is under 1MB. Opening it directly in a browser renders correctly.

### 6. Publish to aired.sh

```bash
bash scripts/publish-artifact.sh
```

Parse the JSON output for the URL. Share it with the user.

**Success criteria**: JSON output contains a URL. The URL loads correctly in a browser.

### Updating an existing artifact

Edit source, re-bundle, then:
```bash
aired update <id> bundle.html --json
```

The aired CLI stores update tokens automatically.

## Design System

Read [references/design-system.md](references/design-system.md) for full tokens. Key rules:

### Typography
- **Display:** Geist (loaded via Google Fonts CDN)
- **Body:** Geist Sans
- **Mono:** Geist Mono (data, code, metrics)
- Headlines: `font-weight: 700`, `letter-spacing: -0.03em`, `line-height: 1.08`
- Body: `font-weight: 400`, `letter-spacing: -0.011em`, `line-height: 1.6`
- Size jumps must be dramatic (3x+), not timid (1.25x)

### Colors
- HSL-based tokens with tinted neutrals (grays carry brand hue)
- Dark default: `#0A0A0A` bg, warm gray surfaces
- Light available: `#FAFAF9` bg, crisp surfaces
- All colors via CSS variables — never hardcode hex in components

### Spacing
- 8px base grid: 4, 8, 12, 16, 24, 32, 48, 64, 96
- Section padding: `py-24` minimum — let it breathe
- Border-radius hierarchy: 4px (inputs) / 8px (cards) / 16px (modals) / 9999px (pills)

### Animation
- Custom easing: `cubic-bezier(0.32, 0.72, 0, 1)` — the skill's signature curve
- Staggered entrance: 0.08s delay between elements on page load
- Hover: `translateY(-2px)` + shadow increase + `scale(0.98)` on active
- Duration: 150ms fast, 250ms normal, 400ms slow
- Always wrap in `prefers-reduced-motion` media query

## Anti-Slop Rules

Read [references/anti-slop.md](references/anti-slop.md) for the full ban list. Critical bans:

- Inter, Roboto, Arial, Open Sans, Helvetica as primary font
- Purple-to-blue decorative gradients
- Pure `#000000` or `#FFFFFF` — always tint
- `linear` or `ease-in-out` transitions
- Bounce or elastic easing
- Cards nested inside cards
- Generic fade-in on every element without orchestration
- Centered-everything layouts with no asymmetry
- "Build the future of..." / "Unleash your..." / "Best-in-class..." copy
- Frosted glass as default card treatment
- Standard 3-column pricing with "Most Popular" badge
- Big rounded icons above every heading
- Stats row under hero as reflex
- `backdrop-filter: blur()` on scrolling content (GPU killer)

## Component Patterns

Read [references/component-patterns.md](references/component-patterns.md) for implementation details.

Key patterns:
- **Double-Bezel cards** — outer shell (subtle bg + hairline border + padding) wrapping inner core (distinct bg + inner shadow)
- **Pill buttons** — `rounded-full`, hover lift, nested icon circles
- **Metric cards** — muted 13px label, 28px/700 number, surface background
- **Bento grid** — asymmetric CSS Grid with varied cell sizes, not uniform cards
- **Eyebrow badges** — microscopic pill before headings (`text-[10px] uppercase tracking-[0.2em]`)

## Artifact Types

Read [references/artifact-types.md](references/artifact-types.md) for type-specific guidance:
- **Dashboard** — metric cards + charts + data tables, bento grid layout
- **Report** — editorial layout, long-scroll, section-based, print-optimized
- **Presentation** — slide-based, keyboard navigation, speaker notes
- **Interactive tool** — calculator/configurator/explorer with live state
- **Landing page** — hero + features + social proof + CTA

## User Theme Override

Users can create `.aired/theme.css` in their project to override design tokens:

```css
:root {
  --accent: oklch(0.65 0.2 145);
  --font-display: 'Clash Display', sans-serif;
}
```

The init script creates this file with all tokens documented. Import it in `src/index.css`.

## Technical Notes

- **shadcn/ui docs**: https://ui.shadcn.com/docs/components
- **Framer Motion**: use `motion.div` with `initial`, `animate`, `transition` props
- **Charts**: use the shadcn `Chart` component (`@/components/ui/chart`) — wraps Recharts with theme-aware colors and provides `ChartContainer`, `ChartTooltip`, `ChartTooltipContent`, `ChartLegend`, `ChartLegendContent`. For raw Recharts, import from `recharts`.
- **Icons**: Lucide React (pre-installed) — use sparingly, not above every heading
- **Bundle size**: typical artifact is 200-500KB. Over 1MB means something's wrong.
- **Fonts**: loaded via Google Fonts CDN in `index.html` — they inline during bundling

## Gotchas

- **Parcel chokes on external URLs during inlining:** The bundle script strips external `<link>` tags (Google Fonts CDN) before `html-inline` runs, then re-injects them via Node post-processing. If you add other external resources, they'll get stripped too — add them back in the post-process step of `bundle-artifact.sh`.
- **Bundle size blowup from unused Radix primitives:** The init script installs ALL Radix UI packages. Tree-shaking handles most of it, but if bundle exceeds 800KB, check if you're importing entire packages instead of specific components.
- **Font rendering in single-file HTML:** Fonts load from Google CDN at runtime — they're NOT inlined into the bundle. If the artifact is viewed offline, fonts fall back to system sans-serif. This is intentional (inlining fonts would add 500KB+).
- **`@` path alias breaks in Parcel:** Parcel doesn't read `tsconfig.json` paths natively. The bundle script installs `parcel-resolver-tspaths` and creates `.parcelrc` to handle this. If you see "Cannot resolve @/components/..." during bundling, check that `.parcelrc` exists.
- **HSL color format in CSS variables:** The design system uses raw HSL values without `hsl()` wrapper (e.g., `--background: 0 0% 4%`). In Tailwind, reference as `hsl(var(--background))`. Don't add `hsl()` inside the CSS variable itself — shadcn/ui expects unwrapped values.
