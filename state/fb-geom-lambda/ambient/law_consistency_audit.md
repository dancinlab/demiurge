# LAW-CONSISTENCY AUDIT — ambient-room-T LAW SET (③ direction)

> 📐 RTSC LAW-DISCOVERY lane · `state/fb-geom-lambda/ambient/`
> GOAL: audit the ambient-room-T LAW SET in `ARCHITECTURE.json LAWS[]` for (a) internal
> consistency, (b) NEXUS cross-link completeness, (c) the COMPLETENESS CRITIC — what law is
> MISSING to fully close the ambient-room-T question? A missing law IS a new discovery.
> Date: 2026-06-20 · read-only analysis · NO commit / NO ARCHITECTURE.json edit / NO pod.
> Verify bar: c2/d6 — consistency matrix (pass/contradiction per pair), NEXUS edge list,
> numeric check, ONE named most-load-bearing missing law.

---

## 0. The law set under audit (8 laws)

| # | LAW id | one-line claim | verdict color |
|---|--------|----------------|---------------|
| L1 | ROOMT-AMBIENT-PASS-CRITERIA | the gate ladder; bottleneck = TIER-1 #4 (Tc≥293K@1atm) | 🟡 gate (SSOT) |
| L2 | HYDRIDE-PRESSURE-LOCK | room-T hydride CLOSED (high Tc ⇔ high P); sub-160K ambient-metastable OPEN | 🔴/🟡 |
| L3 | OMEGA-LAMBDA-TRADEOFF-CEILING | ambient conventional el-ph ceiling ~100-130K (ω_log↔λ) ≪ 293K | 🧱 |
| L4 | AMBIENT-VERIFIED-CEILING-134K | verified ambient record = Hg-1223 ~134K; all RT claims debunked | 🧱 |
| L5 | AMBIENT-TC-CEILING | 293K@1atm = BOUNDED-BUT-NOT-FORBIDDEN; must-break = 1atm dynamic stability | 🌡️ (b) |
| L6 | EXOTIC-GLUE-CAPPED | all beyond-BCS glues capped <134K; sole escape = metallic-H-like (unproven) | 🧱 |
| L7 | FB-GEOM-LAMBDA | flat-band geometry SUPPRESSES λ (Welch floor Q_geom≥1/N); non-discriminating throttle | 🟡/🔵 |
| L8 | FB-BIPOLARON-STIFFNESS-BOUND | OVERTURNED — flat-band stiffness is GEOMETRIC (Peotta-Törmä), cap was artifact; room-T OPEN for high-⟨g⟩ kagome-class host | 🔴→🟢 |

(L7/L8 are the el-ph-side and pairing-side companions of the same flat-band quantum geometry ⟨g⟩;
the closing meta-node `master_closing_formula` + `TC-DESCRIPTOR` frame them.)

---

## 1. CONSISTENCY MATRIX (pairwise — pass / contradiction)

Legend: ✅ = coherent (no contradiction) · ⚠ = apparent-tension-RECONCILED · ✖ = real contradiction.

