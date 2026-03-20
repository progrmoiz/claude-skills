# Agent Skills

A collection of skills for AI coding agents. Skills are packaged instructions and scripts that extend agent capabilities.

Skills follow the [Agent Skills format](https://github.com/anthropics/claude-code/blob/main/docs/skills.md).

## Available Skills

### estimate

AI-era time estimates — how long tasks actually take with AI assistance. Calibrated with real research data from Anthropic's 100K conversation study, METR's RCT, and BSWEN's 3-month case study.

**Use when:**
- Scoping a task before starting work
- Giving time estimates to stakeholders
- Comparing pre-AI vs post-AI effort

**Features:**
- Breakdown by subtask with individual estimates
- Assumptions listed explicitly
- Third-party API and complexity multipliers
- Research-backed calibration data

## Installation

```
npx skills add progrmoiz/agent-skills
```

## Usage

Skills are automatically available once installed. The agent will use them when relevant tasks are detected.

**Examples:**

```
/estimate build a Stripe webhook handler with retry logic
```

```
/estimate migrate the auth system from JWT to session tokens
```

## Skill Structure

Each skill contains:
- `SKILL.md` - Instructions for the agent
- `scripts/` - Helper scripts for automation (optional)
- `references/` - Supporting documentation (optional)

## License

MIT
