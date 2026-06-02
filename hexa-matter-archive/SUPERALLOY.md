# SUPERALLOY — Phase D candidate stub

> **Authored**: 2026-05-13 (Phase A elevation) · **Status**: STUB — Phase D roadmap marker
> **Author**: 박민우 <nerve011235@gmail.com>
> **Target group**: GROUP_MET · **Phase D priority**: HIGH (per `USER_ACTION_REQUIRED.md §2`)
>
> Stub placeholder for the Phase D `superalloy` verb. Most depth content
> already lives in `METALLURGY-DEEP.md` §1-§3; this stub is the Phase D verb
> dispatcher slot.

---

## §1 Scope

A separate `superalloy/` verb (vs the existing `metallurgy/` verb) is justified because:
- Superalloy chemistry is *distinct* from general steel/alloy
- Production routes (Bridgman SX casting, VAR/ESR ingot, powder-bed AM) are specialized
- Industrial customers (aerospace, energy, nuclear) treat superalloy as a separate product category
- ASM Handbook devotes a separate sub-volume to superalloys

---

## §2 Content already in METALLURGY-DEEP.md

Per `METALLURGY-DEEP.md`:
- §1 — the 3 superalloy families (Ni-based, Co-based, Fe-Ni-based)
- §2 — Inconel 718 detailed (composition, heat treatment AMS 5662, properties)
- §3 — Single-crystal turbine blades (Bridgman casting, CMSX-4 / CMSX-10 / TMS-138)

When the `superalloy/` verb chapter is authored (Phase D), it should:
1. Cross-link to `METALLURGY-DEEP.md §1-§3` rather than duplicate
2. Add depth on **disc alloys** (René 95, Astroloy, Udimet 720 for turbine disc applications — distinct from blade alloys)
3. Add depth on **powder superalloy** — VIM (vacuum induction melting) + atomization + HIP consolidation
4. Add depth on **AM (Additive Manufacturing) superalloy** — Inconel 718 + 625 + 738 LPB-LF / EBM grades
5. Add depth on **TBC (Thermal Barrier Coating)** — YSZ (yttria-stabilized zirconia) deposited by EB-PVD or APS on superalloy substrate

---

## §3 Industrial scale + supply chain

- Global superalloy market: ~ $6-7 billion/year (2024)
- Top producers: Special Metals (Huntington Alloys), Haynes International, ATI Specialty Alloys, Doncasters, Fushun Special Steel
- End-use markets: aerospace ~ 60% (engine + airframe), industrial gas turbine ~ 25%, others ~ 15%

---

## §4 Real-limit anchors

- L5 melting point HARD_WALL ~ 4215 K (Ta₄HfC₅) — superalloys operate at 0.6-0.85 of T_m
- Inconel 718 use-T 650 °C ~ 0.55 × T_m (Ni T_m 1728 K → use at 650 °C = 923 K = 0.53)
- CMSX-4 use-T 1100 °C ~ 0.79 × T_m

---

## §5 Cross-links

- `METALLURGY-DEEP.md` §1-§3 — depth content already authored
- `metallurgy/metallurgy.md` + `SWORDSMITHING.md` — general metallurgy
- `CERAMIC-ENGINEERING.md` — TBC (YSZ) ceramic side
- `hexa-energy` — gas turbine engineering
- `hexa-mobility` — aerospace engine
- `LIMIT_BREAKTHROUGH.md` — L5 T_m / L6 ρ_max

---

## §6 Honest C3

Phase D candidate. Stub-level — most depth in `METALLURGY-DEEP.md`. When verb chapter is authored, will avoid duplication by cross-linking. Vendor figures (Special Metals Inconel 718, ATI Ti-6Al-4V) cited as published, no lattice fit. Per `LATTICE_POLICY §1.2`.

---

*Stub authored 2026-05-13 by 박민우 <nerve011235@gmail.com> as Phase D roadmap marker. Depth content in `METALLURGY-DEEP.md`.*
