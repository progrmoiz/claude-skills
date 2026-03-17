# Claude Code Skills

Open-source skills for [Claude Code](https://docs.anthropic.com/en/docs/claude-code).

## Skills

### `/time-saved` — Pre-AI vs AI Time Estimates

Shows how long your work would have taken without AI. The satisfying "2 weeks → 30 minutes" moment.

After completing any task, run `/time-saved` and get:

```
┌─────────────────────────────────────────┐
│ ⏱️  TIME SAVED                          │
├─────────────────────────────────────────┤
│                                         │
│  What:  Help center article editor      │
│  Scope: 8 files, +412/-23              │
│                                         │
│  Pre-AI estimate:  3–5 days             │
│  With AI:          40 minutes           │
│  Time saved:       ~8x faster           │
│                                         │
├─────────────────────────────────────────┤
│ Breakdown                               │
│                                         │
│  Coding:        12h → 20m               │
│  Research:       4h → 5m                │
│  Testing:        3h → 10m               │
│  Debugging:      2h → 5m                │
│                                         │
│ Assumptions                             │
│  • Senior dev familiar with the stack   │
│  • Includes prompt/review time for AI   │
│                                         │
└─────────────────────────────────────────┘
```

Uses a calibrated estimation framework — doesn't inflate pre-AI numbers for drama.

#### Install

Copy the skill folder to your project:

```bash
# Project-level (this project only)
cp -r skills/time-saved .claude/skills/time-saved

# Or user-level (available everywhere)
cp -r skills/time-saved ~/.claude/skills/time-saved
```

Then run `/time-saved` in Claude Code after shipping something.

## Adding More Skills

More skills coming. Watch/star for updates.

## License

MIT
