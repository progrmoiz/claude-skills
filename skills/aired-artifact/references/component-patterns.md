# Component Patterns

Premium component patterns for Aired Artifacts. Based on taste-skill's Double-Bezel technique, Stripe/Linear design language, and production-tested shadcn/ui patterns.

## Cards

### Double-Bezel Card (Premium Default)
Two nested layers create physical depth — like a glass plate in an aluminum tray.

```tsx
<div className="rounded-2xl bg-muted/50 p-1.5 ring-1 ring-border">
  <div className="rounded-[calc(1rem-6px)] bg-card p-6 shadow-[inset_0_1px_1px_rgba(255,255,255,0.06)]">
    <h3 className="text-lg font-semibold">Card title</h3>
    <p className="mt-2 text-sm text-muted-foreground">Card content</p>
  </div>
</div>
```

- Outer shell: subtle bg + hairline ring + small padding + large radius
- Inner core: card bg + content padding + inner highlight shadow + smaller radius
- The radius math: inner = outer - padding (`calc(1rem - 6px)`)

### Metric Card
For dashboard numbers and KPIs.

```tsx
<div className="rounded-lg bg-muted/50 p-5">
  <p className="text-[13px] font-medium text-muted-foreground">Revenue</p>
  <p className="mt-1 font-mono text-2xl font-semibold tracking-tight">$42,891</p>
  <p className="mt-1 text-xs text-emerald-500">+12.5% from last month</p>
</div>
```

- Muted label (13px) above, large mono number below
- Surface background, no border (distinct from bordered cards)
- Use in grids of 2-4 with `gap-4`
- Change indicators: green for up, red for down, gray for neutral

### Simple Card (When Double-Bezel Is Too Much)
```tsx
<div className="rounded-lg bg-card p-6 ring-1 ring-border transition-colors hover:bg-card/80">
  <h3 className="font-semibold">Title</h3>
  <p className="mt-2 text-sm text-muted-foreground">Content</p>
</div>
```

## Buttons

### Primary (Pill)
```tsx
<button className="inline-flex items-center gap-2 rounded-full bg-foreground px-6 py-3 text-sm font-medium text-background transition-all hover:-translate-y-0.5 hover:shadow-lg active:scale-[0.98]">
  Get started
  <span className="flex h-6 w-6 items-center justify-center rounded-full bg-background/10">
    <ArrowRight className="h-3.5 w-3.5" />
  </span>
</button>
```

- Fully rounded pill shape
- Hover: lift (`-translate-y-0.5`) + shadow
- Active: press down (`scale-[0.98]`)
- Nested icon circle creates internal kinetic tension on hover

### Secondary
```tsx
<button className="rounded-full border border-border px-6 py-3 text-sm font-medium transition-colors hover:bg-muted">
  Learn more
</button>
```

### Ghost
```tsx
<button className="rounded-lg px-4 py-2 text-sm text-muted-foreground transition-colors hover:bg-muted hover:text-foreground">
  Cancel
</button>
```

## Layout

### Bento Grid
Asymmetric grid with varied cell sizes. Never uniform cards.

```tsx
<div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
  <div className="sm:col-span-2 lg:col-span-2">
    {/* Wide card — hero feature or chart */}
  </div>
  <div>
    {/* Narrow card — stat or secondary info */}
  </div>
  <div>
    {/* Narrow card */}
  </div>
  <div className="sm:col-span-2">
    {/* Wide card — data table or secondary feature */}
  </div>
</div>
```

### Split Layout (Asymmetric)
```tsx
<div className="grid grid-cols-1 gap-12 lg:grid-cols-[1fr_1.5fr]">
  <div>
    <h2 className="text-3xl font-bold">Left column</h2>
    <p className="mt-4 text-muted-foreground">Context</p>
  </div>
  <div>
    {/* Visual, chart, or interactive content — wider side */}
  </div>
</div>
```

