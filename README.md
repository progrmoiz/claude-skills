# skills

**Production skills for Claude Code that output artifacts, not advice.**

These aren't prompt wrappers. They spawn parallel agents, search the web for real data, and produce structured outputs — social simulations and complete TypeScript CLIs from any codebase.

Built while running multiple SaaS products from the terminal.

## Install

```bash
npx skills add progrmoiz/skills
```

<details>
<summary>Other install methods</summary>

**Individual skills:**

```bash
npx skills add progrmoiz/skills/simulate
```

**Claude Code plugin system:**

```
/plugin marketplace add progrmoiz/skills
/plugin install progrmoiz-skills
```

**Manual (clone):**

```bash
git clone https://github.com/progrmoiz/skills.git ~/.claude/skills/progrmoiz-skills
```

</details>

## Skills

| Skill | What it does | Install |
|-------|-------------|---------|
| [simulate](./skills/simulate) | 12 personas react to your announcement over 3 rounds — form camps, shift opinions, surface objections | `npx skills add progrmoiz/skills/simulate` |
| [cli-generate](./skills/cli-generate) | Point at any codebase, get a complete TypeScript CLI with `--json`, auth, doctor command | `npx skills add progrmoiz/skills/cli-generate` |
| [estimate](./skills/estimate) | AI-era time estimates calibrated with research data from Anthropic, METR, and BSWEN studies | `npx skills add progrmoiz/skills/estimate` |

## Skill Details

### `/simulate` — Reaction Simulator

Simulate how 12 diverse personas react to your announcement before you ship it. Each persona has a unique profile (MBTI, influence weight, sentiment bias) and does their own web research for grounding. Over 3 rounds, they read each other's reactions, form camps, and shift opinions.

**Produces:** Verdict, opinion trajectory table, camp analysis, top 3 ranked objections with fixes, suggested rewrite.

**When to use:** Before pricing changes, product launches, policy shifts, layoffs, or any high-stakes public message.

**How it works:**
1. You paste the announcement
2. 12 personas are generated (5 mandatory archetypes + 7 dynamic based on announcement type)
3. Round 1 — each reacts independently (12 parallel agents, each searches the web)
4. Round 2 — each reads ALL Round 1 reactions, can shift stance, replies form (12 parallel agents)
5. Round 3 — final positions harden after seeing the full debate (12 parallel agents)
6. Report synthesizes everything into actionable insights

~36 agent calls. The magic is in Round 2 — that's where agents react to *each other* and camps emerge.

---

### `/cli-generate` — CLI Generator

Auto-generate a complete, production-grade TypeScript CLI from any codebase. Works with MCP servers, OpenAPI specs, Next.js, Express, Flask, Go, Rails, gRPC, GraphQL — or any API in any language.

**Produces:** Working CLI with Commander.js, dual output (pretty for humans, JSON for agents), multi-account auth, doctor command, single esbuild bundle, README, and SKILL.md.

**When to use:** When you want to make any web service agent-ready, or when you need a CLI for your API.

**How it works:**
1. Detect — scans codebase for endpoints (Tier 1: pattern matching for known frameworks, Tier 2: reads source code for any language)
2. Plan — maps endpoints to CLI commands, presents for approval
3. Scaffold — generates fixed infrastructure (auth, output, spinner, table renderer)
4. Generate — creates one command file per endpoint
5. Verify — builds, runs `--help`, checks bundle size

5 production deps max. Hand-rolled output. No chalk, no ora, no boxen.

---

### `/estimate` — Time Estimator

AI-era time estimates calibrated with real research data. Breaks tasks into subtasks with pre-AI vs post-AI effort, accounting for third-party API complexity and research-backed multipliers.

**Produces:** Subtask breakdown with individual estimates, assumptions, complexity factors.

**When to use:** Scoping work, giving time estimates to stakeholders, comparing pre-AI vs post-AI effort.

## What makes these different

| | Prompt-based skills | These skills |
|---|---|---|
| **Agents** | Single prompt, single response | 12–36 parallel agents per run |
| **Web access** | None | Searches Reddit, Twitter, competitor sites for real data |
| **Output** | Paragraphs of advice | Tables, scorecards, verdicts, working code |
| **Phases** | One-shot | Multi-phase with synthesis between each stage |
| **Interaction** | Agent talks to you | Agents talk to *each other* (`simulate` Round 2) |

## Contributing

Have a skill that produces artifacts instead of advice? PRs welcome.

## License

MIT
