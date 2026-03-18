# Claude Code Skills

Open-source skills for [Claude Code](https://docs.anthropic.com/en/docs/claude-code).

## Skills

### `/estimate` — AI-Era Time Estimates

Estimate how long a task will actually take — with AI in the picture. No more pre-AI guesswork.

```
/estimate build a Stripe webhook handler with retry logic
```

```
┌─────────────────────────────────────────┐
│ 📐 ESTIMATE                             │
├─────────────────────────────────────────┤
│                                         │
│  Task: Stripe webhook with retry        │
│                                         │
│  Estimate:  1.5–3 hours                 │
│                                         │
├─────────────────────────────────────────┤
│ Breakdown                               │
│                                         │
│  1. Webhook endpoint + validation ~20m  │
│  2. Retry logic + queue          ~30m   │
│  3. Event deduplication store    ~20m   │
│  4. Error handling + logging     ~15m   │
│  5. Review & test                ~30m   │
│                                         │
│ Assumptions                             │
│  • Existing Stripe setup                │
│  • PostgreSQL for dedup store           │
│  • Third-party API multiplier applied   │
│                                         │
└─────────────────────────────────────────┘
```

Calibrated with real research data — Anthropic's 100K conversation study, METR's RCT, BSWEN's 3-month case study, and developer build times from X. Not vibes.

#### Install

Copy the skill folder to your project:

```bash
# Project-level (this project only)
cp -r skills/estimate .claude/skills/estimate

# Or user-level (available everywhere)
cp -r skills/estimate ~/.claude/skills/estimate
```

Then run `/estimate [task]` before starting any work.

## Adding More Skills

More skills coming. Watch/star for updates.

## License

MIT