### Section Structure
```tsx
<section className="py-24">
  <div className="mx-auto max-w-5xl px-6">
    <motion.div variants={stagger} initial="hidden" animate="show">
      <motion.div variants={fadeUp}>
        <span className="eyebrow">Section label</span>
      </motion.div>
      <motion.h2 variants={fadeUp} className="mt-4 text-4xl font-bold">
        Section heading
      </motion.h2>
      <motion.div variants={fadeUp} className="mt-12">
        {/* Section content */}
      </motion.div>
    </motion.div>
  </div>
</section>
```

## Eyebrow Badge
Tiny pill above headings to categorize or label sections.

```tsx
<span className="inline-block rounded-full bg-muted px-3 py-1 text-[10px] font-medium uppercase tracking-[0.2em] text-muted-foreground">
  Overview
</span>
```

## Data Table
```tsx
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table"

<div className="rounded-lg border border-border">
  <Table>
    <TableHeader>
      <TableRow className="hover:bg-transparent">
        <TableHead className="text-xs font-medium uppercase tracking-wider text-muted-foreground">Name</TableHead>
        <TableHead className="text-right text-xs font-medium uppercase tracking-wider text-muted-foreground">Amount</TableHead>
      </TableRow>
    </TableHeader>
    <TableBody>
      <TableRow>
        <TableCell className="font-medium">Item name</TableCell>
        <TableCell className="text-right font-mono">$1,234</TableCell>
      </TableRow>
    </TableBody>
  </Table>
</div>
```

## Navigation

### Floating Pill Nav
```tsx
<nav className="fixed left-1/2 top-6 z-50 -translate-x-1/2">
  <div className="flex items-center gap-1 rounded-full bg-background/80 px-2 py-1.5 ring-1 ring-border backdrop-blur-xl">
    <a href="#" className="rounded-full px-4 py-1.5 text-sm font-medium transition-colors hover:bg-muted">
      Home
    </a>
    <a href="#" className="rounded-full px-4 py-1.5 text-sm text-muted-foreground transition-colors hover:bg-muted hover:text-foreground">
      About
    </a>
    <button className="ml-2 rounded-full bg-foreground px-4 py-1.5 text-sm font-medium text-background">
      Contact
    </button>
  </div>
</nav>
```

Note: only use `backdrop-filter` on fixed/sticky elements, never scrolling content.

## Charts

Use the shadcn `Chart` component for theme-aware charts. It wraps Recharts with automatic dark/light color handling.

```tsx
import { Bar, BarChart, CartesianGrid, XAxis } from "recharts"
import { type ChartConfig, ChartContainer, ChartTooltip, ChartTooltipContent } from "@/components/ui/chart"

const chartConfig = {
  revenue: { label: "Revenue", color: "hsl(var(--foreground))" },
} satisfies ChartConfig

<ChartContainer config={chartConfig} className="h-[300px] w-full">
  <BarChart data={data}>
    <CartesianGrid vertical={false} />
    <XAxis dataKey="name" tickLine={false} tickMargin={10} axisLine={false} />
    <ChartTooltip content={<ChartTooltipContent />} />
    <Bar dataKey="revenue" fill="var(--color-revenue)" radius={[4, 4, 0, 0]} />
  </BarChart>
</ChartContainer>
```

`ChartContainer` injects CSS variables per dataset key (e.g. `--color-revenue`) from the config, handles responsive sizing, and applies theme colors automatically. No manual `hsl(var(...))` on every axis/tooltip.

## Responsive Breakpoints

| Breakpoint | Width | Behavior |
|-----------|-------|----------|
| Default | < 640px | Single column, `px-4`, full-width everything |
| `sm` | 640px+ | 2-column grids appear |
| `md` | 768px+ | Navigation expands, padding increases |
| `lg` | 1024px+ | 3-column grids, split layouts |
| `xl` | 1280px+ | Max width container kicks in |

Mobile: `w-full px-4 py-8`. Remove all rotations, overlaps, and asymmetric margins below `md`.
