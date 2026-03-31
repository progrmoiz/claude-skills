# CLI Architecture — The Fixed Template

Every generated CLI follows this exact architecture. Only names and project-specific deps change.

## Directory Structure

```
{cli-name}/
├── src/
│   ├── index.ts              — Commander program, global opts, command registration
│   ├── lib/
│   │   ├── constants.ts      — VERSION, CLI_NAME, CONFIG_DIR_NAME
│   │   ├── config.ts         — XDG config, profiles, auth chain
│   │   ├── output.ts         — ExitCode, shouldOutputJson, formatters
│   │   ├── table.ts          — Hand-rolled table renderer
│   │   ├── tty.ts            — isInteractive() detection
│   │   ├── spinner.ts        — Braille spinner for async ops
│   │   ├── format.ts         — CSV and Markdown exporters
│   │   └── banner.ts         — ASCII art banner
│   ├── core/
│   │   ├── client.ts         — API client (HTTP or SDK)
│   │   └── types.ts          — Response type interfaces
│   └── commands/
│       ├── login.ts          — Auth setup
│       ├── logout.ts         — Remove credentials
│       ├── whoami.ts         — Show auth status
│       ├── doctor.ts         — Diagnostics
│       └── {command}.ts      — One file per command
├── package.json
├── tsconfig.json
├── build.mjs
├── .gitignore
├── LICENSE
├── SKILL.md
└── README.md
```

## Production Dependencies (max 5 + project SDK)

```json
{
  "commander": "^14.0.0",
  "@commander-js/extra-typings": "^14.0.0",
  "@clack/prompts": "^0.9.0",
  "picocolors": "^1.1.0"
}
```

**DO NOT ADD:** chalk, ora, boxen, figlet, cfonts, gradient-string, cli-table3, ink, blessed.

## Key Patterns

- **Dual output:** Every command supports `--json` for machines, pretty output for humans
- **TTY detection:** `shouldOutputJson()` auto-detects piped output
- **Auth chain:** `--api-key` flag > `ENV_VAR` > credentials file
- **XDG config:** `~/.config/{cli-name}/credentials.json` with `0600` permissions
- **Single bundle:** esbuild produces one `dist/cli.cjs` file (<500 KB target)
- **ASCII banner:** Always generated with `npx figlet-cli`, never hand-drawn
- **Hand-rolled output:** No table/chart/box libraries. `picocolors` + custom renderers only.
