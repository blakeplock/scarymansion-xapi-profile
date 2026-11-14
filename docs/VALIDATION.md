# Validation and reproducibility

ScaryMansion v4 is expressed using the [xAPI Profiles 1.0](https://adlnet.github.io/xapi-profiles/xapi-profiles-structure.html) data model. The source project validates Profile syntax and concept, template, and pattern relationships using [Project Pan](https://github.com/yetanalytics/project-pan), and checks representative positive statements with [Project Persephone](https://github.com/yetanalytics/project-persephone).

This standalone repository contains the public Profile and synthetic positive fixture collection. It intentionally excludes the proprietary game's source code, infrastructure, and CI secrets. Consult upstream Pan and Persephone documentation for their current installation and command-line options; the exact source-project Clojure workflow is not bundled here.

## Portable integrity check

From the repository root, run:

```sh
python3 -m json.tool scarymansion-profile-v4.jsonld >/dev/null
python3 -m json.tool fixtures/template-positive-v4.json >/dev/null
python3 scripts/check_distribution.py
```

This confirms valid JSON, expected version/structures, the presence of declared templates/patterns, and that the distributed fixtures are JSON. It does **not** replace a full Pan or Persephone conformance run.

## Testing dimensions

- **Profile structure:** parse JSON-LD and check the version, identifier and concept relationships (Pan).
- **Statement Template matching:** test synthetic positive examples and crafted negative mismatches (Persephone).
- **Runtime-to-Profile semantics:** check verb IDs, object types, `event-id`, category, and typed prepositional extension objects for emitted events.
- **Sequence integrity:** check unique consecutive `event-sequence` values per registration and the expected terminal order.
- **Complete Pattern matching:** requires independent positive and negative chronological streams for every modeled Pattern. **Do not claim that fixture or runtime checks alone prove full Pattern coverage.**

The production acceptance observation on November 14, 2026 verified a 497-statement completed run with consecutive per-registration sequence numbers. The recorded player data are not included here.
