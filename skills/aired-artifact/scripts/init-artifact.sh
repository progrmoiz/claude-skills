#!/bin/bash
set -e

# --- Aired Artifact — Project Scaffolder ---
# Creates a React 18 + TypeScript + Tailwind + shadcn/ui + Framer Motion project
# with our anti-slop design system baked in.

PROJECT_NAME="${1:-artifact}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPONENTS_TARBALL="$SCRIPT_DIR/shadcn-components.tar.gz"

# Check Node version
NODE_VERSION=$(node -v 2>/dev/null | cut -d'v' -f2 | cut -d'.' -f1)
if [ -z "$NODE_VERSION" ] || [ "$NODE_VERSION" -lt 18 ]; then
  echo "Error: Node.js 18+ required. Current: $(node -v 2>/dev/null || echo 'not installed')"
  exit 1
fi

# Set Vite version based on Node
if [ "$NODE_VERSION" -ge 20 ]; then
  VITE_VERSION="latest"
else
  VITE_VERSION="5.4.11"
fi

# OS-aware sed
if [[ "$OSTYPE" == "darwin"* ]]; then
  SED_INPLACE="sed -i ''"
else
  SED_INPLACE="sed -i"
fi

echo "Scaffolding: $PROJECT_NAME"

# Create Vite project
npm create vite@latest "$PROJECT_NAME" -- --template react-ts
cd "$PROJECT_NAME"

# Pin Vite for Node 18
if [ "$NODE_VERSION" -lt 20 ]; then
  npm install -D "vite@$VITE_VERSION"
fi

# Clean up Vite defaults
$SED_INPLACE '/<link rel="icon"/d' index.html
$SED_INPLACE 's/<title>.*<\/title>/<title>'"$PROJECT_NAME"'<\/title>/' index.html

# Add Google Fonts (Geist) to index.html before </head>
$SED_INPLACE 's|</head>|  <link rel="preconnect" href="https://fonts.googleapis.com">\
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>\
  <link href="https://fonts.googleapis.com/css2?family=Geist:wght@400;500;600;700\&family=Geist+Mono:wght@400;500;600\&display=swap" rel="stylesheet">\
</head>|' index.html

echo "Installing dependencies..."
npm install

# Tailwind + PostCSS
npm install -D tailwindcss@3.4.1 postcss autoprefixer @types/node tailwindcss-animate

# shadcn/ui dependencies
npm install class-variance-authority clsx tailwind-merge lucide-react
npm install @radix-ui/react-slot

# Animation
npm install framer-motion

# Charts
npm install recharts

# Full Radix UI primitives
npm install @radix-ui/react-accordion @radix-ui/react-alert-dialog \
  @radix-ui/react-aspect-ratio @radix-ui/react-avatar \
  @radix-ui/react-checkbox @radix-ui/react-collapsible @radix-ui/react-context-menu \
  @radix-ui/react-dialog @radix-ui/react-dropdown-menu @radix-ui/react-hover-card \
  @radix-ui/react-label @radix-ui/react-menubar @radix-ui/react-navigation-menu \
  @radix-ui/react-popover @radix-ui/react-progress @radix-ui/react-radio-group \
  @radix-ui/react-scroll-area @radix-ui/react-select @radix-ui/react-separator \
  @radix-ui/react-slider @radix-ui/react-switch @radix-ui/react-tabs \
  @radix-ui/react-toast @radix-ui/react-toggle @radix-ui/react-toggle-group \
  @radix-ui/react-tooltip

# Additional shadcn deps
npm install sonner cmdk vaul embla-carousel-react react-day-picker \
  react-resizable-panels date-fns react-hook-form @hookform/resolvers zod \
  input-otp

