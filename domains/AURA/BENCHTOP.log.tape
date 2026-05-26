#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# BENCHTOP.log.tape — append-only event history (v1.2 split)
# Sibling: BENCHTOP.tape (architecture-current, editable)
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

# §Log — entries chronological, oldest first.

@A create_benchtop :: benchtop [d=2026-05-15 ok]
  => "BENCHTOP.tape created — structured SSOT of the §A.6 Stage-1+ hardware path: stage A–D status (all code-layer halves DONE: paper / FEM-tier / sim / hexa-native skeleton), the hardware-dependency → falsifier map (RT-SC tile · phantom skull · MEG/OPM · TMS · jaw stage · EEG/ADC · MRI · biocompat), and the non-physical external gates (collab / funding / FDA). Tracking ledger only — NOT a build, NOT funded, NOT a verify/* target; F-AURA 15 sub-IDs stay OPEN; sat-1 / RSC_SATURATED STOP / falsifier_check unchanged. INDEX.md core-tape table updated."
