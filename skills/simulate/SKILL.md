---
name: simulate
description: "Simulates how 12 diverse personas react to an announcement over 3 interactive rounds — each persona reads others' reactions and shifts opinions, surfacing emergent camps and objections no single prompt catches. Spawns 12 parallel agents with web search access. Use before publishing pricing changes, product launches, layoffs, policy shifts, or any high-stakes message. Triggers on '/simulate', 'how will people react', 'test this announcement', 'honest feedback on this', 'simulate reaction'."
---

# /simulate — Reaction Simulator

12 personas. 3 rounds. They react to your announcement AND to each other — camps form, opinions shift, objections emerge.

**Usage:** `/simulate [paste your announcement, or describe the situation]`

---

## How It Works

Inspired by social simulation research (OASIS engine). The key insight: agents that interact with each other produce fundamentally different output than 12 independent prompts, because opinions shift when personas see each other's arguments.

1. **Context** — read product data, identify audience and channel
2. **Personas** — generate 12 with detailed profiles (MBTI, influence, bias)
3. **Round 1** — all 12 react independently to the announcement (parallel, each does 1 web search)
4. **Round 2** — each persona reads ALL Round 1 reactions, can shift stance, reply, form camps (parallel)
5. **Round 3** — final positions after seeing the full debate (parallel)
6. **Report** — opinion trajectory, camps, ranked objections, suggested rewrite

~36 agent calls total across 3 sequential rounds.

---

## Phase 1: Context

### Extract from input
- **Text** — the announcement (`$ARGUMENTS`, or ask)
- **Product** — what product/company is this about?
- **Audience** — who sees this?
- **Channel** — where is it published? (email, Twitter, blog, HN, internal)

### Read product context silently
- Check for `README.md`, `CLAUDE.md`, or docs in the current project for product details
- If a URL is provided, fetch it with web tools
- Look for: current pricing, customer count, competitors, recent changes
- If context is thin, ask the user for key details (price, customer count, what changed)

This context goes into every persona prompt so reactions reference real pricing, competitors, and customers.

---

## Phase 2: Generate Personas

Generate 12 personas in ONE call. See [references/persona-schema.md](references/persona-schema.md) for:
- Full field spec (name, handle, MBTI, stance, influence, sentiment bias, key bias, etc.)
- 5 mandatory archetypes (early adopter, bootstrapper, enterprise, skeptic, journalist)
- Dynamic archetypes by announcement type (price increase, launch, removal, layoff, tweet, policy)
- Diversity rules (MBTI spread, age range, stance balance)

The persona panel should guarantee at least 2 opposing personas with negative sentiment — anti-sycophancy is the entire point of this skill.

---

## Phase 3: Run 3 Rounds

See [references/round-prompts.md](references/round-prompts.md) for exact prompt templates.

### Round 1 — Initial Reactions
Spawn all 12 personas in parallel using the Agent tool (`subagent_type: "general-purpose"`). Each:
- Picks 1-2 web search tools to find real-world context (similar announcements, competitor pricing, community sentiment)
- Reacts honestly in character
- Returns: stance, post, objection, what would fix it, research context

Collect all 12 responses before proceeding.

### Round 2 — Debate & Shifts
Spawn all 12 again. Each persona sees the FULL Round 1 feed (all 11 others' posts). They:
- Can shift stance (and must explain why)
- Can reply to specific personas
- Declare which camp they belong to

**Do not summarize the feed.** Pass full posts — summarizing kills emergent dynamics.

After Round 2, compute: shift count, shift direction, camp clusters.

### Round 3 — Final Positions
Spawn all 12 again with Round 1 + Round 2 feed + shift summary. Each returns:
- Final stance and confidence
- Deal breaker (or "None")
- Suggested fix (one sentence rewrite)

---

## Phase 4: Synthesize Report

See [references/report-template.md](references/report-template.md) for the full output format.

Key sections:
1. **Verdict** — one bold sentence + explanation
2. **Opinion trajectory** — table showing stance counts across Round 1 → 2 → 3
3. **Camps that formed** — who grouped together and why
4. **Key opinion shifts** — who changed their mind and which argument caused it
5. **Top 3 objections** — ranked by frequency, with best persona quotes and fix suggestions
6. **Real-world context** — aggregated from personas' web searches
7. **Suggested rewrite** — new version addressing the top 3 objections
8. **Hottest take** — the most memorable quote from any persona

After presenting, offer: **"Want to talk to any persona? I can spawn a conversation where they remember the full debate."**

---

## Gotchas

- **Round 2 is the magic.** Round 1 is "ask 12 prompts." Round 2 is where personas react to each other and camps emerge. Never skip Round 2.
- **Full feed, never summarized.** Each Round 2/3 persona must see ALL other personas' prior posts verbatim. Summarizing destroys the emergent dynamics.
- **MBTI drives communication diversity.** An INTJ writes data-driven analysis. An ESFP writes emotional reactions. Include MBTI in the persona prompt.
- **Web search is the grounding advantage.** Without web search, personas give generic LLM-flavored reactions. With search, they reference real price doublings, real competitor pricing, real community backlash.
- **Product context is non-negotiable.** A "price increase" simulation without knowing the current price produces worthless output. Always read product files first.
- **The trajectory table is the highest-value output.** The opinion shift from Round 1 → 3 shows what ARGUMENTS change minds.
- **12 personas x 3 rounds = ~36 agent calls.** Budget accordingly.
- **All agents must run in foreground.** Never use `run_in_background` — results are needed for the next round.
- **Don't oversell the split.** 12 personas is not a focus group of 1,000. The value is the OBJECTIONS, the SHIFTS, and the REWRITE — not statistical significance.
