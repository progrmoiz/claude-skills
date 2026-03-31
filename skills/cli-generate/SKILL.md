---
name: cli-generate
description: "Auto-generate agent-ready CLIs from any codebase in any language. Reads your project's source code — MCP servers, OpenAPI specs, Next.js, Express, Flask, Go, Rails, gRPC, GraphQL, or any API — and generates a complete TypeScript CLI with --json output, dual TTY/JSON mode, auth profiles, doctor command, and esbuild bundling. Use when asked to 'generate a CLI', 'create a CLI for this project', 'make this agent-ready', or 'add a CLI'."
---

# /cli-generate — Auto-Generate Agent-Ready CLIs

Generate a complete, production-grade CLI from any web/SaaS codebase in 5 phases.

**Quick start:** Run `/cli-generate` inside any project directory. It auto-detects the project type and generates a CLI.

**What it generates:**
- TypeScript CLI with Commander.js
- Dual output: pretty tables for humans, JSON for AI agents
- Auth system with multi-account profiles
- `doctor` command for diagnostics
- `whoami` command for auth status
- Single `.cjs` bundle via esbuild
- SKILL.md for AI agent discoverability
- README.md with install, commands, output modes
- `npx` instant execution ready

---

## Phase 1: Detect Project Type

Scan the codebase to determine what kind of project this is. Read [references/detection-matrix.md](references/detection-matrix.md) for the full detection logic.

**Two-tier detection:**

**Tier 1 (pattern-based):** Check for known frameworks first — MCP SDK, OpenAPI specs, Next.js routes, Express/Fastify. These have mechanical extraction rules.

**Tier 2 (LLM-native):** If Tier 1 doesn't match, READ THE CODE. Claude can understand any language — Python Flask, Go Gin, Ruby Rails, Rust Actix, gRPC protos, GraphQL schemas. Scan entry points, find route handlers/endpoints/RPC definitions, and extract the API surface.

**Launch parallel searches:**
1. Identify language from manifest files (package.json, go.mod, requirements.txt, Cargo.toml, etc.)
2. Check for Tier 1 matches (MCP SDK, OpenAPI spec, Next.js routes, Express/Fastify)
3. If no Tier 1 match: read entry points and routing files, extract endpoints by reading the actual code
4. Identify auth pattern (API key, Bearer token, env var, session, none)

**Output:** Detection report with:
- Project type and language
- List of endpoints/tools found (name, method, params, description)
- Auth pattern detected
- Suggested CLI name

Present findings to user. **Asking the user to describe the API is the LAST resort** — only if Claude genuinely cannot find endpoints after reading the code.

---

## Phase 2: Plan CLI Structure

Map each detected endpoint/tool to a CLI command. Read [references/command-patterns.md](references/command-patterns.md) for mapping rules.

**Generate a plan:**
```
CLI: {name}-cli
Commands:
  {name}-cli login          — Authenticate with API key
  {name}-cli logout         — Remove credentials
  {name}-cli whoami         — Show auth status
  {name}-cli doctor         — Run diagnostic checks
  {name}-cli {command-1}    — {description}
  {name}-cli {command-2}    — {description}
  ...

Global flags: --json, --quiet, --api-key, --profile, --verbose
Auth: {API_KEY_ENV_VAR} env var + ~/.config/{name}-cli/credentials.json
```

**Naming rules:**
- Command names: kebab-case, verb-noun or just noun (e.g., `list-users`, `send-email`, `mrr`)
- Skip internal/health/webhook endpoints
- Group related endpoints if >20 commands (e.g., `users list`, `users get`, `users create`)

Present plan to user. Wait for approval before generating code.

---

## Phase 3: Scaffold Infrastructure

Generate the fixed boilerplate files. These are **identical for every CLI** — only names change. Read [references/cli-architecture.md](references/cli-architecture.md) for the exact file contents.

**Files to generate:**

### Config files (project root)
- `package.json` — deps: commander, @commander-js/extra-typings, @clack/prompts, picocolors, esbuild (dev), tsx (dev), typescript (dev), @types/node (dev), plus any project-specific SDK
- `tsconfig.json` — ES2022, bundler moduleResolution, strict
- `build.mjs` — esbuild bundle to single `dist/cli.cjs` with shebang
- `.gitignore` — node_modules, dist, .env, *.tgz, .DS_Store
- `LICENSE` — MIT

### Infrastructure files (`src/lib/`)
- `constants.ts` — VERSION, CLI_NAME, CONFIG_DIR_NAME, USER_AGENT
- `config.ts` — XDG config, profiles, auth chain (flag > env > file), GlobalOpts
- `output.ts` — ExitCode enum, shouldOutputJson, outputResult, outputError, outputFormatted
- `table.ts` — hand-rolled column-aligned table renderer
- `tty.ts` — isInteractive() terminal detection
- `spinner.ts` — braille spinner for async operations
- `format.ts` — CSV and Markdown export formatters
- `banner.ts` — ASCII art banner (generated via `npx figlet-cli`)

