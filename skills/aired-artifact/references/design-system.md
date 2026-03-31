# Design System

The Aired Artifact design system. Opinionated, anti-slop, production-grade.

## Typography

### Font Stack
- **Display (headings):** Geist — Vercel's commissioned typeface. Distinctive, geometric, not overused.
- **Body:** Geist — same family, clean at smaller sizes.
- **Mono (data/code):** Geist Mono — tabular figures, ligatures.
- **Fallback:** Plus Jakarta Sans + JetBrains Mono (if Geist unavailable).

### Scale
| Role | Size | Weight | Letter-spacing | Line-height |
|------|------|--------|----------------|-------------|
| Display (h1) | text-5xl / text-7xl | 700 | -0.03em | 1.08 |
| Heading (h2) | text-3xl / text-4xl | 600 | -0.02em | 1.1 |
| Subheading (h3) | text-xl / text-2xl | 500 | -0.01em | 1.2 |
| Body | text-base (16px) | 400 | -0.011em | 1.6 |
| Caption/Label | text-sm (14px) | 500 | 0 | 1.4 |
| Overline/Eyebrow | text-[10px] | 500 | 0.2em | 1.2 |
| Mono/Data | text-base or text-2xl | 600 | -0.02em | 1.2 |

### Rules
- Size jumps between levels must be 1.5x minimum (h1 is 3-4x body)
- Never use font-weight 300 (too thin) or 800/900 (too heavy)
- OpenType features: `font-feature-settings: 'cv11', 'ss01'`
- Headings: `text-wrap: balance` for natural line breaks
- Mono for numbers, data, metrics — never body text

## Color System

### Dark Theme (Default)
```css
:root {
  --background: 0 0% 4%;        /* #0A0A0A — near-black, not pure */
  --foreground: 0 0% 95%;       /* #F2F2F2 — warm off-white */
  --card: 0 0% 6%;              /* #0F0F0F — surface */
  --card-foreground: 0 0% 95%;
  --muted: 0 0% 12%;            /* #1F1F1F — recessed */
  --muted-foreground: 0 0% 55%; /* #8C8C8C — secondary text */
  --border: 0 0% 14%;           /* #242424 — subtle */
  --surface: 0 0% 6%;
  --surface-elevated: 0 0% 8%;
  --surface-hover: 0 0% 10%;
}
```

### Light Theme
```css
.light {
  --background: 40 20% 98%;     /* #FAFAF9 — warm white */
  --foreground: 220 14% 10%;    /* #171B22 — not pure black */
  --card: 0 0% 100%;
  --muted: 220 10% 95%;
  --muted-foreground: 220 5% 45%;
  --border: 220 10% 90%;
  --surface: 220 10% 97%;
  --surface-elevated: 0 0% 100%;
  --surface-hover: 220 10% 95%;
}
```

### Tinted Neutrals Technique
All grays carry a subtle brand-hue tint at 0.01 chroma. This creates subconscious cohesion — the eye reads "designed" not "default." In HSL: add 1-2% saturation toward your brand hue on every neutral.

### Accent Colors
Pick ONE accent. Use it sparingly — CTAs, active states, focus rings. Examples:
- Blue: `220 80% 55%` — safe, professional
- Orange: `25 95% 53%` — energetic, warm
- Green: `160 84% 39%` — growth, success
- Custom: define in `.aired/theme.css`

### Rules
- Never use pure `#000000` or `#FFFFFF` — always tint slightly
- Text on colored backgrounds: use a shade from the same hue family
- Contrast ratio: 4.5:1 minimum for body text, 3:1 for large text
- Status colors: green=success, amber=warning, red=error — don't repurpose

### Data Visualization Ramps

9 color ramps for charts, categories, and data-heavy artifacts. Each has 7 stops from lightest (50) to darkest (900).

| Ramp | 50 | 200 | 400 | 600 | 800 | 900 |
|------|-----|-----|-----|-----|-----|-----|
| Purple | #EEEDFE | #AFA9EC | #7F77DD | #534AB7 | #3C3489 | #26215C |
| Teal | #E1F5EE | #5DCAA5 | #1D9E75 | #0F6E56 | #085041 | #04342C |
| Coral | #FAECE7 | #F0997B | #D85A30 | #993C1D | #712B13 | #4A1B0C |
| Pink | #FBEAF0 | #ED93B1 | #D4537E | #993556 | #72243E | #4B1528 |
| Gray | #F1EFE8 | #B4B2A9 | #888780 | #5F5E5A | #444441 | #2C2C2A |
| Blue | #E6F1FB | #85B7EB | #378ADD | #185FA5 | #0C447C | #042C53 |
| Green | #EAF3DE | #97C459 | #639922 | #3B6D11 | #27500A | #173404 |
| Amber | #FAEEDA | #EF9F27 | #BA7517 | #854F0B | #633806 | #412402 |
| Red | #FCEBEB | #F09595 | #E24B4A | #A32D2D | #791F1F | #501313 |

