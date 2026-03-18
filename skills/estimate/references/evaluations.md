# Evaluation Scenarios

## Scenario 1: Clear feature request

**Input:** `/estimate build a Stripe webhook handler with retry logic and event deduplication`

**Expected behavior:**
- Breaks into sub-tasks: webhook endpoint, event validation, retry logic, deduplication store, testing
- Estimates 2–4 hours total (medium complexity + third-party API multiplier)
- Lists assumptions: "assumes existing Stripe setup", "assumes PostgreSQL for dedup store"
- Offers to start with sub-task #1

## Scenario 2: Vague request

**Input:** `/estimate add user auth`

**Expected behavior:**
- Asks ONE clarifying question: "OAuth (Google/GitHub) or email/password? And what framework?"
- After answer, breaks into sub-tasks with realistic estimates
- Does NOT over-scope (no "and also add 2FA, password reset, rate limiting" unless asked)

## Scenario 3: Massive scope

**Input:** `/estimate build a full help center SaaS with collections, articles, search, custom domains, and analytics`

**Expected behavior:**
- Recognizes this is a project, not a task
- Suggests breaking into phases
- Gives a rough project-level range (1–3 weeks)
- Offers to estimate the first phase in detail