# PostCSS config
cat > postcss.config.js << 'POSTCSS_EOF'
export default {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
POSTCSS_EOF

# Tailwind config with shadcn theme + our design tokens
cat > tailwind.config.js << 'TAILWIND_EOF'
/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: ["class"],
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    container: {
      center: true,
      padding: "2rem",
      screens: { "2xl": "1400px" },
    },
    extend: {
      fontFamily: {
        display: ['Geist', 'Plus Jakarta Sans', 'sans-serif'],
        body: ['Geist', 'Plus Jakarta Sans', 'sans-serif'],
        mono: ['Geist Mono', 'JetBrains Mono', 'monospace'],
      },
      colors: {
        border: "hsl(var(--border))",
        input: "hsl(var(--input))",
        ring: "hsl(var(--ring))",
        background: "hsl(var(--background))",
        foreground: "hsl(var(--foreground))",
        primary: {
          DEFAULT: "hsl(var(--primary))",
          foreground: "hsl(var(--primary-foreground))",
        },
        secondary: {
          DEFAULT: "hsl(var(--secondary))",
          foreground: "hsl(var(--secondary-foreground))",
        },
        destructive: {
          DEFAULT: "hsl(var(--destructive))",
          foreground: "hsl(var(--destructive-foreground))",
        },
        muted: {
          DEFAULT: "hsl(var(--muted))",
          foreground: "hsl(var(--muted-foreground))",
        },
        accent: {
          DEFAULT: "hsl(var(--accent))",
          foreground: "hsl(var(--accent-foreground))",
        },
        popover: {
          DEFAULT: "hsl(var(--popover))",
          foreground: "hsl(var(--popover-foreground))",
        },
        card: {
          DEFAULT: "hsl(var(--card))",
          foreground: "hsl(var(--card-foreground))",
        },
      },
      borderRadius: {
        lg: "var(--radius)",
        md: "calc(var(--radius) - 2px)",
        sm: "calc(var(--radius) - 4px)",
      },
      keyframes: {
        "accordion-down": {
          from: { height: "0" },
          to: { height: "var(--radix-accordion-content-height)" },
        },
        "accordion-up": {
          from: { height: "var(--radix-accordion-content-height)" },
          to: { height: "0" },
        },
        "fade-up": {
          from: { opacity: "0", transform: "translateY(24px)" },
          to: { opacity: "1", transform: "translateY(0)" },
        },
        "fade-in": {
          from: { opacity: "0" },
          to: { opacity: "1" },
        },
      },
      animation: {
        "accordion-down": "accordion-down 0.2s ease-out",
        "accordion-up": "accordion-up 0.2s ease-out",
        "fade-up": "fade-up 0.6s cubic-bezier(0.32, 0.72, 0, 1) both",
        "fade-in": "fade-in 0.4s cubic-bezier(0.32, 0.72, 0, 1) both",
      },
    },
  },
  plugins: [require("tailwindcss-animate")],
}
TAILWIND_EOF

