---
name: time-saved
description: "Show pre-AI vs AI time estimates after completing work. Analyzes git diff, estimates how long the work would have taken a human team without AI, and displays the time saved. Use when you just finished a task, after shipping, or when the user says 'how long would that have taken', 'time saved', 'pre-AI estimate', 'estimate time', or wants to see the before/after gap."
---

# /time-saved — Pre-AI vs AI Time Estimate

Show how long the work you just did would have taken without AI. The satisfying "2 weeks → 30 minutes" moment.

**Usage:**
- `/time-saved` — auto-detect from recent git activity + session context
- `/time-saved [description]` — estimate for a specific task

## Step 1: Gather What Was Done

Run in parallel:

1. `git log --oneline -10` — recent commits
2. `git diff HEAD~3 --stat` — files changed, insertions, deletions
3. `git diff HEAD~3 --shortstat` — summary numbers
4. `date "+%Y-%m-%d %H:%M"` — current time
5. Read the session context — what did the user ask for? What did you build?

If user provided a description, use that as PRIMARY context. Git is supplementary.

**Extract:**
- What was built/changed (features, fixes, refactors)
- Tech stack involved (languages, frameworks, APIs)
- Complexity signals (new files vs edits, test coverage, integrations, migrations)

## Step 2: Estimate Pre-AI Human Time

Use the estimation framework in [references/estimation-framework.md](references/estimation-framework.md).

Estimate across three dimensions:
1. **Raw coding time** — how long a competent developer would spend writing this code
2. **Overhead multiplier** — research, debugging, testing, code review, context switching
3. **Coordination tax** — if the scope would require multiple people, add communication overhead

Produce a **range** (optimistic → realistic) for a single experienced developer. Never give a point estimate — that's fake precision.

## Step 3: Estimate AI Time

Calculate from session context:
- How long the conversation has been (approximate from message count)
- If not clear, use git commit timestamps: `git log --format="%ai" -5`
- Include the human's review/prompting time (not just AI execution)

Be honest. If it took 2 hours of back-and-forth with AI, say 2 hours. Don't pretend it was instant.

## Step 4: Display the Estimate

Use this format:

```
┌─────────────────────────────────────────┐
│ ⏱️  TIME SAVED                          │
├─────────────────────────────────────────┤
│                                         │
│  What:  [1-line description]            │
│  Scope: [files changed] files,          │
│         [insertions]+/[deletions]-      │
│                                         │
│  Pre-AI estimate:  [range]              │
│  With AI:          [actual time]        │
│  Time saved:       ~[X]x faster         │
│                                         │
├─────────────────────────────────────────┤
│ Breakdown                               │
│                                         │
│  Coding:        [Xh] → [Ym]            │
│  Research:      [Xh] → [Ym]            │
│  Testing:       [Xh] → [Ym]            │
│  Debugging:     [Xh] → [Ym]            │
│  Code review:   [Xh] → [Ym]            │
│                                         │
│ Assumptions                             │
│  • [key assumption 1]                   │
│  • [key assumption 2]                   │
│                                         │
└─────────────────────────────────────────┘
```

**Rules for the display:**
- Only show breakdown rows that are relevant (skip if zero)
- Pre-AI estimate is always a range: "3–5 days" not "4 days"
- The multiplier rounds to nearest whole number: "~8x faster"
- Assumptions section is mandatory — be transparent about what you're guessing
- If the task was trivial (< 1 hour pre-AI), say so. Don't inflate for drama.

## Step 5: Offer Next Steps

After showing the estimate:

1. **Tweet it?** — "That's a tweet. Want me to draft it?" (only if the gap is impressive — 5x+ faster)
2. **Log it?** — If the user wants to track time saved over time, append to a running log

If logging, append to `/Users/moiz/Documents/Code/life-os/memory/time-saved-log.md`:
```markdown
| Date | Project | Task | Pre-AI | With AI | Multiplier |
```

Create the file with headers if it doesn't exist. Read first if it does — append, never overwrite.

## Gotchas

- **Don't inflate estimates to make AI look better.** Credibility matters. A 3x speedup is still impressive — don't claim 20x by padding the pre-AI number.
- **Include AI prompting time.** The human spent time writing prompts, reviewing output, iterating. That counts as "AI time." It's not just the seconds Claude spent generating tokens.
- **Simple tasks stay simple.** Renaming a variable across 10 files? Pre-AI: 15 minutes with find-and-replace. Don't pretend it would've taken a week. Reserve impressive estimates for genuinely complex work.
- **Coordination tax is real but don't assume it.** Only add team coordination overhead if the scope genuinely would have required multiple people. A solo dev doesn't have standup overhead.
- **Be specific about the "experienced developer" baseline.** A senior dev with domain knowledge is the baseline, not a junior or a team that needs to learn the stack first.
