#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
if command -v swipl >/dev/null; then
  (cd tests && swipl -q -f test_q1.pl -g run_tests -t halt)
  (cd tests && swipl -q -f test_q2.pl -g run_tests -t halt)
else
  echo 'SWI-Prolog not installed; skipping P1/P2 tests' >&2
fi
if command -v racket >/dev/null; then
  for n in 3 4; do
    tmp=$(mktemp --suffix=.rkt)
    out=$(mktemp)
    cat "code/id_q${n}.rkt" "tests/test_q${n}.calls" > "$tmp"
    racket "$tmp" > "$out"
    diff -u "tests/test_q${n}.expected" "$out"
    rm -f "$tmp" "$out"
    echo "S$((n-2)) OK"
  done
else
  echo 'Racket not installed; skipping S1/S2 tests' >&2
fi
