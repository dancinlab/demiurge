#!/bin/bash
# audit_attestation_records.sh — Stage 3 enforcement hook (constitution.md v1.4.0 R4)
#
# Scans `exports/material_attestation/` (and optionally further `exports/` dirs)
# for R4 invariant violations. Whereas Stage 1 (Swift Codable) enforces at
# decode time and Stage 2 (`check_rtsc_claim.sh`) enforces at paper-compile
# time, Stage 3 sweeps the on-disk attestation corpus and labels each record
# as one of:
#
#   - violation    (Class 1 · namespace exploit · "Pattern 1")
#                  domain=rtsc + absorbed=true + missing/non-ALL_PASS
#                  rtsc_5_gate_evaluation block;
#                  OR domain=rtsc + kind contains lts|hts hints with no proper
#                  5-gate block (likely device-namespace mis-labelled as
#                  material-domain).
#   - historical   record pre-dates R4 Stage 1 migration (2026-05-22) and is
#                  intentionally kept for audit evidence per
#                  inbox/notes/2026-05-21-r4-stage1-enforcement.md
#                  (Path B leaves the original rtsc-namespaced file as
#                  *historical artifact* alongside the new lts-namespaced
#                  emission). Detected by filename prefix `rtsc_*` AND/OR
#                  embedded stamp timestamp < 20260522T000000Z.
#   - ok           no rtsc-domain absorbed=true OR domain=rtsc + absorbed=true
#                  AND rtsc_5_gate_evaluation.aggregate == ALL_PASS.
#
# Class 2 violations (RTSC.md §8.9 matrix presence / staleness) are checked
# separately and exit code 2 is reserved for that mode.
#
# API:
#   audit_attestation_records.sh <dir> [--json] [--strict]
#
# Exit codes:
#   0   clean (no new violation; historical-only or all-ok)
#   1   at least one new (non-historical) violation
#   2   RTSC.md §8.9 matrix missing/malformed
#   3   exports/material_attestation directory missing (or arg invalid)
#

set -euo pipefail

usage() {
  cat <<EOF
usage: $0 <exports-dir> [--json] [--strict]

  <exports-dir>  e.g. exports/material_attestation/  (recursively scanned)
  --json         emit machine-readable JSON to stdout (in addition to summary
                 on stderr)
  --strict       exit non-zero on ANY historical record too (default: 0)
EOF
}

# ---------------- arg parse ----------------
if [ "$#" -lt 1 ]; then
  usage >&2
  exit 64
fi

SCAN_DIR=""
JSON_OUT=0
STRICT=0

for arg in "$@"; do
  case "$arg" in
    --json) JSON_OUT=1 ;;
    --strict) STRICT=1 ;;
    --help|-h) usage; exit 0 ;;
    -*) echo "[audit_attestation] unknown flag: $arg" >&2; usage >&2; exit 64 ;;
    *)
      if [ -z "$SCAN_DIR" ]; then
        SCAN_DIR="$arg"
      else
        echo "[audit_attestation] only one <exports-dir> permitted" >&2
        usage >&2
        exit 64
      fi
      ;;
  esac
done

if [ -z "$SCAN_DIR" ]; then
  usage >&2
  exit 64
fi
SCAN_DIR="${SCAN_DIR%/}"

if [ ! -d "$SCAN_DIR" ]; then
  echo "[audit_attestation] error: scan-dir not found: $SCAN_DIR" >&2
  exit 3
fi

# Locate repo root (for resolving RTSC.md / inbox cross-refs).
REPO_ROOT=$(cd "$SCAN_DIR" && git rev-parse --show-toplevel 2>/dev/null || true)
if [ -z "$REPO_ROOT" ]; then
  # Fallback: walk up from $SCAN_DIR looking for RTSC.md.
  d="$SCAN_DIR"
  while [ "$d" != "/" ] && [ ! -f "$d/RTSC.md" ]; do
    d=$(dirname "$d")
  done
  if [ -f "$d/RTSC.md" ]; then
    REPO_ROOT="$d"
  fi
fi

