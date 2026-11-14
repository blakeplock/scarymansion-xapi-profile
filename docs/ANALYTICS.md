# Analytics enabled by the Profile

An xAPI Profile makes event meaning explicit. ScaryMansion uses a constrained vocabulary and per-registration chronology to support behavioral summaries, postgame advanced analytics, comparative strategy views, and exploratory questions about how players navigate uncertainty.

| Area | Potential measures and questions |
| --- | --- |
| Exploration | New-room rate, revisit frequency, route efficiency, changes in route selection after map use |
| Threat response | Encounters, evasions, damage suffered, survival conditional on exposure |
| Recovery | Events between damage/poisoning and an item use or recovered state; elapsed time where timestamps permit |
| Resources | Timing and use of collected items, spells, and protective effects; utilization relative to threats |
| Navigation | Floor changes, blocked-door attempts, backtracking, and decisions preceding escape |
| Scoring | Time, exploration, bonuses, final outcome, and strategy comparisons with score components separated |
| Session trajectories | Ordered motifs around blackouts, enemy encounters, item collection, terminal failure/escape, and final score |

## Analytical method

1. Group statements by `context.registration`, not by arcade initials.
2. Validate that the Profile category, event identifier, verb, direct object type, and required typed relationships agree with the v4 semantic contract.
3. Order by integer `event-sequence` within each registration; inspect for gaps and duplicates. Also retain the source statement timestamps when examining elapsed time.
4. Derive event classes from the Profile and `event-id`, **not** a string match against `verb.display`.
5. Compare cohorts and outcomes using exposure-adjusted measures. A session with more encounters may have more damage simply because it lasted longer.
6. Separate the components of score. If time contributes points, total score and survival time are mathematically related; a correlation is not evidence of a distinctive strategy.

## Research caveats

Behavioral analysis describes what players did in a constrained game environment. It does not automatically measure learning, skill transfer, or human competence outside the game. Observational patterns establish association, not causality. Establishing a causal effect requires experimental design or justified identification assumptions. The public fixture statements are synthetic and not suitable for empirical conclusions.

## What is public

This repository publishes the *data model*, not individual player histories, leaderboard records, or the private analytics backend. A researcher can inspect the Profile, create synthetic conforming statements, and design an analysis that could be run against appropriately permissioned data.
