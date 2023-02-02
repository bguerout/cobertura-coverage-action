#!/usr/bin/env bash
set -euo pipefail

readonly OUTPUT_DIR="${PWD}/output/cobertura-coverage"

function get_total_coverage() {
  xq '.coverage."@line-rate"' "${1}" | sed "s/\"//g" | xargs -I {} echo "{}*100" | bc | xargs printf "%.0f"
}

function get_new_lines_coverage() {
  diff-cover "${1}" -q --diff-range-notation '..' --compare-branch=origin/main --json-report "${OUTPUT_DIR}/diff-report.json"
  jq '.total_percent_covered' "${OUTPUT_DIR}/diff-report.json"
}

function build_json(){
  local cobertura_xml_file=${1}
  local new_lines_coverage
  new_lines_coverage=$(get_new_lines_coverage "${cobertura_xml_file}")
  local total_coverage
  total_coverage=$(get_total_coverage "${cobertura_xml_file}")

  local json;
  json=$(cat <<EOT
{
  "total_coverage":"${total_coverage}",
  "new_lines_coverage":"${new_lines_coverage}",
}
EOT
)
  echo "$json"
}

git config --global --add safe.directory /github/workspace
git fetch origin main:refs/remotes/origin/main
mkdir -p "${OUTPUT_DIR}"

build_json "$@" > "${OUTPUT_DIR}/cobertura-coverage-stats.json"
cat "${OUTPUT_DIR}/cobertura-coverage-stats.json"

