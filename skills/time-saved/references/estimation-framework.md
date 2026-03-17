# Estimation Framework

## Base Coding Rates (Pre-AI, Experienced Developer)

These are lines of **production-quality** code per hour, including inline tests and basic docs.

| Complexity | LOC/hour | Examples |
|------------|----------|----------|
| Boilerplate/CRUD | 40–60 | REST endpoints, form components, DB models |
| Standard features | 20–35 | Auth flows, payment integration, dashboards |
| Complex logic | 8–15 | Search algorithms, data pipelines, state machines |
| Novel/research | 3–8 | ML models, protocol implementations, parsers |

## Overhead Multiplier

Raw coding is typically 30–40% of total development time. The rest:

| Activity | % of Total Time | Notes |
|----------|----------------|-------|
| Coding | 30–40% | Writing the actual code |
| Research/design | 15–20% | Stack Overflow, docs, architecture decisions |
| Debugging | 15–25% | Finding and fixing issues during development |
| Testing | 10–15% | Writing tests, manual QA, edge cases |
| Code review | 5–10% | Review cycles, addressing feedback |
| Context switching | 5–10% | Meetings, Slack, getting back into flow |

**Quick multiplier:** Multiply raw coding time by **2.5–3x** for total time.

## Coordination Tax

Only apply if the scope would genuinely require multiple people.

| Team Size | Overhead | When to Apply |
|-----------|----------|---------------|
| Solo | 0% | Most tasks under 2 weeks of coding |
| 2 people | +30% | Shared state, API contracts, merge conflicts |
| 3–5 people | +60% | Sprint planning, standups, design reviews |
| 5+ people | +100% | Cross-team dependencies, architecture reviews |

**Signals that coordination is needed:**
- Frontend + backend changes that touch shared APIs
- Database migrations that affect multiple services
- Work spanning 3+ distinct technical domains
- Scope that would take a solo dev more than 2 weeks

## Scope-to-Time Quick Reference

| Scope | Solo Dev (Pre-AI) | Notes |
|-------|-------------------|-------|
| Single function/fix | 30 min – 2 hours | Unless debugging a production issue |
| Small feature (1 component + API) | 1–3 days | Including tests and review |
| Medium feature (3–5 files, new UI) | 3–7 days | Design decisions slow things down |
| Large feature (new section, 10+ files) | 1–3 weeks | Architecture + implementation + testing |
| New project scaffold | 2–5 days | Tooling setup, CI, initial architecture |
| Full MVP | 4–12 weeks | Depends heavily on scope |

## AI Time Estimation

When estimating how long the AI session took:

1. **Message count heuristic:** ~2 min per message exchange (human reads, thinks, responds)
2. **Git timestamp method:** Diff between first and last commit in the session
3. **Session length:** If the conversation has been going, estimate from context
4. **Add review time:** Human reviewing AI output adds 20–30% to raw session time

## Calibration Notes

- These estimates assume a developer who KNOWS the stack. Learning curve is not included in the baseline — that would be a separate "ramp-up" line item.
- Remote async teams are slower than the coordination tax suggests. Add another 20% for timezone gaps.
- The pre-AI estimate should feel honest to a senior dev reading it. If they'd scoff at the number, it's too high.
- Favor conservative AI time estimates (round up) and honest pre-AI estimates (don't pad). The gap speaks for itself when the work is real.
