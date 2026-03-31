# Persona Schema & Archetypes

## Persona Fields

Generate exactly 12 personas in ONE structured output call. Each persona:

| Field | Type | Description |
|---|---|---|
| `name` | string | Full name — realistic, diverse backgrounds |
| `handle` | string | Social media handle (e.g. `@bootstrapper_mike`) |
| `bio` | string | 2 sentences: role + relationship to this product/company |
| `profession` | string | Specific job title |
| `age` | number | Age in years |
| `mbti` | string | One of 16 MBTI types — drives communication style |
| `stance` | enum | `supportive` / `opposing` / `concerned` / `neutral` |
| `influence_weight` | float | 0.1–3.0 — how much others weight their opinion |
| `activity_level` | float | 0.3–1.0 — how vocal they are |
| `sentiment_bias` | float | -1.0 to 1.0 — negative to positive disposition |
| `communication_style` | string | e.g. "uses data, cites competitors" or "emotional, uses anecdotes" |
| `interested_topics` | string[] | e.g. `["pricing", "product quality", "alternatives"]` |
| `key_bias` | string | The one thing coloring their view (e.g. "burned by Drip's price doubling") |

---

## Mandatory Archetypes (always include these 5)

1. **The Loyal Early Adopter** — high influence, supportive but expects loyalty in return. Will defend you unless you betray their trust. Likely ENFJ or ISFJ.
2. **The Price-Sensitive Bootstrapper** — opposing lean, compares everything to alternatives, counts every dollar. Low sentiment bias. Likely ISTJ or INTJ.
3. **The Enterprise Buyer** — neutral, thinks in team size, procurement cycles, and annual budgets. High influence. Likely ENTJ or ESTJ.
4. **The Skeptic** — opposing, assumes the worst, has been burned by other companies doing exactly this. References specific past disasters (Unity, Drip, Cursor). Likely INTP or ISTP.
5. **The Journalist/Blogger** — neutral, looking for the headline angle. High influence. Will frame the narrative for everyone else. Likely ENTP or ENFP.

---

## Dynamic Archetypes (add 7 based on announcement type)

### Price Increase
- Churned customer who left 3 months ago
- Competitor's sales rep seeing an opportunity
- CFO who approves the SaaS budget
- Customer who just renewed yesterday at the old price
- The "I'll find an alternative this weekend" person
- Community moderator who'll manage the backlash thread
- Someone who'll write the Reddit post titled "Another SaaS raising prices"

### Product Launch
- Target user who has never heard of you
- Power user of the main competitor
- Product Hunt voter deciding whether to upvote
- Tech reviewer who'll write the blog post
- The "I'll wait for v2" person
- A developer who'll evaluate the API docs first
- Someone who'll try it immediately and live-tweet the experience

### Feature Removal / Sunset
- Heavy daily user of that specific feature
- Someone who never used it (validates the removal)
- A developer who built an integration on top of it
- The customer success person who has to field complaints
- A competitor who just shipped that exact feature
- A blogger writing "another SaaS removing features users love"
- Someone who'll open a support ticket within 10 minutes

### Layoff / Bad News
- An affected employee reading the announcement
- A remaining employee wondering if they're next
- A customer worried their support contact just got fired
- An investor evaluating whether to maintain their position
- A future Glassdoor reviewer
- Someone who'll tweet "red flag" with a screenshot
- A recruiter already DMing affected employees on LinkedIn

### Tweet / Hot Take
- The reply guy with a stock contrarian response
- The quote-tweeter adding snarky commentary
- The ratio king trying to dunk for engagement
- Someone who screenshots it for a "look at this" group chat
- Your biggest fan who jumps in to defend you
- Someone who says "didn't ask" or "cool story"
- A journalist who sees a story angle

### Policy / Terms Change
- A compliance officer evaluating the legal implications
- The user who'll hit the edge case first
- A community moderator who has to explain it to members
- A privacy advocate checking for data implications
- The power user who reads every word of the changelog
- A competitor watching for positioning opportunities
- A lawyer who'll write a LinkedIn post about the implications

---

## Diversity Rules

- At least 3 different MBTI types across the 12 personas (ideally 6+)
- Mix of genders, ages (22–65), and cultural backgrounds
- At least 2 personas with `stance: opposing` and `sentiment_bias < -0.3`
- At least 1 persona with `influence_weight > 2.0` (the amplifier)
- No two personas should have the same `key_bias`
