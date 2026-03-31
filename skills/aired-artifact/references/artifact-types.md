# Artifact Types

Type-specific guidance for building different kinds of artifacts. Pick the closest match and follow its structure.

## Dashboard

### Structure
- Top: metric cards row (2-4 KPIs)
- Middle: primary chart or visualization (full width or 2/3)
- Bottom: data table or secondary charts
- Optional: sidebar with filters or navigation

### Layout
```tsx
<div className="mx-auto max-w-6xl px-6 py-12">
  {/* Metric cards */}
  <div className="grid grid-cols-2 gap-4 lg:grid-cols-4">
    {metrics.map(m => <MetricCard key={m.label} {...m} />)}
  </div>

  {/* Primary chart */}
  <div className="mt-8 rounded-lg bg-card p-6 ring-1 ring-border">
    <h3 className="text-sm font-medium text-muted-foreground">Revenue over time</h3>
    <div className="mt-4 h-[300px]">
      <RevenueChart data={data} />
    </div>
  </div>

  {/* Bento grid of secondary content */}
  <div className="mt-8 grid gap-4 lg:grid-cols-[2fr_1fr]">
    <div className="rounded-lg bg-card p-6 ring-1 ring-border">
      <DataTable />
    </div>
    <div className="space-y-4">
      <SmallChart />
      <ActivityList />
    </div>
  </div>
</div>
```

### Rules
- Numbers use mono font
- Round all displayed numbers (no float artifacts)
- Charts: use the shadcn `Chart` component (`@/components/ui/chart`) for theme-aware colors
- Interactive filters go in a top bar or sidebar, not scattered
- Data density is good — dashboards should feel information-rich, not sparse

---

## Report

### Structure
- Title block: title, subtitle, date, author
- Executive summary (2-3 sentences)
- Sections with headings, prose, and embedded charts/tables
- Footnotes or sources at bottom

### Layout
```tsx
<article className="mx-auto max-w-3xl px-6 py-24">
  <header>
    <span className="eyebrow">Q4 2025 Report</span>
    <h1 className="mt-4 text-5xl font-bold">Quarterly performance review</h1>
    <p className="mt-4 text-lg text-muted-foreground">
      Executive summary goes here.
    </p>
    <div className="mt-6 flex items-center gap-4 text-sm text-muted-foreground">
      <span>March 31, 2026</span>
      <span className="h-1 w-1 rounded-full bg-muted-foreground" />
      <span>Finance Team</span>
    </div>
  </header>

  <div className="mt-16 space-y-16">
    <section>
      <h2 className="text-2xl font-bold">Revenue</h2>
      <p className="mt-4 leading-relaxed text-muted-foreground">
        Prose content...
      </p>
      <div className="mt-8">
        <RevenueChart />
      </div>
    </section>
    {/* More sections */}
  </div>
</article>
```

### Rules
- Editorial layout — narrow max-width (768px), generous line-height
- Typography drives the hierarchy, not cards or borders
- Charts are inline with prose, not in separate panels
- Use `prose` or custom `leading-relaxed` for body text
- Print styles are critical — this will be PDF'd
- No animations needed (this is a document, not a page)

---

## Presentation

### Structure
- Slide-based: one `section` per slide
- Keyboard navigation: left/right arrows, space
- Slide types: title, content, data, quote, section divider

### Layout
```tsx
const [currentSlide, setCurrentSlide] = useState(0)

<div className="relative h-screen overflow-hidden bg-background">
  <div
    className="flex h-full transition-transform duration-500"
    style={{ transform: `translateX(-${currentSlide * 100}%)` }}
  >
    {slides.map((slide, i) => (
      <div key={i} className="flex h-full w-full flex-shrink-0 items-center justify-center px-16">
        {slide.content}
      </div>
    ))}
  </div>

  {/* Slide counter */}
  <div className="absolute bottom-8 left-1/2 -translate-x-1/2 font-mono text-sm text-muted-foreground">
    {currentSlide + 1} / {slides.length}
  </div>
</div>
```

### Rules
- One idea per slide — if it needs scrolling, split it
- Title slides: massive typography (text-7xl+), centered, minimal
- Content slides: left-aligned heading + right visual
- Data slides: one chart + one insight callout
- Navigate: arrow keys, click, and touch swipe
- Transitions: horizontal slide with `cubic-bezier(0.32, 0.72, 0, 1)` easing
- No speaker notes in the HTML (they're in comments or a separate file)

---

## Interactive Tool

### Structure
- Input section: controls, sliders, form fields
- Output section: live results, visualizations
- Optional: comparison or history

### Layout
```tsx
<div className="mx-auto max-w-4xl px-6 py-24">
  <h1 className="text-4xl font-bold">Calculator name</h1>
  <p className="mt-4 text-muted-foreground">Brief description.</p>

  <div className="mt-12 grid gap-8 lg:grid-cols-[1fr_1.5fr]">
    {/* Inputs */}
    <div className="space-y-6">
      <div>
        <Label>Amount</Label>
        <Input type="number" value={amount} onChange={...} />
      </div>
      <div>
        <Label>Rate (%)</Label>
        <Slider value={[rate]} onValueChange={...} min={0} max={20} step={0.1} />
        <span className="mt-1 block font-mono text-sm">{rate}%</span>
      </div>
    </div>

    {/* Results */}
    <div className="rounded-xl bg-card p-8 ring-1 ring-border">
      <p className="text-sm text-muted-foreground">Result</p>
      <p className="mt-2 font-mono text-4xl font-bold">${result.toLocaleString()}</p>
      <div className="mt-6 h-[200px]">
        <ResultChart data={chartData} />
      </div>
    </div>
  </div>
</div>
```

### Rules
- Results update immediately (no "Calculate" button needed)
- All displayed numbers must go through `toLocaleString()` or `Intl.NumberFormat`
- Slider readouts need explicit formatting (no float artifacts)
- Left: inputs. Right: outputs. Clear visual split.
- Use shadcn/ui form components (Input, Slider, Select, etc.)
- State lives in React `useState` — no external state management needed

---

## Landing Page

### Structure
- Hero: headline + subheadline + CTA + visual
- Social proof: logos or testimonials (only if real)
- Features: bento grid or asymmetric split sections
- CTA: closing section with action

### Layout
Follow the premium-web skill's patterns but bundle to single HTML. Key differences from a typical Next.js landing page:
- No routing — everything on one page with sections
- No CMS — content is hardcoded in React
- No SEO concerns — this is a shared artifact, not indexed
- Focus on visual impact over conversion optimization

### Rules
- Hero headline: text-5xl to text-7xl, font-bold, with one accent word
- Entrance animation on the hero (staggered fade-up)
- Features: use bento grid, not uniform 3-column cards
- Social proof: only include if the data is real. Don't fake it.
- CTA: one clear action, not three buttons
- Mobile-first: everything must work at 375px
