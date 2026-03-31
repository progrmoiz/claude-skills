# Anti-Slop Rules

Synthesized from taste-skill (6.5K stars), unslop (Matt Shumer), ui-finesse-playbook, and 15+ articles on AI-generated design quality. These are empirical — patterns that make output instantly recognizable as AI-generated.

## The Test

> If you showed this to someone and said "AI made this," would they believe you immediately? If yes, that's the problem.

## Banned Patterns

### Typography
- Inter, Roboto, Arial, Open Sans, Helvetica as primary font
- System sans-serif fallbacks with no intentional choice
- Single font family everywhere (no display/body pairing)
- Timid weight range (400-500 only) — use the full 400-700 range intentionally
- Timid size progression (1.25x steps) — size jumps should be dramatic (2x-3x)
- Monospace as lazy shorthand for "technical/developer" aesthetic

### Color
- Purple-to-blue decorative gradients (the cardinal AI slop signal)
- Pure black `#000000` or pure white `#FFFFFF` — always tint
- Gray text on colored backgrounds — use a shade from the same hue
- 5+ evenly-distributed colors with no hierarchy — use 70-20-10 rule
- Neon accents on dark backgrounds as default "cool" aesthetic
- `background-clip: text` gradient on hero headlines as the main flourish
- Cyan/teal as default accent for developer tools

### Layout
- Everything centered with no asymmetry
- Identical card grids (same-sized cards with icon + heading + text, repeated)
- Cards nested inside cards
- Big rounded icons above every heading
- Standard 3-column pricing with "Most Popular" badge
- Hero metric layout template (big number, small label, gradient accent)
- Stats row under hero as reflex
- Logo/trust strip just because the page feels empty
- Huge viewport-height sections hiding thin content

### Borders & Surfaces
- Uniform 16px border-radius on all elements
- Generic 1px solid gray borders everywhere
- Frosted glass cards as default card treatment
- `backdrop-filter: blur()` on scrolling content (GPU performance killer)
- Harsh drop shadows (`shadow-md`, `rgba(0,0,0,0.3)`)
- Identical padding (24px) applied universally

### Animation
- `linear` or `ease-in-out` transitions (use custom cubic-bezier)
- Bounce or elastic easing — feels dated
- Generic fade-in on every element without orchestration
- Instant state changes without interpolation
- Animations with no functional purpose

### Copy
- "Build the future of..." / "Unleash your..." / "Best-in-class..."
- "Trusted by..." / "Loved by..." social proof defaults
- Generic CTAs: "Get Started", "Start Free Trial", "Book a Demo"
- "Simple, honest pricing" / "Plans that scale"
- Floating proof numbers like "2,400+", "99.9%", "4.9/5"
- "Everything your team needs" or any close variant

### Code-Level
- `position: fixed` + `backdrop-filter` as default nav recipe
- Absolutely positioned glow blobs behind the hero
- Stacking `linear-gradient` + `radial-gradient` as the main visual idea
- Viewport-height sizing to manufacture drama with minimal content
- `will-change: transform` on non-animating elements

### Domain-Specific
- DevTools: dark charcoal + cyan + code panes + monospace automatically
- Healthcare/HR: cream backgrounds + soft blue + friendly serif automatically
- Enterprise: SOC 2 / GDPR badges + "Talk to Sales" automatically

## Required Standards

Every artifact MUST have:

### Design
- Intentional typography with at least display + body (+ mono for data)
- CSS custom properties for all colors — no hardcoded hex in components
- Border-radius hierarchy (not the same radius everywhere)
- At least one orchestrated entrance animation
- Hover/focus/active states on all interactive elements
- Responsive layout (375px to 1400px+)

### Technical
- Semantic HTML (`main`, `section`, `article`, `header`, `nav`)
- `prefers-reduced-motion` media query wrapping all animations
- Zero console errors
- Print styles (`@media print`)
- Dark + light mode support via CSS variables (or commit to one with intention)

## Pre-Output Checklist

Before delivering, mentally scan:

1. Would a designer identify this as AI-generated? Where?
2. Is there ONE memorable visual element, or is everything equally "nice"?
3. Does the typography have clear size/weight hierarchy across 3+ levels?
4. Are the colors systematic (CSS variables) or scattered (random hex)?
5. Is the spacing varied (rhythm) or uniform (monotonous)?
6. Does the layout have any asymmetry or tension?
7. Do animations serve a purpose (entrance sequence, state feedback)?
8. Could you swap the content with any other product and it'd look the same? (Bad sign)

## The Meta-Rule

> Don't swap one stock SaaS move for another stock SaaS move. Break the pattern and make something genuinely different.

— Matt Shumer, unslop
