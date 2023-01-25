#!/usr/bin/env bash
set -euo pipefail

ls
diff-cover cobertura-coverage.xml -q --compare-branch=origin/master --json-report toto.json
