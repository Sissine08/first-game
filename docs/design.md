# Design Document

## Elevator Pitch

An endless runner where survival is the only victory. Jump to dodge obstacles. Score based on distance. One mistake = game over. Simple to learn, hard to master. Perfect for 30-second play sessions.

---

## Core Pillars

1. **Pillar 1:** Instant play — no loading, no tutorials, just jump
2. **Pillar 2:** One input — spacebar/tap to jump, that's it
3. **Pillar 3:** Infinite escalation — speed increases, obstacles get harder

---

## Core Loop

```
Auto-run → Obstacle approaches → Player jumps → Dodge successful → Score increases → Speed increases → Repeat → Collision → Game Over → Restart
```

---

## Win Condition

There is no win. Only survival. High score = bragging rights.

---

## Lose Condition

Collide with any obstacle = instant game over. No health, no continues. Brutal but fair.

---

## Key Mechanics

| Mechanic | Description | Risk/Reward |
|----------|-------------|-------------|
| Single Jump | Press space to jump | Timing is everything |
| Auto-scroll | World moves, player stays | No stopping, constant pressure |
| Score = Distance | 10 points per second survived | Longer = harder = more impressive |
| Speed ramp | Increases over time | Eventually, reflex limits reached |
| Instant restart | Space to retry | No friction, just one more try |

---

## Art Direction

**Style:** Minimalist geometric
**Palette:** Dark background (#1a1a26), neon player (#33cc66), red obstacles (#e64c33), gray ground (#505058)
**Reference:** Super Hexagon, Geometry Dash, Canabalt

---

## Audio Direction

**Music:** [Energetic / Ambient / None]
**SFX:** [Minimal / Juice-heavy / Realistic]

---

## Monetization (If Any)

- **Free:** Just ship it, learn
- **Premium:** $1-5 price point
- **Ad-supported:** Rewarded ads for continues
- **DLC:** Cosmetic only

---

## Success Metrics

| Metric | Target | Why |
|--------|--------|-----|
| Prototype time | < 2 hours | Fast iteration |
| MVP dev time | < 30 days | Ship constraint |
| Downloads | 100+ | Validation |
| Rating | 4.0+ | Quality floor |

---

## Open Questions

1. Single-player or multiplayer?
2. Mobile-first or desktop-first?
3. Narrative-driven or pure mechanics?
4. Procedural or handcrafted levels?

---

## Inspirations

- [Game 1] — What specifically?
- [Game 2] — What specifically?
- [Non-game: film, book, experience] — What feeling?

---

*This doc lives. It changes. The only sin is leaving it blank.*
