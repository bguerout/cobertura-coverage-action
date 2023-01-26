#!/usr/bin/env bash
set -euo pipefail

diff-cover "${1}" -q --compare-branch=origin/main --json-report report.json
jq '.' report.json
