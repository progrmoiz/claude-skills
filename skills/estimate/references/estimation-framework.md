# Estimation Framework (AI-Assisted)

Calibrated from: Anthropic productivity study (100K conversations), METR RCT (16 devs, 246 tasks), BSWEN case study (3 months solo dev), GitClear cohort analysis, and real-world build times from developers on X.

## Complexity Tiers

| Tier | Description | Examples |
|------|-------------|----------|
| **Trivial** | Single-file changes, config, copy | Env vars, text changes, rename, add dependency |
| **Simple** | Boilerplate, CRUD, standard patterns | REST endpoints, form components, DB models, scaffolding |
| **Medium** | Multi-file features, some decisions | Auth flows, dashboards, payment integration |
| **Complex** | Architecture decisions, edge cases, integrations | Search systems, data pipelines, state machines, OAuth |
| **Novel** | Research required, no clear pattern | ML pipelines, protocol implementations, new algorithms |

## AI-Assisted Time Estimates

Total time = AI generation + human prompting + review + testing + debugging.

| Tier | Estimate | Speedup vs Pre-AI | Confidence |
|------|----------|-------------------|------------|
| Trivial | **2–5 min** | ~10x | High — all sources agree |
| Simple | **10–20 min** | ~5-10x | High — BSWEN + Anthropic + anecdotes |
| Medium | **30–90 min** | ~3-5x | Medium — varies by task |
| Complex | **1.5–4 hours** | ~2x | Medium — BSWEN 2x for complex logic |
| Novel | **1–2 days** | ~1x (no speedup) | High — BSWEN + METR both confirm |

## Scope-to-Time Quick Reference

| Scope | Estimate |
|-------|----------|
| Single function/fix | 2–10 min |
| Small feature (1 component + API) | 20–60 min |
| Medium feature (3–5 files, new UI) | 1–3 hours |
| Large feature (new section, 10+ files) | 4–12 hours |
| New project scaffold | 30–90 min |
| Full MVP | 3–10 days |

## Where Time Actually Goes

| Activity | % of Total | Notes |
|----------|-----------|-------|
| Prompting & generation | 15–25% | Describing what to build, AI writes code |
| Review & understanding | 25–35% | Reading AI output, verifying correctness — this is the biggest chunk |
| Iteration & debugging | 20–30% | "Not quite right" cycles — AI gets 80% right first pass, last 20% costs disproportionate time |
| Testing & QA | 10–15% | Running it, edge cases, manual verification |
| Integration & deploy | 5–15% | Connecting to existing code, config, deployment |

## Multipliers

Adjust the base estimate with these:

| Factor | Multiplier | Source |
|--------|-----------|--------|
| Boilerplate/scaffolding | **0.1x** (10x faster) | BSWEN, universal agreement |
| Well-known stack (strong AI training data) | **0.7–0.8x** | Anthropic — AI better on popular frameworks |
| Unfamiliar codebase | **1.5–2x** | METR — experienced devs in own codebases were SLOWER with AI |
| Third-party API integration | **1.5–2x** | Stripe, OAuth, email — APIs don't care about your AI |
| Database migrations | **1.3–1.5x** | Data integrity concerns, rollback planning |
| UI/design precision | **1.3–1.5x** | Pixel-perfect, animations, responsive |
| Architecture/planning work | **1x** (no speedup) | BSWEN: "no significant speedup" |
| Multiple iteration rounds | **1.5–2x** | Complex business logic AI keeps getting wrong |

## Key Calibration Sources

**Anthropic (Nov 2025):** 100K real conversations. 80% task-level time savings. But they admit: doesn't account for review/validation time outside the chat. Software engineering sees up to 90% savings on individual tasks.

**METR RCT (2025):** 16 experienced devs, 246 tasks in codebases they knew for 5+ years. AI made them 19% SLOWER. They believed they were 20% faster. Lesson: familiar codebases + experienced devs ≠ automatic speedup.

**BSWEN Case Study (Feb 2026):** Solo dev, 3 months. Overall 3x speedup. Boilerplate 10x, multi-role 5x, feature variants 4x, debugging 2x, planning 0x.

**Anthropic Internal (132 engineers):** 67% more PRs/day, but org-level delivery metrics didn't move. Individual speed ≠ team throughput.

**Past RCTs cited by Anthropic:** Time savings of 56%, 40%, 26%, 14%, and negative across different studies.

## Calibration Rules

1. **Twitter anecdotes skew high.** People share wins, not the 3 hours they spent debugging AI output. Use them as the optimistic bound, not the estimate.
2. **Anthropic's 80% is per-task, not per-project.** A project has coordination, review, and integration that don't compress. Real project speedup is 2-3x.
3. **The METR slowdown is real for expert-in-their-codebase work.** If someone knows the code cold, AI adds overhead (prompting, reviewing, fixing). Don't assume AI always helps.
4. **Boilerplate speedup is the one thing everyone agrees on.** 10x for scaffolding, config, CRUD. This is solid.
5. **When in doubt, estimate high.** Under-promising and over-delivering builds trust. A dev who finishes early looks great. One who misses the estimate looks bad.