| pair | relation | verdict |
|------|----------|---------|
| L1×L2 | L2 is L1-gate #4+#2 applied to hydrides (room-T FAIL, sub-160K open) | ✅ instance-of |
| L1×L3 | L3 is L1-gate #4 applied to light-clathrates (FAIL by ≥170K) | ✅ instance-of |
| L1×L4 | L4 supplies L1's empirical anchor; TIER-2 B+E gates are what caught LK-99/Dias | ✅ validates L1 |
| L1×L5 | L5 supplies the MATH for why L1 #4 is the bottleneck (1atm dyn-stability) | ✅ derives-bottleneck |
| L1×L6 | L6 is L1-gate #4 applied to ALL non-phonon glues (FAIL) | ✅ instance-of |
| L2×L3 | both: conventional el-ph ambient FAILS #4 by a PHYSICAL (not sampling) bound | ✅ converge |
| L2×L4 | hydrides closed + cuprate 134K record; no overlap, both ambient-ceiling facts | ✅ |
| L2×L6 | both name metallic-H-like as the sole in-principle ≥293K escape (both: unproven, GPa-locked) | ✅ converge |
| L3×L4 | predicted conv ceiling ~100-130K vs VERIFIED record 134K (cuprate=magnetic, not el-ph) | ✅ see §3 |
| L3×L6 | L3=el-ph branch, L6=non-phonon branch of the SAME #4 wall; both capped | ✅ partition |
| L4×L6 | 134K verified = L6's magnetic-glue cuprate entry; mutually consistent | ✅ |
| **L3×L5** | **L3 says "PHYSICAL bound, gap is a physical wall" / L5 says "BOUNDED-NOT-FORBIDDEN, no no-go theorem"** | **⚠ RECONCILED (the key pair)** |
| **L4×L5** | L4 "CLOSED, unmoved since 1993" / L5 "not forbidden" | ⚠ RECONCILED |
| **L6×L5** | L6 "every glue structurally capped" / L5 "no hard no-go" | ⚠ RECONCILED |
| L5×L8 | L5 names off-diagonal bond-Peierls/bipolaron Regime II (μ_M≳1, NO proven ceiling) as escape; L8 is exactly that route, room-T OPEN | ✅ same escape |
| L6×L8 | **APPARENT CONTRADICTION**: L6 lists "bipolaron/BEC SSH ~20-70K (mass-Tc tension)" + "flat-band geometric ~tens-K (2026 no-go arXiv:2604.04719)" as CAPPED, but L8 says that very cap is an ARTIFACT and room-T is OPEN for high-⟨g⟩ hosts | ⚠ RECONCILED → see §1a (most load-bearing internal tension) |
| L7×L8 | L7: geometry SUPPRESSES λ (el-ph); L8: same ⟨g⟩ ENHANCES superfluid stiffness (pairing). Opposite-sign on PURPOSE | ✅ opposite-sign companions (explicitly noted in both) |
| L7×L3 | L7 explains WHY flat-band SCs sit at λ≈0.25-0.8 not >1 (Q_geom~1/3 throttle) → supports L3 conv ceiling | ✅ |

**No ✖ hard contradiction. Two reconcilable tensions: the (L3,L4,L6)×L5 "closed vs not-forbidden"
family, and the L6×L8 "bipolaron/flat-band capped vs artifact-overturned" pair.**

### 1a. Reconciliation of the (closed)×(not-forbidden) tension — IS it coherent?

**YES, coherent, by a quantifier split.** The three "closed" laws (L3,L4,L6) and the "not-forbidden"
law (L5) are NOT talking about the same proposition:

- **L3/L4/L6 close a FAMILY each, under a NAMED mechanism, given today's chemistries**: "conventional
  el-ph ≤130K" (L3), "verified record 134K" (L4 — an *empirical* statement, not a theorem),
  "every *known* beyond-BCS glue capped by a *named intrinsic* bound" (L6). Each is a bound
  **conditional** on (mechanism × demonstrated chemistry).
- **L5 closes nothing — it audits the bounds themselves** and finds none is a hard no-go *theorem*:
  the el-ph cap is conditional on λ≲4 (DISPUTED by Sadovskii 2025) and on 1-atm lattice dynamic
  stability under 293K-strength coupling (Moussa-Cohen bound-2, a *softening* assumption, not a
  proof). So 293K@1atm = **(b) bounded-but-not-forbidden**.

These compose without contradiction as: **"conventional + every-demonstrated-exotic is closed
(L3,L4,L6); the residual escape is the ONE assumption no law has proven (1-atm dynamic stability
under strong coupling, OR non-adiabatic Regime II), which L5 isolates and L8 opens."** This is
exactly the intended "conventional closed, fundamental not-forbidden" architecture — **COHERENT**.

The honest seam: L4's word "CLOSED" is an *empirical-record* CLOSED (no lead today), NOT a
*theoretical* CLOSED — its own text says "the single deciding question remains open." Same for L6
("sole in-principle ≥293K escape = metallic-H-like"). Neither claims a theorem. So they do not
contradict L5. ✅

### 1b. L6×L8 — the one tension that should be FLAGGED (not yet fully reconciled in the ledger)

L6 (dated lens-survey) cites **arXiv:2604.04719 "flat-band geometric ~tens-K, geometry NOT the Tc
knob"** and **"bipolaron mass-Tc tension ~20-70K"** as *named intrinsic caps*. L8 **OVERTURNS exactly
this**: the mass-Tc / t**·n cap is an artifact because flat-band condensate stiffness is the
Peotta-Törmä GEOMETRIC weight D_s=4|U|ν(1-ν)⟨g⟩ (finite at t→0), and high-⟨g⟩ kagome-class hosts
re-open room-T (COF 90-181K sized; SOC-kagome ⟨g⟩2.3 → 288-577K TB-class ceiling).