**Pairing rules:**
- Light mode: **50** fill + **600** stroke + **800** title text + **600** subtitle text
- Dark mode: **800** fill + **200** stroke + light text from the same ramp
- Text on colored backgrounds always uses a darker stop **from the same ramp** — never black, never generic gray
- Max 2-3 ramps per artifact. More = visual noise.
- Color encodes **meaning**, not sequence — don't rainbow through them
- Gray for neutral/structural elements
- Blue/green/amber/red carry semantic weight (info/success/warning/error) — use purple/teal/coral/pink for general categories
- Use these ramps in `ChartConfig` colors for consistent multi-chart artifacts

## Spacing

### 8px Grid
All spacing in multiples of 8px:
| Token | Value | Use |
|-------|-------|-----|
| `gap-1` | 4px | Icon-to-text, tight groups |
| `gap-2` | 8px | Related items within a component |
| `gap-3` | 12px | Component internal padding |
| `gap-4` | 16px | Card padding, form field spacing |
| `gap-6` | 24px | Section content spacing |
| `gap-8` | 32px | Card-to-card gaps |
| `gap-12` | 48px | Section breaks |
| `gap-16` | 64px | Major section separations |
| `gap-24` | 96px | Top-level section padding |

### Section Padding
- `py-24` minimum for major sections — let it breathe
- `py-16` for sub-sections within a section
- Hero sections: `py-32` or more

### Border Radius Hierarchy
| Element | Radius | Tailwind |
|---------|--------|----------|
| Inputs, small elements | 4px | `rounded` |
| Cards, panels | 8px | `rounded-lg` |
| Modals, large panels | 16px | `rounded-2xl` |
| Pills, tags, badges | 9999px | `rounded-full` |

Never use the same radius everywhere. The hierarchy creates visual differentiation.

## Shadows

### Dark Theme
Shadows are almost invisible on dark backgrounds. Use border + elevation instead:
```css
.card { ring-1 ring-border }
.card-elevated { ring-1 ring-border bg-surface-elevated }
.card-hover:hover { ring-1 ring-foreground/10 bg-surface-hover }
```

### Light Theme
```css
.shadow-subtle { box-shadow: 0 1px 2px rgba(0,0,0,0.04) }
.shadow-card { box-shadow: 0 4px 12px rgba(0,0,0,0.06) }
.shadow-elevated { box-shadow: 0 12px 40px rgba(0,0,0,0.08) }
```

Never use harsh dark shadows. Keep them diffused and soft.

## Motion

### Signature Easing
```css
--ease-out-expo: cubic-bezier(0.32, 0.72, 0, 1);
```
Use this for ALL transitions unless you have a specific reason not to. It decelerates naturally.

### Duration Scale
| Speed | Duration | Use |
|-------|----------|-----|
| Instant | 100ms | Hover color changes |
| Fast | 150ms | Button states, toggles |
| Normal | 250ms | Card hovers, panel opens |
| Slow | 400ms | Page transitions, modals |
| Entrance | 600ms | Staggered load animations |

### Entrance Pattern (Framer Motion)
```tsx
const stagger = {
  hidden: { opacity: 0 },
  show: {
    opacity: 1,
    transition: { staggerChildren: 0.08 },
  },
}

const fadeUp = {
  hidden: { opacity: 0, y: 24 },
  show: {
    opacity: 1, y: 0,
    transition: { duration: 0.6, ease: [0.32, 0.72, 0, 1] },
  },
}
```

### Hover Pattern
```tsx
<motion.div
  whileHover={{ y: -2, transition: { duration: 0.2 } }}
  whileTap={{ scale: 0.98 }}
>
```

### Rules
- One orchestrated entrance per page — not scattered micro-animations
- Stagger delay: 0.08s between elements
- Never animate `width`, `height`, `margin`, `padding` — use `transform` and `opacity`
- Always respect `prefers-reduced-motion`
- No bounce, no elastic, no spring with damping < 15

## Mobile Edge Cases

- All form inputs must be `font-size: 16px` minimum — iOS Safari zooms the viewport on focus below 16px
- Touch targets: 44×44px minimum (Apple HIG) — buttons, links, icon buttons
- Never use `h-screen` for full-height sections — use `min-h-[100dvh]` to prevent layout jump on mobile Safari
- Grid layouts: use `minmax(0, 1fr)` instead of bare `1fr` to prevent content overflow
