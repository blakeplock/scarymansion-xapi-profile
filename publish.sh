#!/usr/bin/env bash
# Creates a NEW public distribution repo with a limited, reviewed file set.
# Does not change the private ScaryMansion repository or its visibility.
set -euo pipefail

NAME="scarymansion-xapi-profile"
OWNER="blakeplock"
SOURCE="$OWNER/ScaryMansion"
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

for tool in gh git python3; do
  command -v "$tool" >/dev/null || { echo "Missing dependency: $tool" >&2; exit 1; }
done

gh auth status >/dev/null || { echo "Sign in first: gh auth login" >&2; exit 1; }
if [ -d .git ]; then
  echo "This distribution directory already has Git history. Use a clean extracted folder." >&2
  exit 1
fi
if gh repo view "$OWNER/$NAME" >/dev/null 2>&1; then
  echo "Repository $OWNER/$NAME already exists. Refusing to overwrite." >&2
  exit 1
fi

# Download only the two allowlisted, non-executable xAPI artifacts.
for mapping in \
  'xapi/scarymansion-profile-v4.jsonld:scarymansion-profile-v4.jsonld' \
  'xapi/fixtures/template-positive-v4.json:fixtures/template-positive-v4.json'; do
  src="${mapping%%:*}"
  dst="${mapping#*:}"
  GH_SOURCE="$SOURCE" GH_PATH="$src" GH_OUT="$dst" python3 - <<'PY'
import base64, json, os, subprocess
repo = os.environ['GH_SOURCE']
path = os.environ['GH_PATH']
raw = subprocess.check_output(['gh', 'api', f'repos/{repo}/contents/{path}?ref=main'], text=True)
result = json.loads(raw)
assert result.get('encoding') == 'base64', 'Expected GitHub Contents base64 response'
data = base64.b64decode(result['content']).decode('utf-8')
json.loads(data)
with open(os.environ['GH_OUT'], 'w', encoding='utf-8') as fh:
    fh.write(data)
print('Imported approved file:', path)
PY
done

# This is the canonical license text returned by GitHub's license API.
gh api licenses/apache-2.0 --jq .body > LICENSE
python3 scripts/check_distribution.py

# Explicit privacy review before any public write.
python3 - <<'PY'
import json, pathlib
root = pathlib.Path('.')
allowed = {
    'README.md', 'NOTICE', 'LICENSE', '.gitignore', 'publish.sh',
    'scarymansion-profile-v4.jsonld', 'fixtures/template-positive-v4.json',
    'docs/SEMANTICS.md', 'docs/ANALYTICS.md', 'docs/VALIDATION.md',
    'scripts/check_distribution.py',
}
actual = {str(p) for p in root.rglob('*') if p.is_file() and '.git' not in p.parts and '__pycache__' not in p.parts}
if actual != allowed:
    raise SystemExit(f'File allowlist mismatch. Extra={actual-allowed} Missing={allowed-actual}')
profile = json.loads((root / 'scarymansion-profile-v4.jsonld').read_text())
fixtures = json.loads((root / 'fixtures/template-positive-v4.json').read_text())
assert len(fixtures) == 74
assert all(s.get('actor',{}).get('account',{}).get('name') == 'test-player-001' for s in fixtures)
assert all(s.get('context',{}).get('registration') == '11111111-2222-4333-8444-555555555555' for s in fixtures)
assert len(profile.get('templates',[])) == 74
assert len(profile.get('patterns',[])) == 17
assert len((root / 'LICENSE').read_text()) > 10000
print('PUBLICATION AUDIT PASSED: allowed files only, synthetic statements, full Apache-2.0 license')
PY

# Create brand-new root commit. No private source commits/history are imported.
git init -b main
git add README.md NOTICE LICENSE .gitignore publish.sh \
  scarymansion-profile-v4.jsonld fixtures/template-positive-v4.json \
  docs/SEMANTICS.md docs/ANALYTICS.md docs/VALIDATION.md scripts/check_distribution.py
git commit -m "Publish ScaryMansion xAPI v4 Profile under Apache 2.0"

gh repo create "$OWNER/$NAME" --public --source=. --remote=origin --push \
  --description "Public xAPI v4 Profile, synthetic fixtures, and analytics documentation for ScaryMansion"

echo "PUBLIC REPOSITORY CREATED: https://github.com/$OWNER/$NAME"
echo "PRIVATE ScaryMansion repository visibility was not changed."