# Our design system CSS — the anti-slop palette
cat > src/index.css << 'CSS_EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  :root {
    /* --- Aired Artifact Design System --- */
    /* Dark theme (default) */
    --background: 0 0% 4%;
    --foreground: 0 0% 95%;
    --card: 0 0% 6%;
    --card-foreground: 0 0% 95%;
    --popover: 0 0% 6%;
    --popover-foreground: 0 0% 95%;
    --primary: 0 0% 95%;
    --primary-foreground: 0 0% 5%;
    --secondary: 0 0% 12%;
    --secondary-foreground: 0 0% 95%;
    --muted: 0 0% 12%;
    --muted-foreground: 0 0% 55%;
    --accent: 0 0% 12%;
    --accent-foreground: 0 0% 95%;
    --destructive: 0 72% 51%;
    --destructive-foreground: 0 0% 95%;
    --border: 0 0% 14%;
    --input: 0 0% 14%;
    --ring: 0 0% 83%;
    --radius: 0.5rem;

    /* Surface tokens */
    --surface: 0 0% 6%;
    --surface-elevated: 0 0% 8%;
    --surface-hover: 0 0% 10%;

    /* Typography */
    --font-display: 'Geist', 'Plus Jakarta Sans', sans-serif;
    --font-body: 'Geist', 'Plus Jakarta Sans', sans-serif;
    --font-mono: 'Geist Mono', 'JetBrains Mono', monospace;

    /* Signature easing */
    --ease-out-expo: cubic-bezier(0.32, 0.72, 0, 1);
    --ease-spring: cubic-bezier(0.175, 0.885, 0.32, 1.1);
  }

  .light {
    --background: 40 20% 98%;
    --foreground: 220 14% 10%;
    --card: 0 0% 100%;
    --card-foreground: 220 14% 10%;
    --popover: 0 0% 100%;
    --popover-foreground: 220 14% 10%;
    --primary: 220 14% 10%;
    --primary-foreground: 0 0% 98%;
    --secondary: 220 10% 95%;
    --secondary-foreground: 220 14% 10%;
    --muted: 220 10% 95%;
    --muted-foreground: 220 5% 45%;
    --accent: 220 10% 95%;
    --accent-foreground: 220 14% 10%;
    --destructive: 0 84% 60%;
    --destructive-foreground: 0 0% 98%;
    --border: 220 10% 90%;
    --input: 220 10% 90%;
    --ring: 220 14% 10%;

    --surface: 220 10% 97%;
    --surface-elevated: 0 0% 100%;
    --surface-hover: 220 10% 95%;
  }

  * {
    @apply border-border;
  }

  body {
    @apply bg-background text-foreground;
    font-family: var(--font-body);
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    font-feature-settings: 'cv11', 'ss01';
  }

  h1, h2, h3, h4, h5, h6 {
    font-family: var(--font-display);
    letter-spacing: -0.03em;
    line-height: 1.08;
    text-wrap: balance;
  }

  h1 { font-weight: 700; }
  h2 { font-weight: 600; }
  h3, h4 { font-weight: 500; }

  code, pre, .font-mono {
    font-family: var(--font-mono);
  }

  @media (prefers-reduced-motion: reduce) {
    *, *::before, *::after {
      animation-duration: 0.01ms !important;
      animation-iteration-count: 1 !important;
      transition-duration: 0.01ms !important;
    }
  }

  @media print {
    body { background: white !important; color: black !important; }
    * { print-color-adjust: exact; -webkit-print-color-adjust: exact; }
  }
}

/*
 * Theme overrides: copy tokens from .aired/theme.css into :root above.
 * See .aired/theme.css for all available tokens.
 */
CSS_EOF

# utils.ts
mkdir -p src/lib
cat > src/lib/utils.ts << 'UTILS_EOF'
import { type ClassValue, clsx } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}
UTILS_EOF

# Path aliases in tsconfig.json
node -e "
const fs = require('fs');
const config = JSON.parse(fs.readFileSync('tsconfig.json', 'utf8'));
config.compilerOptions = config.compilerOptions || {};
config.compilerOptions.baseUrl = '.';
config.compilerOptions.paths = { '@/*': ['./src/*'] };
fs.writeFileSync('tsconfig.json', JSON.stringify(config, null, 2));
"

# Path aliases in tsconfig.app.json
node -e "
const fs = require('fs');
const path = 'tsconfig.app.json';
if (!fs.existsSync(path)) process.exit(0);
const content = fs.readFileSync(path, 'utf8');
const lines = content.split('\n').filter(line => !line.trim().startsWith('//'));
const jsonContent = lines.join('\n');
const config = JSON.parse(jsonContent.replace(/\/\*[\s\S]*?\*\//g, '').replace(/,(\s*[}\]])/g, '\$1'));
config.compilerOptions = config.compilerOptions || {};
config.compilerOptions.baseUrl = '.';
config.compilerOptions.paths = { '@/*': ['./src/*'] };
fs.writeFileSync(path, JSON.stringify(config, null, 2));
"

# Vite config with path aliases
cat > vite.config.ts << 'VITE_EOF'
import path from "path"
import react from "@vitejs/plugin-react"
import { defineConfig } from "vite"

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
})
VITE_EOF

# Extract shadcn components if tarball exists
if [ -f "$COMPONENTS_TARBALL" ]; then
  echo "Extracting shadcn/ui components..."
  tar -xzf "$COMPONENTS_TARBALL" -C src/
fi