# ---------------- Class 2: RTSC.md §8.9 matrix sanity ----------------
if [ -n "$REPO_ROOT" ] && [ -f "$REPO_ROOT/RTSC.md" ]; then
  CLASS2_OUT=$(REPO_ROOT="$REPO_ROOT" python3 - <<'PY'
import os, re, sys
root = os.environ["REPO_ROOT"]
p = os.path.join(root, "RTSC.md")
with open(p, "r", encoding="utf-8") as f:
    txt = f.read()
# Locate "## 8.9 " heading and assert it contains a table with the 5 gate rows.
m = re.search(r"^##\s*8\.9\s.*$", txt, flags=re.MULTILINE)
if not m:
    print("MISSING_HEADING")
    sys.exit(0)
section = txt[m.end():]
# Cut off at next "## 8.10" heading.
nxt = re.search(r"^##\s*8\.10\s", section, flags=re.MULTILINE)
if nxt:
    section = section[:nxt.start()]
# Need at least one markdown table with the 5 gate labels (a)..(e).
hits = 0
for tag in ("(a)", "(b)", "(c)", "(d)", "(e)"):
    if tag in section:
        hits += 1
if hits < 5:
    print(f"INCOMPLETE_MATRIX::{hits}/5")
    sys.exit(0)
# Last edit date (file mtime, ISO-8601 UTC-naive).
import datetime as dt
mtime = dt.datetime.fromtimestamp(os.path.getmtime(p), dt.timezone.utc)
print(f"OK::{mtime.isoformat()}")
PY
)
  case "$CLASS2_OUT" in
    OK::*) RTSC_MD_STATE="${CLASS2_OUT#OK::}"; RTSC_MD_OK=1 ;;
    MISSING_HEADING)
      echo "[audit_attestation] FAIL (Class 2): RTSC.md §8.9 heading missing" >&2
      exit 2 ;;
    INCOMPLETE_MATRIX::*)
      echo "[audit_attestation] FAIL (Class 2): RTSC.md §8.9 5-gate matrix incomplete (${CLASS2_OUT#INCOMPLETE_MATRIX::} rows)" >&2
      exit 2 ;;
    *)
      echo "[audit_attestation] FAIL (Class 2): unexpected RTSC.md §8.9 probe output: $CLASS2_OUT" >&2
      exit 2 ;;
  esac
else
  RTSC_MD_STATE="UNKNOWN (RTSC.md not located from scan-dir)"
  RTSC_MD_OK=0
fi

# ---------------- Class 1: per-record scan ----------------
# Emit one line per record:
#   <verdict>\t<path>\t<note>
# where <verdict> ∈ {ok, historical, violation}.
RESULT_LINES=$(SCAN_DIR="$SCAN_DIR" python3 - <<'PY'
import json, os, re, sys
from pathlib import Path

scan_dir = Path(os.environ["SCAN_DIR"])

# Historical cutoff: any record dated < 2026-05-22 is "pre-R4 Stage 1
# migration" and thus intentional historical evidence rather than a new
# violation. Heuristic: prefer the `stamp` field inside the JSON; fall back to
# any 8-digit YYYYMMDD prefix in the filename (e.g. "20260521T...Z"); else fall
# back to file mtime.
CUTOFF = "20260522"   # YYYYMMDD lexicographic compare

LTS_HTS_HINT = re.compile(r"\b(lts|hts)\b", re.IGNORECASE)

def stamp_yyyymmdd(rec, path):
    s = rec.get("stamp") if isinstance(rec, dict) else None
    if isinstance(s, str) and len(s) >= 8 and s[:8].isdigit():
        return s[:8]
    # Fallback: filename embed.
    m = re.search(r"(\d{8})T?\d*Z?", path.name)
    if m:
        return m.group(1)
    # Last resort: mtime.
    import datetime as dt
    return dt.datetime.utcfromtimestamp(path.stat().st_mtime).strftime("%Y%m%d")

records = sorted(scan_dir.rglob("*.json"))

for p in records:
    try:
        with p.open("r", encoding="utf-8") as f:
            rec = json.load(f)
    except Exception as e:
        print(f"violation\t{p}\tmalformed JSON: {e}")
        continue

    if not isinstance(rec, dict):
        print(f"violation\t{p}\ttop-level JSON is not an object")
        continue

    domain   = rec.get("domain")
    absorbed = rec.get("absorbed")
    kind     = rec.get("kind") or ""
    gate     = rec.get("rtsc_5_gate_evaluation")

    # Only rtsc+absorbed=true is gated by R4.
    if domain != "rtsc" or absorbed is not True:
        # Non-rtsc OR not absorbed=true → not subject to R4.
        print(f"ok\t{p}\tdomain={domain} absorbed={absorbed} (R4 N/A)")
        continue

    # rtsc + absorbed=true path.
    # 1. Check 5-gate field.
    aggregate = None
    if isinstance(gate, dict):
        for k in ("aggregate", "aggregate_verdict", "verdict", "result"):
            if k in gate:
                aggregate = gate[k]
                break

    legit = (aggregate == "ALL_PASS")

    if legit:
        print(f"ok\t{p}\tdomain=rtsc absorbed=true aggregate=ALL_PASS (legitimate)")
        continue

    # Not legit → either historical or violation.
    ymd = stamp_yyyymmdd(rec, p)
    is_historical = ymd < CUTOFF
    # Extra Pattern-1 hint: kind contains "lts" or "hts" while domain=rtsc.
    pattern1_hint = bool(LTS_HTS_HINT.search(kind))

    if is_historical:
        note = f"pre-R4 historical (stamp_ymd={ymd} < {CUTOFF}); "
        if gate is None:
            note += "no rtsc_5_gate_evaluation field"
        else:
            note += f"aggregate={aggregate}"
        if pattern1_hint:
            note += " · kind hints lts/hts (Pattern 1 evidence)"
        print(f"historical\t{p}\t{note}")
    else:
        if gate is None:
            why = "missing rtsc_5_gate_evaluation"
        elif aggregate is None:
            why = "rtsc_5_gate_evaluation lacks aggregate"
        else:
            why = f"aggregate={aggregate} (not ALL_PASS)"
        if pattern1_hint:
            why += " · kind hints lts/hts → Pattern 1 (namespace exploit)"
        print(f"violation\t{p}\t{why}")
PY
)

