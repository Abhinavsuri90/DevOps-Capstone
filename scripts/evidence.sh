#!/usr/bin/env bash
# Evidence recorder used for the transcripts in evidence/.
# Student: Abhinav
#
# Usage:
#   source scripts/evidence.sh
#   EVIDENCE=evidence/03-kubernetes-helm.txt
#   run kubectl get pods -n spendwise
#   note "Waiting 60s for metrics"
#
# Every command is written to $EVIDENCE as "$ <command>" followed by its real
# stdout/stderr, so each PNG in screenshots/ can cite exact lines.

run() {
  : "${EVIDENCE:?set EVIDENCE to the transcript file first}"
  mkdir -p "$(dirname "$EVIDENCE")"
  printf '$ %s\n' "$*" >> "$EVIDENCE"
  printf '$ %s\n' "$*"
  { eval "$*"; } 2>&1 | tee -a "$EVIDENCE"
  local rc="${PIPESTATUS[0]:-${pipestatus[1]}}"
  # Keep the next "$ command" on its own line when output lacks a final newline.
  if [ -s "$EVIDENCE" ] && [ -n "$(tail -c 1 "$EVIDENCE")" ]; then
    echo | tee -a "$EVIDENCE"
  fi
  return "$rc"
}

note() {
  : "${EVIDENCE:?set EVIDENCE to the transcript file first}"
  mkdir -p "$(dirname "$EVIDENCE")"
  printf '# %s\n' "$*" | tee -a "$EVIDENCE"
}
