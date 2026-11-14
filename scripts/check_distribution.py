#!/usr/bin/env python3
"""Small structural distribution check; not an xAPI conformance validator."""
import json
from pathlib import Path

root = Path(__file__).resolve().parent.parent
profile = json.loads((root / "scarymansion-profile-v4.jsonld").read_text())
fixtures = json.loads((root / "fixtures" / "template-positive-v4.json").read_text())
assert profile["type"] == "Profile"
assert any(v.get("id") == "https://github.com/blakeplock/ScaryMansion/xapi/v4" for v in profile["versions"])
assert len(profile["templates"]) == 74
assert len(profile["patterns"]) == 17
assert len(profile["concepts"]) > 0
print("Distribution structure OK: 74 templates, 17 patterns, v4 identifier present")
print("Synthetic fixture collection parsed as:", type(fixtures).__name__)
print("Note: this is not full xAPI Profile or Statement Template validation")
