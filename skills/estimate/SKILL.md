---
name: estimate
description: "Estimates how long a task will take with AI. Breaks the task into sub-tasks and gives realistic AI-assisted time estimates based on calibrated research data. Triggers on 'how long will this take', 'estimate this', 'scope this feature', 'what's the ETA', or before starting a project to set expectations."
---

# /estimate — AI-Era Time Estimates

Estimate how long a task will actually take — with AI in the picture.

**Usage:**
- `/estimate [task description]` — estimate a described task
- `/estimate` — estimate from current context (recent issues, conversation)

## Step 1: Parse the Task

Break the task into concrete sub-tasks. Each sub-task should be a shippable unit of work.

If the description is vague, ask ONE clarifying question max. Don't interrogate — make reasonable assumptions and list them.

**Extract for each sub-task:**
- What needs to be built (component, endpoint, migration, etc.)
- Tech involved (language, framework, APIs, integrations)
- Complexity tier (see [references/estimation-framework.md](references/estimation-framework.md))

If in a repo, run `git ls-files | head -30` and check the stack. Knowing the codebase changes the estimate.

## Step 2: Estimate Each Sub-Task

For each sub-task, estimate the **total time including human involvement:**

| Component | What It Covers |
|-----------|---------------|
| AI generation | Claude/Cursor writing the code |
| Prompting | Human describing what to build, iterating on prompts |
| Review | Human reading, understanding, and approving AI output |
| Testing | Running it, checking edge cases, manual QA |
| Debugging | Fixing what the AI got wrong, iteration cycles |
| Integration | Connecting pieces, deployment, config |

Use the rates in [references/estimation-framework.md](references/estimation-framework.md).

Always produce a **range** (optimistic → realistic). The optimistic assumes clean execution. The realistic assumes 1-2 iteration cycles per sub-task.

## Step 3: Display the Estimate

```
┌─────────────────────────────────────────┐
│ 📐 ESTIMATE                             │
├─────────────────────────────────────────┤
│                                         │
│  Task: [1-line description]             │
│                                         │
│  Estimate:  [range]                     │
│                                         │
├─────────────────────────────────────────┤
│ Breakdown                               │
│                                         │
│  1. [Sub-task]             ~[time]      │
│  2. [Sub-task]             ~[time]      │
│  3. [Sub-task]             ~[time]      │
│  4. Review & test          ~[time]      │
│                                         │
│ Assumptions                             │
│  • [key assumption]                     │
│  • [key assumption]                     │
│                                         │
└─────────────────────────────────────────┘
```

**Rules:**
- Estimate is always a range: "2–4 hours" not "3 hours"
- Sub-tasks show individual time estimates
- "Review & test" is always a line item — it's real time humans spend
- Assumptions section is mandatory — be transparent about what you're assuming
- If the task is trivial (< 30 min total), just say so in one line. No box needed.
- Keep it to 3–7 sub-tasks. If more, you're scoping a project, not a task — suggest breaking it up.

## Step 4: Offer to Start

After showing the estimate: "Want to start with #1?"

If the user says yes, begin working on the first sub-task. The estimate becomes a natural checklist.

## Gotchas

- **AI doesn't eliminate all human time.** Review, testing, and deployment are still real. A "2-hour AI estimate" that ignores 3 hours of human review is a lie.
- **Iteration cycles are the hidden cost.** AI gets it 80% right on the first pass. The last 20% — edge cases, styling, business logic nuance — takes disproportionate time. Always budget for 1-2 rounds of "that's not quite right."
- **Integrations multiply time.** Connecting to Stripe, sending emails, OAuth flows — these have real debugging time regardless of AI. Third-party APIs don't care how fast your code generator is.
- **Don't estimate what you can't see.** If the task involves a codebase you haven't read, say so. "Estimate assumes standard [framework] patterns. Could be higher if the codebase has unusual architecture."
- **Scope creep is the real enemy.** The estimate covers what was asked, not what will inevitably get added. If the task sounds like it'll grow, flag it: "This estimate covers X. If Y is also needed, add [time]."
