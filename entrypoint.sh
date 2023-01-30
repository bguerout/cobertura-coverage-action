#!/usr/bin/env bash
set -euo pipefail

xq '.coverage."@line-rate"' sample/.coverage/cobertura-coverage.xml
diff-cover "${1}" -q --compare-branch=origin/main --json-report report.json
jq '.' report.json