**Customization points** (change per project):
- `constants.ts`: CLI_NAME, CONFIG_DIR_NAME
- `config.ts`: env var names (e.g., `{NAME}_API_KEY`, `{NAME}_PROFILE`), GlobalOpts fields
- `banner.ts`: ASCII art — **always generate with `npx figlet-cli -f "ANSI Shadow" "{cli-name}"`**. Never hand-draw ASCII art.
- `package.json`: name, description, keywords, repository, project-specific dependencies

After scaffolding, run `npm install` and `npm run build` to verify.

---

## Phase 4: Generate Commands

For each endpoint in the plan, generate a command file in `src/commands/`. Read [references/command-patterns.md](references/command-patterns.md) for the exact patterns per project type.

**Every command follows this pattern:**

```typescript
import { Command } from '@commander-js/extra-typings'
import type { GlobalOpts } from '../lib/config.js'
import { resolveApiKey } from '../lib/config.js'
import { shouldOutputJson, outputError, ExitCode } from '../lib/output.js'
import { withSpinner } from '../lib/spinner.js'

export function make{Name}Command(globalOpts: () => GlobalOpts): Command {
  return new Command('{command-name}')
    .description('{description}')
    .action(async (cmdOpts) => {
      const opts = globalOpts()
      const apiKey = resolveApiKey(opts)
      if (!apiKey) {
        outputError({ code: 'AUTH', message: 'No API key. Run `{cli-name} login` or set {ENV_VAR}.' }, opts)
        process.exit(ExitCode.AUTH_ERROR)
      }

      try {
        const result = await withSpinner('Fetching...', () => callApi(apiKey, cmdOpts), opts)

        if (shouldOutputJson(opts)) {
          process.stdout.write(JSON.stringify(result, null, 2) + '\n')
          return
        }

        // Human output (tables, formatted text, etc.)
      } catch (err) {
        outputError({ code: 'API', message: err instanceof Error ? err.message : 'Unknown error' }, opts)
        process.exit(ExitCode.API_ERROR)
      }
    })
}
```

**Also generate:**
- `src/commands/login.ts` — interactive auth with @clack/prompts
- `src/commands/logout.ts` — remove credentials
- `src/commands/whoami.ts` — show auth status
- `src/commands/doctor.ts` — CLI version, Node.js version, API key check, connection test
- `src/index.ts` — Commander program with all global options, register all commands
- `src/core/client.ts` — API client (HTTP fetch wrapper or SDK instantiation)
- `src/core/types.ts` — TypeScript interfaces for API responses

After generating, run `npm run build` and `npx tsc --noEmit` to verify.

---

## Phase 5: Verify & Ship

Run the verification checklist:

1. `npm run build` — clean build, produces `dist/cli.cjs`
2. `node dist/cli.cjs --version` — prints version
3. `node dist/cli.cjs --help` — shows all commands
4. `node dist/cli.cjs` (no args) — shows banner + help
5. `node dist/cli.cjs doctor --json` — outputs valid JSON
6. Bundle size check: `ls -lh dist/cli.cjs` (target: <500 KB)

**Generate SKILL.md** for AI agent discoverability:
- List all commands with JSON output schemas
- Document auth setup
- Include common workflows
- Document exit codes

**Generate README.md:**
- Banner from `banner.ts` (plain text, no ANSI)
- Command tables match Commander `.description()` strings
- Quick start: 2-3 commands to first value

Fix any build/type errors. Present the final CLI to the user.

---

## Gotchas

- **MCP Zod schemas don't map 1:1 to Commander options.** `z.array(z.string())` needs special handling — use `--items item1,item2` with `.split(',')`. `z.object()` needs `--data '{json}'` with `JSON.parse()`.
- **OpenAPI specs can have hundreds of endpoints.** Only generate commands for paths with `operationId`. Skip paths without it. If >30 commands, group by tag into subcommands.
- **Auth validation differs per project.** MCP servers often don't need auth. APIs need a health check endpoint. Don't assume `accounts.retrieve()` exists — find the lightest endpoint to validate the key.
- **Restricted API keys may lack permissions.** Always wrap auth validation in try/catch with a fallback to a simpler endpoint.
- **`picocolors` uses ANSI codes that break `padEnd()`.** Never call `.padEnd()` on colored strings. Pad first, then color.
- **ESM imports need `.js` extensions.** Every import must end with `.js` even though source is `.ts`.
- **`process.stdout.isTTY` is undefined when piped.** `shouldOutputJson` checks this — never skip it.
- **Don't add chalk, ora, boxen, figlet, or ink.** picocolors + hand-rolled output is the pattern.
- **Never hand-draw ASCII art.** Always run `npx figlet-cli -f "ANSI Shadow" "{name}"` via Bash.

---

## Rules

- **Always present the plan (Phase 2) before generating code.** Never skip to Phase 3.
- **The lib/ files are identical every time.** Don't reinvent them. Copy from the architecture reference.
- **Every command gets `--json` support.** No exceptions.
- **The build must pass before presenting to the user.** Run `npm run build` and fix errors.
- **5 production deps max** (excluding project-specific SDK): commander, @commander-js/extra-typings, @clack/prompts, picocolors, and optionally simple-ascii-chart.
- **Hand-roll visual output.** No table libraries, no chart libraries, no box-drawing libraries.
