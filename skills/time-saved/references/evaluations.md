# Evaluation Scenarios

## Scenario 1: After shipping a feature

**Input:** `/time-saved` (after building a help center article editor with drag-and-drop reordering, 8 files changed, 400+ insertions)

**Expected behavior:**
- Reads git diff and identifies the scope (new UI component, API routes, state management)
- Estimates pre-AI: 3–5 days for an experienced dev (complex UI + backend + tests)
- Estimates AI time from session/commit timestamps
- Shows the formatted box with breakdown
- Offers to draft a tweet since the gap is likely 5x+

## Scenario 2: Trivial task

**Input:** `/time-saved renamed the API routes from camelCase to kebab-case`

**Expected behavior:**
- Recognizes this as a low-complexity refactor
- Estimates pre-AI: 30–60 minutes (find-and-replace + verify)
- Does NOT inflate the estimate — stays honest
- Shows a modest multiplier (~2–3x)
- Does NOT offer to tweet (gap isn't impressive enough)

## Scenario 3: No recent git activity

**Input:** `/time-saved` in a repo with no recent commits

**Expected behavior:**
- Asks the user to describe what they worked on
- If description provided, estimates from that
- If no description, says "Nothing to estimate — ship something first"
