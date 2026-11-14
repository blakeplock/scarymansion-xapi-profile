# ScaryMansion xAPI Profile (v4)

A public, machine-readable model of player experience in [ScaryMansion](https://scarymansion.com/), a Godot browser-based haunted-mansion game. The game is proprietary; **this repository publishes only its xAPI Profile, synthetic examples, and documentation**, under the Apache License 2.0 license.

The Profile defines an actor-centered vocabulary and constraints for describing exploration, combat, hazards, resources, scoring, and session outcomes. It is an example of how an [xAPI Profile](https://adlnet.github.io/xapi-profiles/xapi-profiles-structure.html) can function as a semantic contract between instrumentation, a Learning Record Store, and analysis.

## Contents

- [`scarymansion-profile-v4.jsonld`](scarymansion-profile-v4.jsonld): complete xAPI Profile v4.
- [`fixtures/template-positive-v4.json`](fixtures/template-positive-v4.json): synthetic example statements from the private source repository, for template validation. **No real player telemetry.**
- [`docs/SEMANTICS.md`](docs/SEMANTICS.md): the actor-centered approach and xAPI Prepositions.
- [`docs/ANALYTICS.md`](docs/ANALYTICS.md): research questions and analytical interpretations.
- [`docs/VALIDATION.md`](docs/VALIDATION.md): local validation and limitations.
- [`NOTICE`](NOTICE) and [`LICENSE`](LICENSE): attribution and Apache 2.0 terms.

## Profile overview

The published v4 source defines **36 Verbs, 20 ActivityTypes, 12 ContextExtensions, 35 ResultExtensions, 74 Statement Templates, and 17 Patterns**. These counts describe the published model, not a claim that every Pattern has been matched against complete runtime streams.

A statement describes the experience from the player's perspective: **actor — active verb — direct object**. For example, `suffered` can relate a player to a Damage Activity, and the canonical [xAPI Prepositions](https://github.com/yetanalytics/xapi-prepositions) `by` extension can identify the Enemy Activity associated with that damage. An `event-id` extension distinguishes instrumented events that share the same verb. Relationships such as `from` and `in` contain typed xAPI objects, rather than free-text tags.

Each play session has a distinct `context.registration` UUID. The Profile identifies its version as `https://github.com/blakeplock/ScaryMansion/xapi/v4`. The released game's instrumentation also includes a per-registration `event-sequence` extension to preserve chronological order; consult the source Profile and examples for modeled constraints.

## Running game and example analytics

The publicly playable game is at **https://scarymansion.com/**. Its analytics can study navigation and exploration, threat encounters, damage and recovery, resource strategy, scoring and completed-session behavior. These are observational data: a behavioral correlation does not, by itself, prove causation or learning effectiveness. See [Analytics](docs/ANALYTICS.md).

A release acceptance session on November 14, 2026 produced 497 consecutively sequenced xAPI v4 statements with the final `session-completed` event. That is an operational test observation, not an independently reproducible research dataset; no player records are published here.

## Identifiers and versioning

The Profile retains its preexisting canonical identifier IRIs under `https://github.com/blakeplock/ScaryMansion/xapi/` so that publication does not invalidate previously emitted statements. These IRIs identify concepts but **some do not resolve publicly**, because the proprietary source repository remains private. This public repository provides accessible definitions without changing those identifiers. Consumers should use the identifiers exactly as declared, not substitute the URLs of files in this repository.

The initial public release is v4; the source project's legacy v1 material and proprietary implementation are not part of this distribution.

## License and scope

Copyright 2026 Yet Analytics. Public Profile content and documentation in this repository are licensed under [Apache License, Version 2.0](LICENSE). This **does not license** ScaryMansion gameplay code, art, audio, interface, infrastructure, private repository content, or player data. Third-party projects, including [xAPI Prepositions](https://github.com/yetanalytics/xapi-prepositions), retain their own licenses.

Please cite this public repository when discussing the model. Feedback and contributions can be submitted through GitHub Issues and pull requests.
