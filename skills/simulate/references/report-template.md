# Report Template

After all 3 rounds complete, synthesize into this report format. Weight high-influence personas more heavily in the verdict.

---

```markdown
## Reaction Report

**Announcement:** {first 100 chars}...
**Personas:** 12 | **Rounds:** 3 | **Total interactions:** {count all posts across all rounds}

---

### Verdict

**{One bold sentence: "This will [split your audience / land well / cause backlash / be mostly ignored]."}**

{2-3 sentences explaining why — reference the opinion trajectory, the dominant camp, and the key turning point from the debate.}

### Opinion Trajectory

| Stance | Round 1 | Round 2 | Round 3 | Shift |
|--------|---------|---------|---------|-------|
| Supportive | {n} | {n} | {n} | {+/-n} |
| Against | {n} | {n} | {n} | {+/-n} |
| Concerned | {n} | {n} | {n} | {+/-n} |
| Neutral | {n} | {n} | {n} | {+/-n} |

### Camps That Formed

**Camp: "{camp name}"** ({n} members)
Members: {persona names}
Core argument: {the shared position}
Formed in: Round {n}

{repeat for each distinct camp}

### Key Opinion Shifts

{For each persona that shifted stance between any rounds:}
- **{Name}** shifted {previous} → {new} in Round {n} because: "{shift_reason}"

{If no personas shifted: "No personas shifted stance — positions were firm from Round 1. This suggests the announcement is either clearly good or clearly bad, with little ambiguity to debate."}

### Top Objections

**1. {Objection title}** — raised by {n}/12 personas
> "{Best direct quote from a persona's POST field}" — {Name}
**Fix:** {Aggregate the WHAT_WOULD_FIX_IT and SUGGESTED_FIX responses for this objection into one actionable recommendation}

**2. {Objection title}** — raised by {n}/12
> "{Best quote}" — {Name}
**Fix:** {recommendation}

**3. {Objection title}** — raised by {n}/12
> "{Best quote}" — {Name}
**Fix:** {recommendation}

### Real-World Context

{Aggregate the most interesting RESEARCH_CONTEXT findings from Round 1:}
- {What similar companies did when making this kind of announcement}
- {Community sentiment found on Reddit/X about this topic}
- {Any historical precedent — positive or negative}

### Suggested Rewrite

**Original:**
> {first ~200 chars of the announcement}

**Rewritten (addressing top 3 objections):**
> {new version incorporating the SUGGESTED_FIX responses from Round 3 personas}

**What changed and why:**
1. {Change 1} — addresses objection #1
2. {Change 2} — addresses objection #2
3. {Change 3} — addresses objection #3

### The Hottest Take

> "{The single most memorable, shareable, or cutting quote from any persona across all 3 rounds}"
> — {Name}, {profession}
```

---

## After Presenting the Report

Ask: **"Want to dig deeper with any persona? I can start a conversation where they remember the full 3-round debate."**

If yes, spawn a single agent with:
- That persona's full profile
- Their posts and reactions from all 3 rounds
- The complete feed from all other personas
- The announcement text and product context

Let the user chat interactively. The persona stays in character and can reference specific things other personas said during the debate.
