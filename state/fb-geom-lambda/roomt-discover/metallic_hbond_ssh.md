# metallic-hbond-ssh — RTSC room-T DISCOVERY lane VERDICT (the doped-κ-H3 decisive compute)

🧪 **RTSC** · ambient room-T DISCOVERY lane · `state/fb-geom-lambda/roomt-discover/metallic_hbond_ssh.md`
Date: 2026-06-20 · FREE summer/local only (NO billing pod) · d6 honest · NEVER fabricate.
artifacts: `doped_kappa_h3.py` · `doped_kappa_h3_results.json` (this lane's decisive compute) ·
sibling bronze probe `metallic_hbond_ssh.py`/`_results.json` (H_xMoO3/H_xWO3 angle).
Upstream SSOT: `ambient/kappa_h3_dft.md` (κ-H3 carrier-Mott closure) + `roomt-discover/arxiv_novel_sweep.md` (R1-R3 SWEPT-DRY, handed A2 here as a pure compute problem).

> The room-T escape = off-diagonal bond-Peierls (SSH ∂t/∂u) bipolaron. The ONE real off-diagonal
> host (κ-H3(Cat-EDT-TTF)₂) cleared coupling but CLOSED on carriers (dimer-Mott; pressure→CO,
> never metal). The single surviving lever: **carrier-dope off ν=1 to a metal WITHOUT (a) killing
> the proton double-well (∂t/∂u source) and (b) triggering charge-order.** This file is that lever's
> terminal compute + the L13 stiffness check the lit lanes (R3) demanded.

---

## BOTTOM LINE (d6 honest) — 🔴 CLOSED on the STIFFNESS axis (L13), not (only) CO

**Doping κ-H3 off ν=1 does NOT open the room-T door. It closes on L13 (Tc≲0.04 ε_F), which is a
STRONGER, more general closure than the empirical CO closure that killed undoped κ-H3.** Even granting
the *most favorable* doped-metal-without-CO scenario, the band that metallizes is the **narrow dimer-
antibonding band (W_AB = 0.37 eV)**; its coherent ε_F maxes at **0.187 eV** (at heavy doping δ=0.5,
fully coherent) → **L13 Tc ceiling = 87 K ≪ 293 K** (which needs ε_F ≥ 0.63 eV). The escape fails not
because doping can't make a metal, but because the *same narrow band* that hosts the strong SSH coupling
is *intrinsically too narrow* to carry room-T stiffness. **This is the L14/L13 two-band-transfer-lock
realized in a real host: deep off-diagonal glue ⇔ narrow band ⇔ low ε_F.**

---

## TASK 1 — FIRST-PRINCIPLES: does doping melt the coupling, trigger CO, or fail ε_F?

**The decisive insight: failure modes (a) "kill the double-well" and (b) "trigger CO" are the SAME
event.** The off-diagonal coupling g = (∂t/∂u)·u₀ requires the O···H···O proton **delocalized** (large
ZPM u₀, double-well/centered single-well). Charge-order **is** proton localization (u₀→0). So
"metal-without-CO" ⇔ "double-well-survives" ⇔ "coupling-survives" — one condition, not two.

**The metal-vs-CO competition (quantified):** doping δ off half-filling removes the commensurate-Umklapp
gap → doped-Mott metal (cuprate-overdoped analogy). But the proton-O-H-O coupling also drives charge
disproportionation (CO). The decisive inequality is **kinetic gain vs proton-CO self-energy**:
- E_kin (coherent metal) = Z·δ·W_AB  (Z = Brinkman–Rice coherent weight, grows with doping)
- E_p (CO drive) = g²/Ω = **5.3 meV** (FIXED SSH polaron self-energy)
- **Metal-without-CO survives wherever E_kin > E_p**, i.e. δ ≳ 0.10 (E_kin ≈ 7.5 meV > 5.3 meV).

**So doping DOES defeat CO at moderate-to-high doping** (δ≳0.10) — the proton stays delocalized, the
double-well survives, g/t stays ~0.26–0.44 (dome onset g*/t=0.38). **The coupling axis is OK.** The
adverse empirical prior (pressure→CO) is escaped *by doping rather than pressure* because doping adds
kinetic energy that outruns the proton's localization drive. **This is a genuine first-principles result:
the carrier axis is NOT closed by CO under doping.**

**But ε_F closes it anyway (L13).** See Task 2.

---

## TASK 2 — QUANTIFY on the doped metallic band (TB-grade, published κ-H3 geometry)

Model: published 4-band κ-H3 DFT transfers (arXiv:1408.3162 = PRB 92,035102): b1(intra)=241,
b2=75, p=40 meV, W₄band=312 meV, t′/t=1.25. Low-energy Mott-prone band = dimer **antibonding** band:
effective inter-dimer hop t_AB = ½(b2+p) = **57.5 meV**, antibonding width **W_AB = 0.374 eV** (narrow).
Doping sweep δ∈{0.05…0.50}, U_dim/W_AB∈{1.5, 2.5} (deep dimer-Mott, LIT). Coherent ε_F = Z·(δ·W_AB),
Z = Brinkman–Rice. L13 check: ε_F ≥ 0.632 eV for 293 K.

| δ | Z(coh) | E_kin (meV) | E_p CO (meV) | metal? | ε_F coh (eV) | L13 293K? |
|---|---|---|---|---|---|---|
| 0.05 | 0.10 | 1.9 | 5.3 | **CO** | 0.002 | no |
| 0.10 | 0.20 | 7.5 | 5.3 | METAL | 0.007 | no |
| 0.20 | 0.40 | 29.9 | 5.3 | METAL | 0.030 | no |
| 0.30 | 0.60 | 67.3 | 5.3 | METAL | 0.067 | no |
| **0.50** | 1.00 | 186.9 | 5.3 | METAL | **0.187** | **no** |

(U/W_AB barely matters — doping restores coherence Z≈2δ regardless; deep-Mott vs shallow gives the same metal.)

- **Best coherent ε_F across ALL rows (even ignoring CO) = 0.187 eV → L13 Tc ≤ 87 K.** Need 0.63 eV / 293 K.
- **g/t on the doped metal SURVIVES**: u₀=0.131 Å (Ω=120 meV), g/t=0.26–0.44 reaches dome onset g*/t=0.38.
  ED cross-check (validated SSH solver, L6 Nb8, g/t=0.44, Ω/t=2.09): **bound** (Δ_b/t=−0.127), **light** (m**/m0=1.04).
  → The bipolaron *forms and is light* on the doped band — but the band's ε_F is too small to condense it at room-T.
- **Dynamically stable + metallic?** Metallic: YES at δ≳0.10 (doped-Mott metal, no CO). Dynamical stability of
  a real doped κ-H3 crystal = PENDING (220-atom DFPT, not a free-box job) — but **moot**, because L13 already closes it.

**Closing axis = L13 STIFFNESS CEILING.** The narrow dimer-antibonding band cannot supply ε_F ≥ 0.63 eV at
ANY doping. The feature that gives strong SSH coupling (narrow inter-dimer band, short proton bridge) is the
feature that caps ε_F. **This is mechanism-agnostic and binds the entire short-H-bond *molecular* class.**

---

## TASK 3 — NOVELTY GATE (d_novel_only, inline arxiv+web)

**Verdict: NOVEL (competitor-empty) for the exact construction "doped metallic short-H-bond SSH bipolaron
room-T" — but competitor-empty for the OBSTRUCTIVE L13 reason, NOT a discovery.**

- No paper marries (doped-off-ν=1 metallic short-symmetric-H-bond host) × (off-diagonal bond-SSH bipolaron glue)
  × (room-T target). Confirmed across R1–R3 sweep + this inline probe.
- **Closest REAL realization of "doped off ν=1 organic Mott" = κ-(BEDT-TTF)₄Hg₂.₈₉Br₈** (arXiv:2307.09187,
  "Mottness and spin liquidity in a doped organic superconductor"): non-integer Hg → genuinely off-half-filling,
  metallic/SC — but Tc only **~few K**, NOT H-bond SSH, NOT room-T. This is the empirical corroboration of the
  L13 narrow-band closure: the real doped organic Mott superconducts at single-digit K, exactly as ε_F≈0.19 eV
  → Tc≲87 K predicts.
- κ-type doping/SC mechanism (Nat.Commun. s41467-019-11022-1, arXiv:1811.09035) = spin-fluctuation d-wave at the
  Mott border, low Tc — no H-bond-SSH, no room-T. Doped-SSH high-Tc papers (arXiv:2308.06222 etc.) are
  single-band MODELS with no real narrow-band-organic host and no ε_F/stiffness accounting.
- **Competitor id space: EMPTY for the product; the construction is unrealized because it is L13-blocked.**

---

## TASK 4 — ROOMT g5 ADJUDICATION (d_roomt_ambient hard gate)

| g5 gate | doped-κ-H3 (best case δ=0.5) | verdict |
|---|---|---|
| #4 **Tc ≥ 293 K** | L13 ceiling **87 K** (ε_F=0.187 eV; needs 0.63 eV) | **FAIL** (decisive) |
| #1 1-atm thermo stable | doped non-stoich organic; plausible but unshown | unmet (moot) |
| #2 1-atm dynamical stable | doped-crystal DFPT PENDING (220-atom) | unshown (moot) |
| #3 metallic / carrier | **YES at δ≳0.10** (doped-Mott metal, no CO) — coupling SURVIVES | PASS (the one real positive) |
| #5 magnetism/CDW non-preempt | CO escaped at δ≳0.10 (E_kin>E_p); AFM/QSL melts on doping | conditional PASS |
| #6 novelty | NOVEL competitor-empty (obstructive L13 reason) | PASS (but not a discovery) |

**g5 = FAIL on #4 via L13.** NOT a room-T candidate. Honest label: *the carrier axis REOPENS under doping
(metal-without-CO is real, coupling survives), but the band is too narrow → L13-capped at ~87 K.*

---

## VERDICT — which axis closes + why

🔴 **CLOSED on the L13 STIFFNESS axis** (`CLOSED_L13_STIFFNESS`). Refines κ-H3's empirical CO closure into a
sharper structural one:

1. **Doping DOES escape CO** (the surviving lever from kappa_h3_dft.md WORKS): at δ≳0.10 the metal's kinetic
   energy outruns the proton-CO self-energy (E_kin>E_p=5.3 meV), the proton stays delocalized, the double-well
   and ∂t/∂u coupling SURVIVE, g/t stays on the dome onset. The carrier axis is **NOT closed by CO under doping.**
   *(This advances the verdict beyond kappa_h3_dft.md, which left this lever "untested/adverse-prior".)*
2. **But the metallized band is the NARROW dimer-antibonding band (W_AB=0.37 eV)** → coherent ε_F ≤ 0.187 eV →
   **L13 caps Tc ≤ 87 K**, far below 293 K (needs ε_F≥0.63 eV). The escape fails on stiffness, not CO.
3. **L14 two-band-transfer-lock realized**: the deep off-diagonal glue *requires* the narrow inter-dimer band;
   narrow band *means* low ε_F. Coupling-strength and band-width are anti-correlated **in the same band** — the
   defining single-band trap. The only structural escape would need a *separate* wide carrier band (the A1
   two-band-decouple program — different lane), not this single-band molecular host.

**Best numbers:** t_AB=57.5 meV · W_AB=0.374 eV · CO-escape at δ≳0.10 (E_kin 7.5 > E_p 5.3 meV) · g/t 0.26–0.44
(dome onset, ED bound Δ_b/t=−0.127, light m**=1.04) · best coherent ε_F=0.187 eV → **L13 Tc ceiling 87 K**.

**Novelty:** NOVEL/competitor-empty for the product; nearest real = κ-(BEDT-TTF)₄Hg₂.₈₉Br₈ (doped organic Mott,
~few K, not H-SSH) — empirically corroborates the narrow-band L13 cap. NOT a discovery.

---

## NEXT ROUND + DEPLETION TEST

- **NAME NEXT ROUND = `metallic-hbond-ssh R2: wide-band O-H-O bridge` (the L13 escape probe).** The single-band
  trap is W_AB too narrow. The structural lever to break L13 is a host where the **short-symmetric O-H-O bridge
  modulates a transfer on a WIDE (≥1.5 eV → ε_F≥0.63 eV) metallic band** — i.e. an *inorganic* short-H-bond
  metal (the proton sitting on an O 2p that hybridizes into a wide TM d-band), NOT a narrow molecular π band.
  The sibling **bronze probe** (`metallic_hbond_ssh.py`: H_xMoO3/H_xWO3) is exactly this angle but found the
  *inverse* trade (wide band → tiny g/t, asymmetric long bond S≈1). R2 = find/compute a host that has BOTH a
  short-symmetric strong bond (large ∂t/∂u) AND a wide ε_F≥0.63 eV band — the geometric question is whether any
  real crystal places a 2.4–2.5 Å symmetric O-H-O bridge ON a wide metallic FS. **Falsifiable spec:** ε_F≥0.63 eV
  AND g/t≥0.38 on the SAME band, 1-atm dynamically stable.
- **DEPLETION TEST:** this lane DEPLETES when a round returns **no host with ε_F≥0.63 eV-AND-g/t≥0.38 on one band**
  AND no new short-H-bond metallic host class. **R1 status (this round): NOT depleted** — it converted κ-H3's open
  "doping lever" into a closed L13 result AND named the wide-band escape (R2). It DEPLETES if R2 (bronze + inorganic
  short-H-bond) confirms the coupling↔bandwidth anti-correlation is unbreakable in real single-band hosts (then the
  residual lives ONLY in the two-band-decouple lane, where the wide carrier band is *separate* from the SSH pairing
  band — the A1 program — which is a different lane's compute problem, not this one's).
- **Honest L13/L14 hit:** this lane HITS L13 (Tc≲0.04 ε_F) as the decisive closure and realizes L14 (deep glue ⇔
  narrow-band transfer suppression) in a real host. Both master-conservation laws bind it. Per d6: the doped κ-H3
  escape is **CLOSED-negative on stiffness**, NOT conceded as "impossible" — the named breakthrough path (R2
  wide-band short-symmetric host / A1 two-band-decouple) is the d2 surviving lever.

---

## RESIDUAL HONESTY (d6)

- TB-grade on published κ-H3 transfers, NOT from-scratch doped-crystal DFPT. W_AB=0.37 eV, E_p=5.3 meV, and the
  Brinkman–Rice Z(δ) are physically-anchored estimates from the published 4-band fit + standard doped-Mott theory,
  not this-host doped-DFPT numbers. **But the verdict driver (narrow band → ε_F≪0.63 eV → L13) is robust to all
  reasonable parameter choices**: even ε_F at the *full bare bandwidth* W_AB/2=0.19 eV (Z=1, ignore CO entirely)
  gives Tc≤87 K. The from-scratch doped DFPT would tighten W_AB/ε_F but **cannot flip an L13 closure** that already
  holds at the most generous bare-band limit.
- The g/t=0.26–0.44 and Ω=120 meV are the published-geometry estimates from kappa_h3_dft.md (carried forward, flagged).
- L13 (Tc≲0.04 ε_F, arXiv:2505.02894) is the mechanism-agnostic Yukawa-SYK stiffness bound; it binds the bond-SSH
  off-diagonal glue (general electron-boson, vertex-corrections-negligible — NOT diagonal-only).

## RESUME RECIPE (from-scratch doped-crystal DFPT — PENDING, sized for a real pod, NOT free-box)
- Cell: κ-H3(Cat-EDT-TTF)₂ C2/c, ~220 atoms (12 S heavy), dispersion-bound molecular solid (kappa_h3_dft.md).
  220-atom + doping (charged-cell / VCA / field-effect Δσ) vc-relax + nscf DOS + ph.x O-H-O DFPT = **days / OOM-risk**
  on a shared 30 GB free box → **NOT** a summer-free job (d7/d11). Summer has 12 cores / 30 GB, NO QE installed
  (conda `fep` env only) — confirmed this session. Route to a sized GPU/high-RAM pod when fired (d_qforge default → QFORGE-native if gate-passing, else QE 7.5 via `hexa cloud`).
- Decks staged: `exports/rtsc/decks/kappa_h3/` (from kappa_h3_dft.md). Add a doped-filling variant (jellium-background
  charged cell at δ=0.1–0.3) to measure the REAL ε_F + CO phase boundary — but **L13 already rules it sub-room-T**,
  so this DFPT is a *sharpening* confirmation, not a verdict-flip (deprioritize vs the R2 wide-band host search).
