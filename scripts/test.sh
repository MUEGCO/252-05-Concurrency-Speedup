#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$repo_root"

make clean >/dev/null
make >/dev/null

run_case() {
    local mode="$1"
    local threads="$2"
    local items="$3"
    local rounds="$4"
    local seed="$5"

    ./bin/thread_checksum_lab "$mode" "$threads" "$items" "$rounds" "$seed" 2>&1 || true
}

out_single="$(run_case single 4 30000 40 12345)"
out_multi="$(run_case multi 4 30000 40 12345)"
out_multi_2="$(run_case multi 3 24000 55 7)"

echo "$out_single"
echo "$out_multi"
echo "$out_multi_2"

if [[ "$out_single" == *"TODO:"* ]] || [[ "$out_multi" == *"TODO:"* ]] || [[ "$out_multi_2" == *"TODO:"* ]]; then
    echo "visible test: starter TODO output detected" >&2
    exit 1
fi

# Deterministic constants from the reference solution.
expected_single_result="result: sum=64535332193422 xor=266014910 max=4294956448"
expected_single_meta="meta: mode=single threads=1 items=30000 rounds=40 seed=12345"
expected_multi_result="result: sum=64535332193422 xor=266014910 max=4294956448"
expected_multi_meta="meta: mode=multi threads=4 items=30000 rounds=40 seed=12345"
expected_multi2_result="result: sum=51740154392702 xor=3379218034 max=4294684809"
expected_multi2_meta="meta: mode=multi threads=3 items=24000 rounds=55 seed=7"