# components.json for shadcn reference
cat > components.json << 'COMP_EOF'
{
  "$schema": "https://ui.shadcn.com/schema.json",
  "style": "default",
  "rsc": false,
  "tsx": true,
  "tailwind": {
    "config": "tailwind.config.js",
    "css": "src/index.css",
    "baseColor": "neutral",
    "cssVariables": true,
    "prefix": ""
  },
  "aliases": {
    "components": "@/components",
    "utils": "@/lib/utils",
    "ui": "@/components/ui",
    "lib": "@/lib",
    "hooks": "@/hooks"
  }
}
COMP_EOF

# Create .aired/theme.css with documented overrides
mkdir -p .aired
cat > .aired/theme.css << 'THEME_EOF'
/*
 * Aired Artifact — Theme Overrides
 *
 * Uncomment and modify any token to customize the design.
 * These override the default dark/light palettes.
 *
 * Colors use HSL format: <hue> <saturation>% <lightness>%
 * Example: --background: 220 14% 4%;
 */

/*
:root {
  --background: 0 0% 4%;
  --foreground: 0 0% 95%;
  --primary: 0 0% 95%;
  --primary-foreground: 0 0% 5%;
  --accent: 220 80% 60%;
  --accent-foreground: 0 0% 100%;
  --border: 0 0% 14%;
  --radius: 0.5rem;

  --font-display: 'Clash Display', sans-serif;
  --font-body: 'Satoshi', sans-serif;
  --font-mono: 'JetBrains Mono', monospace;
}
*/
THEME_EOF

# Starter App.tsx
cat > src/App.tsx << 'APP_EOF'
import { motion } from "framer-motion"

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
    opacity: 1,
    y: 0,
    transition: { duration: 0.6, ease: [0.32, 0.72, 0, 1] },
  },
}

export default function App() {
  return (
    <div className="min-h-screen bg-background text-foreground">
      <motion.main
        className="mx-auto max-w-5xl px-6 py-24"
        variants={stagger}
        initial="hidden"
        animate="show"
      >
        <motion.div variants={fadeUp}>
          <span className="inline-block rounded-full bg-secondary px-3 py-1 text-[10px] font-medium uppercase tracking-[0.2em] text-muted-foreground">
            Aired artifact
          </span>
        </motion.div>

        <motion.h1
          className="mt-6 text-5xl font-bold tracking-tight sm:text-7xl"
          variants={fadeUp}
        >
          Your artifact
          <br />
          <span className="text-muted-foreground">starts here.</span>
        </motion.h1>

        <motion.p
          className="mt-6 max-w-xl text-lg text-muted-foreground"
          variants={fadeUp}
        >
          Replace this with your content. The design system, components,
          and animations are ready to go.
        </motion.p>

        <motion.div
          className="mt-12 grid gap-4 sm:grid-cols-3"
          variants={fadeUp}
        >
          {[
            { label: "Components", value: "48+" },
            { label: "Bundle size", value: "~300KB" },
            { label: "Build time", value: "<30s" },
          ].map((stat) => (
            <div
              key={stat.label}
              className="rounded-lg bg-card p-6 ring-1 ring-border"
            >
              <p className="text-sm text-muted-foreground">{stat.label}</p>
              <p className="mt-1 text-2xl font-semibold font-mono tracking-tight">
                {stat.value}
              </p>
            </div>
          ))}
        </motion.div>
      </motion.main>
    </div>
  )
}
APP_EOF

# Clean up Vite's default files
rm -f src/App.css src/assets/react.svg public/vite.svg

# Minimal main.tsx
cat > src/main.tsx << 'MAIN_EOF'
import { StrictMode } from "react"
import { createRoot } from "react-dom/client"
import "./index.css"
import App from "./App"

createRoot(document.getElementById("root")!).render(
  <StrictMode>
    <App />
  </StrictMode>
)
MAIN_EOF

echo ""
echo "Done. Project ready at ./$PROJECT_NAME"
echo ""
echo "Next steps:"
echo "  cd $PROJECT_NAME"
echo "  npm run dev          # Preview"
echo "  # Edit src/App.tsx"
echo "  bash scripts/bundle-artifact.sh   # Bundle"
echo "  aired bundle.html    # Publish"
