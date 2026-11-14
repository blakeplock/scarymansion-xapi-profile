# Semantic design: active experience and typed relationships

ScaryMansion v4 treats xAPI as a model of the player's experience rather than an unstructured log of UI actions.

## Actor, verb, and direct object

The actor is the player in player-experience statements. The verb expresses one active, reusable action or experience. The object names the thing experienced, using an xAPI Activity and its declared ActivityType.

For example, a ghost attack can be represented as a player who **suffered** a Damage Activity **by** a Ghost Activity. The player did not `was-hit-by` an enemy: that passive, event-specific phrase would combine predicate and relationship in a single verb identifier. The active predicate `suffered` can also model other damage or harmful effects while retaining a stable meaning.

The instrumented game's distinct event families are disambiguated by the `event-id` context extension (`https://github.com/blakeplock/ScaryMansion/xapi/extensions/event-id`). An event identifier is not a substitute verb. An analyst should not infer event identity from `verb.display`, because display text can vary independently of the verb ID.

## xAPI Prepositions

When a relationship is actually known, canonical [xAPI Prepositions](https://github.com/yetanalytics/xapi-prepositions) express it as a typed xAPI indirect object. Example relationships include:

| Preposition | Relation | Example |
| --- | --- | --- |
| `by` | Source or agent associated with an experience | Damage **by** a Ghost Activity |
| `from` | Origin of a movement | Player `moved` to the destination room **from** the origin Room Activity |
| `in` | Location of an experience | Encounter **in** a Room Activity |

Canonical prepositional context extension identifiers are under `https://yetanalytics.com/profiles/prepositions/concepts/context-extensions/`. These values contain xAPI objects (such as typed Activities), not untyped strings.

Do not fabricate causation or timing. Use `after`, `before`, or causal links only when the underlying referent is known from the recorded experience. A statement's sequence does not alone establish a causal relationship.

## Time, context, and identity

Each run has a unique `context.registration` UUID and is categorized as Profile version `https://github.com/blakeplock/ScaryMansion/xapi/v4`. The game includes an integer `event-sequence` extension increasing from 1 per registration, to make event order explicit even when statements are received asynchronously.

In the authenticated game, the ingestion service replaces untrusted client actor identity with the verified Keycloak account subject. Arcade initials are presentation labels, not globally unique identifiers. Synthetic fixtures in this repository do not imply the publication of real player identity or telemetry.

## Session lifecycle and interpretation

A representative terminal progression is:

1. `session-started`
2. Game actions and experiences, such as exploration, collection, encounters, and recovery
3. Terminal outcome, for example `session-failed` or `session-escaped`
4. `total-score-recorded`
5. `session-completed`

The Profile's Patterns formalize intended sequences and motifs. Match each analytic claim to the actual available statement types and validation coverage. **Template validation and verification of one observed sequence are not proof that all complete Pattern combinations have been exhaustively validated.**

## Why this design matters

A single well-defined verb can be reused across contexts, and typed objects provide the distinctions needed for interpretation. A consumer can ask *what the player experienced, what object was involved, and what other entities were related* without parsing application-specific verb strings. The result is a vocabulary that can support durable analytics and reuse beyond one user interface.