# ---------------- aggregate + report ----------------
OK_CNT=0
HIST_CNT=0
VIOL_CNT=0

while IFS=$'\t' read -r verdict path note; do
  [ -z "${verdict:-}" ] && continue
  case "$verdict" in
    ok) OK_CNT=$((OK_CNT + 1)) ;;
    historical) HIST_CNT=$((HIST_CNT + 1)) ;;
    violation) VIOL_CNT=$((VIOL_CNT + 1)) ;;
  esac
done <<< "$RESULT_LINES"

# Human-readable summary → stderr if --json, else stdout.
SUMMARY_FD=1
if [ "$JSON_OUT" -eq 1 ]; then
  SUMMARY_FD=2
fi

{
  echo "[audit_attestation] scan-dir: $SCAN_DIR"
  echo "[audit_attestation] RTSC.md §8.9 matrix: ${RTSC_MD_STATE}"
  echo "[audit_attestation] per-record verdicts:"
  while IFS=$'\t' read -r verdict path note; do
    [ -z "${verdict:-}" ] && continue
    rel="${path#$SCAN_DIR/}"
    printf "  [%-10s] %s — %s\n" "$verdict" "$rel" "$note"
  done <<< "$RESULT_LINES"
  echo "[audit_attestation] summary: $OK_CNT ok · $HIST_CNT historical · $VIOL_CNT violations"
} >&$SUMMARY_FD

# JSON output.
if [ "$JSON_OUT" -eq 1 ]; then
  RESULT_LINES="$RESULT_LINES" RTSC_MD_STATE="$RTSC_MD_STATE" \
  OK_CNT="$OK_CNT" HIST_CNT="$HIST_CNT" VIOL_CNT="$VIOL_CNT" \
  SCAN_DIR="$SCAN_DIR" python3 - <<'PY'
import json, os
lines = os.environ["RESULT_LINES"].splitlines()
records = []
for ln in lines:
    if not ln.strip():
        continue
    parts = ln.split("\t", 2)
    if len(parts) != 3:
        continue
    verdict, path, note = parts
    records.append({"verdict": verdict, "path": path, "note": note})
out = {
    "scan_dir": os.environ["SCAN_DIR"],
    "rtsc_md_8_9": os.environ["RTSC_MD_STATE"],
    "summary": {
        "ok": int(os.environ["OK_CNT"]),
        "historical": int(os.environ["HIST_CNT"]),
        "violation": int(os.environ["VIOL_CNT"]),
    },
    "records": records,
}
print(json.dumps(out, indent=2, ensure_ascii=False))
PY
fi

# ---------------- exit code policy ----------------
if [ "$VIOL_CNT" -gt 0 ]; then
  exit 1
fi
if [ "$STRICT" -eq 1 ] && [ "$HIST_CNT" -gt 0 ]; then
  # In --strict mode historical records also fail; but distinguish from real
  # violations: still exit 1 (caller can introspect counts via --json).
  exit 1
fi
exit 0