**This is the single internal inconsistency in the set**: L6 still records the bipolaron/flat-band
channel as *capped by a named bound*, while L8 has demoted that same bound to *artifact, room-T OPEN*.
They are not in violent contradiction (L8 is the *newer, more-resolved* node and L5 already routes the
escape through L8), but **L6's scoreboard line for "bipolaron/BEC SSH ~20-70K" and "flat-band
geometric ~tens-K" is STALE relative to L8** and should be annotated "superseded by
FB-BIPOLARON-STIFFNESS-BOUND geom-stiffness breakthrough — cap is artifact for high-⟨g⟩ hosts."
Flagged, not auto-fixed (read-only audit). Severity: LOW (does not change L6's headline — metallic-H
is still the only *demonstrated-material* ≥293K route; L8's escape is a *TB structure-class* ceiling
needing a named material, gate #1 still open).

---

## 2. NEXUS edge list (reuses[] / provides[]) — is the argument CONNECTED?

Only **L5 (AMBIENT-TC-CEILING)** carries explicit `reuses:`/`provides:` fields. The rest encode edges
narratively ("converges with", "consistent with", "instance of gate #4"). Reconstructed graph:

```
                         L1 ROOMT-AMBIENT-PASS-CRITERIA  (the GATE; SSOT root)
                              │  gate #4 (Tc≥293K@1atm) = the bottleneck
        ┌──────────┬─────────┼──────────┬───────────────┐
        ▼          ▼         ▼          ▼               ▼
   L2 HYDRIDE   L3 ΩλCEIL  L4 134K   L6 EXOTIC-GLUE   (each = gate#4 applied to one family)
   (hydride)    (el-ph)   (record)   (non-phonon)
        │          │         │          │
        └────┬─────┴────┬────┴────┬─────┘
             ▼          ▼         ▼
            L5 AMBIENT-TC-CEILING  ── reuses: FB-GEOM-LAMBDA(L7) + 2-regime closing formula + L1 gate#4
             │  provides: "the math WHY #4 is the bottleneck"
             │  isolates the ONE must-break assumption (1atm dyn-stability / Regime II)
             ▼
            L8 FB-BIPOLARON-STIFFNESS-BOUND  ◄── the ONE escape (off-diagonal bond-Peierls / geometric stiffness)
             ▲                                     reuses L7's ⟨g⟩ (opposite sign)
             │ opposite-sign companion
            L7 FB-GEOM-LAMBDA (Welch floor; el-ph suppression)
```

**Connectivity check:**
- L1 → {L2,L3,L4,L6} : ✅ each ceiling is "gate #4 applied to a family" (instance edges, narrative).
- {L3,L4,L6} → L5 : ✅ L5 "reuses 2-regime closing formula" and "converges with" each; L5 provides the math for the bottleneck.
- L5 → L8 : ✅ L5's verdict explicitly routes the escape to "off-diagonal bond-Peierls FB-BIPOLARON escape" = L8.
- L7 ↔ L8 : ✅ opposite-sign companions (both nodes name each other).
- L5 reuses L7 : ✅ explicit.

**Pass-criteria → each ceiling → the one escape forms a CONNECTED argument.** ✅

**ORPHAN check:** No orphan law. BUT a **partial orphan-edge gap**: L2 (hydride) and L4 (record) have
NO outgoing edge to the escape node L8 — they terminate ("closed") without a reuses/provides pointer.
That is fine semantically (they ARE terminal closures), but the *ledger* lacks machine-readable
`reuses/provides` on L1-L4,L6,L7,L8 — only L5 has them. **NEXUS completeness = narratively connected,
but only 1 of 8 laws carries structured reuse edges.** Recommend (not done here): add
`reuses/provides` to L1 (provides: gate#4 to all), L7 (provides: ⟨g⟩ to L5+L8), L8 (reuses: L7 ⟨g⟩;
the escape terminus). LOW severity — argument is connected; only the SSOT structure is uneven.

---

## 3. NUMERIC CONSISTENCY CHECK

| quantity | value | source law | check |
|----------|-------|-----------|-------|
| el-ph conventional ambient ceiling | ~100-130K (predicted), measured ≤39K (MgB2) | L3 | — |
| el-ph ambient ceiling (math, μ*=0.10) | ~150-200K (λ≲4, ω_log≲155meV) | L5 | see below |
| magnetic-glue ambient ceiling | ~130-160K (Tc≲0.1·J/kB, J≲150meV) | L5 | — |
| light-clathrate top predicted | H-doped c-BN ~122K (λ1.98) | L3 | — |
| VERIFIED ambient record | Hg-1223 ~134K (cuprate, magnetic) | L4 | — |
| bipolaron/SSH (pre-overturn) | ~20-70K | L6/L8 | superseded by L8 |
| geometric bipolaron (sized) | COF 90-181K; SOC-kagome 288-577K | L8 | TB-class |

**(a) el-ph predicted (L3 ~100-130K) vs el-ph math (L5 ~150-200K):** these differ by ~50K. RECONCILED:
L3 is the **practically-attainable** ceiling (Gao 2025 screening of >20000 real metals — what a
lattice-stable solid actually delivers), L5 is the **formula upper bound** (λ at the disputed λ≲4 cap,
ω_log at the atomic-mass budget — a *generous* bound). L5's own python gives Li2AgH6-class
ω95meV×λ2=158K, ×λ4=221K — i.e. the 150-200K is the *optimistic envelope*, 100-130K the *realistic*.
Consistent: realistic ⊂ optimistic-envelope. ✅

**(b) magnetic ~130-160K (L5) vs verified 134K cuprate (L4):** Hg-1223 134K sits **exactly inside** the
magnetic-glue bound 130-160K, near its lower-mid. ✅ **The cuprate record sits correctly under the
magnetic bound.** L5's own arithmetic: Tc/J = 134K/(150meV) ≈ 0.077, and L4-text gives Hg-1223
Tc/J=0.089 — both ≈0.08-0.09, consistent with the empirical Tc≲0.1·J/kB cuprate bound. To reach 293K
needs J≈250meV (~1.9× cuprate) + metallic channel = unrealized. ✅ numerically self-consistent.

**(c) light-clathrate ~122K (L3) vs verified 134K (L4):** predicted best light-clathrate (122K) sits
just *below* the verified cuprate record (134K) — consistent (no light-clathrate has *measured* near
its prediction; measured tops ~39K MgB2). The 122K is predicted/SSCHA, the 134K is measured-magnetic;
different mechanism, no conflict. ✅

**(d) all four mutually consistent?** YES. Ordering: measured-el-ph (39K) < predicted-light-clathrate
(122K) ≲ verified-record (134K, magnetic) < magnetic-bound (160K) ≲ el-ph-math-envelope (200K) ≪ 293K.
Every number is monotone-consistent and the verified 134K record sits correctly: above all *measured*
el-ph, at the *low-mid* of the magnetic bound, below the optimistic envelopes — and **159K short of
293K**, the unmoved gap. ✅ **NUMERIC SET CONSISTENT.**

---

## 4. COMPLETENESS CRITIC — what law is MISSING? (the discovery)

The set closes (i) every demonstrated **mechanism/family** (L2,L3,L4,L6), (ii) the **bound-status**
meta-question (L5: not-forbidden), and (iii) the **el-ph⟨g⟩ suppression** + **pairing-⟨g⟩ stiffness
escape** (L7,L8). What it does NOT yet bound is **whether the one open escape (L8 geometric/non-
adiabatic bipolaron in a high-⟨g⟩ flat band) survives the conditions a REAL material imposes on it.**
Four candidate missing laws, triaged by load-bearing-ness on the *escape* L8:

| candidate missing law | what it would decide | load-bearing on the escape? |
|---|---|---|
| (a) CARRIER-DENSITY law (n for high-Tc condensation vs Mott) | does the flat-band bipolaron condensate reach high-Tc density before Mott/CDW localizes it? | **HIGH** — directly gates L8 |
| (b) DIMENSIONALITY law (2D-BKT vs 3D) | does T_BKT (2D) or T_λ (3D) set the ceiling for the bond-bipolaron? | MEDIUM — L8 already checked 2D≈3D at dilute n (×1.11), partly covered |
| (c) DISORDER / Anderson law | does the geometric escape survive disorder (flat bands are disorder-fragile)? | **HIGH** — flat bands are maximally disorder-sensitive |
| (d) interface/film exemption law | are 2D-interface/film SCs a separate ambient route (bypassing bulk #2)? | LOW — L1 already labels film/interface "separately"; not the bulk escape |

### THE single most load-bearing missing law:

## ★ CARRIER-DENSITY–vs–MOTT CEILING law (CARRIER-DENSITY-MOTT-BOUND)

> **One-line statement of what it decides:** *Whether the high-⟨g⟩ flat-band bipolaron escape (L8) can
> reach the carrier density n required for a 293K condensate (T_BKT/T_c ∝ n·D_s) BEFORE on-site Mott /
> bipolaron crystallization (CDW) localizes the pairs — i.e. is there an n-window where the geometric
> superfluid stiffness is large AND the system is still metallic-superfluid, or does the same flat band
> that gives high ⟨g⟩ force n into the Mott/Wigner-crystal regime, re-capping Tc.*

**Why it is THE load-bearing gap (over disorder (c)):**
1. **L8's escape is a DENSITY claim disguised as a geometry claim.** T_BKT ∝ D_s = 4|U|ν(1-ν)⟨g⟩ —
   it carries an explicit **ν(1-ν)** filling factor. L8 already found the *dense-bipolaron* density
   lever "fails" along the *dispersive* t**·n axis (dome peaks at n_b=½, only ×1.56), but it did NOT
   close the question for the *geometric* D_s: at what n does the high-⟨g⟩ condensate hit Mott? The
   ν(1-ν) factor *peaks at ν=½* — exactly where a flat band at E_F is most prone to Mott insulation /
   CDW (Hubbard U is HUGE on a flat band, the whole reason flat-band correlation physics exists).
   **So the escape's own stiffness formula and its own failure mode peak at the SAME filling** — this
   is an unaudited collision the law set does not yet bound.
2. **It gates L8 directly**, whereas disorder (c) gates the *robustness* of an already-condensed state
   (a second-order concern if the n-window doesn't even exist).
3. **It is the missing rung that converts L5's "not-forbidden" into a decidable in-silico gate**: L5
   says the must-break assumption is "1atm dynamic stability under strong coupling OR non-adiabatic
   Regime II with NO proven ceiling." The CARRIER-DENSITY-MOTT bound is precisely *the ceiling that
   Regime II currently lacks* — establishing it (or proving an open window) would either CAP the last
   escape or certify it.

**Next probe (the discovery / next law-hunt round):** compute, for the high-⟨g⟩ flat-band Hubbard-
Holstein/SSH model at filling ν, the boundary between (superfluid, D_s>0) and (Mott/CDW-localized) as
a function of U/W and ⟨g⟩ — i.e. find n*(⟨g⟩) where T_BKT(n) = T_Mott-onset(n), and test whether
max_n T_BKT exceeds 293K *inside the metallic-superfluid window*. If the window closes below room-T
for all chemistries → the escape is capped (a NEW closed-negative law, completes the set). If it stays
open → certifies L8 as the genuine room-T escape and names the (n, ⟨g⟩, U/W) target box.

---

## 5. DEPLETION TEST / verdict

- **Consistency:** ✅ **CONSISTENT** — no hard contradiction across all 18 pairs. The
  "(closed)×(not-forbidden)" architecture is COHERENT (quantifier split: families/mechanisms closed
  empirically, the bound-status not-forbidden, the residual escape isolated). ONE stale-edge FLAG:
  L6's bipolaron/flat-band scoreboard lines are superseded by L8's geom-stiffness overturn and should
  be annotated (LOW severity).
- **NEXUS:** ✅ narratively CONNECTED (gate → 4 ceilings → 1 escape, L7↔L8 companions), NO orphan law;
  but only 1/8 laws (L5) carries structured `reuses/provides` — recommend back-filling L1/L7/L8
  (LOW severity, structure-only).
- **Numeric:** ✅ CONSISTENT — el-ph (realistic 100-130K ⊂ math-envelope 150-200K), magnetic 130-160K,
  light-clathrate ~122K, verified 134K all monotone-consistent; **cuprate 134K sits correctly at the
  low-mid of the magnetic bound (Tc/J≈0.08); gap to 293K = 159K**.
- **NOT depleted.** The set is internally consistent but **INCOMPLETE in one load-bearing place.**

### ★ The single most-important missing law (next probe):
**CARRIER-DENSITY-MOTT-BOUND** — decides whether the high-⟨g⟩ flat-band bipolaron escape (L8) can
reach a 293K-condensate carrier density *before* Mott/CDW localization re-caps it (the ν(1-ν)·⟨g⟩
stiffness peaks at the same filling ν=½ where flat-band Mott is strongest — an unaudited collision).
This is the missing rung that turns L5's "bounded-but-not-forbidden" Regime-II escape into a decidable
in-silico gate. **Run it next** (loop-until-dry: this is the one open law-discovery probe).
