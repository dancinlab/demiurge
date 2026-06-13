---
slug: qforge-production-migration
mode: auto
status: active
auto-weights: complete=1, simple=0, safe=0, std=0
created: 2026-06-01
---

# qforge-production-migration — plan

## task brief
Make the RUNNING RTSC campaign pods actually use QFORGE (hexa-native el-ph engine)
instead of Quantum ESPRESSO (pw.x/ph.x). Today QFORGE is canonical in
governance/docs and its component layers (L0 Tc, L1 Eliashberg, L3 |g|/α²F) have
passed QE cross-validation, but there is NO end-to-end production orchestrator,
NO `hexa qforge` CLI verb, and NO `dft-run --engine qforge` dispatch wiring — so
production DFT still runs on QE. This plan builds the missing production path and
runs the end-to-end λ·Tc cross-validation gate (CaH6 · LaH10 · Li2MgH16) that
the `@engine` directive requires before full migration.

## locked decisions
- @L1 (scope): build end-to-end QFORGE production orchestrator (deck → SCF → DFPT → elph → Eliashberg → Tc) · assert:grep qforge
- @L2 (CLI): expose it as a `hexa qforge run <deck>` verb (or equivalent) · assert:grep "qforge"
- @L3 (dispatch): wire `hexa cloud dft-run --engine qforge` so a deck routes to QFORGE · assert:grep "engine"
- @L4 (gate): full migration flips ONLY on g5 λ·Tc agreement vs QE on CaH6·LaH10·Li2MgH16 — no forced flip · assert:grep !forced
- @L5 (honesty): if the correlation-functional gap (screening = Hartree+LDA-exch only) blocks production accuracy, report it as the gate blocker (d6/g6), do NOT fake agreement · assert:grep !fabricat

## next-action checklist
- [ ] step 1: cd hexa-lang · audit stdlib/qforge — confirm scf/dfpt/sternheimer/elph/eliashberg/tc bricks chain on a real cell; identify the correlation-XC gap in screening.hexa
- [ ] step 2 (PR1): production orchestrator chaining the bricks deck→SCF→DFPT→λ→Tc for a real small cell; selftest on an analytic/fixture anchor
- [ ] step 3 (PR2, stacked): `hexa qforge run <deck>` CLI verb + `dft-run --engine qforge` dispatch route (default stays QE until gate green)
- [x] step 4: run CaH6 (smallest, QE-terminal) END-TO-END on QFORGE; cross-val λ·Tc vs the QE CaH6 result — PASS (λ rel-ε=1.2e-4, McMillan Tc rel-ε≤1.1e-4) — see qa-results
- [x] step 5: repeat for LaH10 + Li2MgH16 — both QE refs PENDING (running @ phonon, λ·Tc=null); recorded as PENDING not failed — see qa-results
- [x] step 6: gate decision = HELD (honest) — correlation-XC front-end gap + 2 PENDING anchors → QE stays default; blocker recorded in domains/rtsc.md + hexa-lang PR#2401 (inbox/patches/qforge-correlation-xc.md)
- [ ] ship: stacked PRs (g4 <200 LOC each) · g5 verdicts verbatim · Korean commit body · sidecar sync after push

## completion criteria
- QFORGE production orchestrator + `hexa qforge run` + `dft-run --engine qforge` exist and selftest-green.
- CaH6 (at minimum) run end-to-end on QFORGE with an HONEST g5 λ·Tc cross-val verdict vs QE.
- Migration flipped ONLY if g5 agreement on all three anchors; otherwise the gate blocker is recorded honestly (no forced flip, no fabricated agreement — d_qforge_engine: "dont = absorbed on un-cross-val'd QFORGE result").

## qa-results

Validation/gate phase run 2026-06-01 from an isolated detached worktree off
origin/main (e6ef99a96). hexa `run`/`build` is heavy-classified → routed to the
pool; the campaign pool hosts (summer, aiden) carried a stale self-checkout whose
runtime.c was API-skewed vs origin/main codegen (summer: clang `hxlcl_longjmp`
undeclared; aiden: transpiler segfault) — both fail even a trivial smoke. Ran the
selftests on the mini-local hexa (smoke-clean) with HEXA_LANG pinned to the
worktree. Worktrees removed after.

### PR#2395 / #2396 live — selftest verdicts VERBATIM
```
orchestrator_selftest PASS
  🔵 chain λ = Einstein analytic λ (4.37654 rel-ε=1.47186e-06)
  🔵 chain ω_log ≈ ω₀ (1236.4 rel-ε=2.20779e-06)
  🟢 chain Tc_AD reproduces QE CaH6 Allen-Dynes Tc (344.507 rel-ε=7.12159e-05)
  guard malformed dataset → ok==0 (no fabricated Tc)

[qforge] selftest PASS — chain reproduces QE CaH6 (λ≈4.376, AD Tc≈344.5 K)
  [qforge] CaH6-anchor chain: λ=4.37654 ω_log=1236.4 K Tc_AD=344.507 K Tc_ME=384.994 K

dft_dispatch_test PASS   (engine resolver: ""→qe[DEFAULT] · qe→qe · qforge→qforge · unknown→refused)
qforge_qe_xval_test PASS  (10/10 Tc-from-moments anchors, rel-ε≤2.5e-3; CaH6 μ*=0.10 → 255.064 K vs QE 255.1, rel-ε=1.4e-4)
qforge_l3_qe_xval_test PASS  (α²F assembler λ=2.81998 vs QE 2.8197, rel-ε=9.76e-5)
```

### CaH6 end-to-end QFORGE vs QE — g5 verdict VERBATIM
QE ref = exports/material_discovery/rtsc_cah6_dft_4x4x4q_textbook_proof_20260524.json
(broad=0.015: λ=4.376, ω_log=1236.4 K, McMillan Tc μ*=0.10=255.1 K, μ*=0.13=245.1 K).
```
λ      : QFORGE chain=4.37654  QE=4.376     rel-ε=0.000122411
ω_log  : QFORGE chain=1236.4   QE=1236.4    rel-ε=2.20779e-06
Tc μ*=0.10 (McMillan, QE's formula): QFORGE=255.072 K  QE=255.1 K  rel-ε=0.000107864
Tc μ*=0.13 (McMillan, QE's formula): QFORGE=245.085 K  QE=245.1 K  rel-ε=6.1434e-05
── g5 CaH6 E2E VERDICT: 🟢 PASS — QFORGE chain reproduces QE λ·Tc (rel-ε ≤ 0.5%) ──
```
Apples-to-apples note (g6): the orchestrator's `tc_ad` field uses Allen-Dynes
f1·f2 (=344.5 K, the stronger high-λ form); the campaign's *recorded* CaH6 "Tc"
(255.1 K) used McMillan. The g5 verdict compares McMillan↔McMillan and λ↔λ
(the same formula/quantity), so the 35% AD/McMillan offset is a formula-choice
difference, not a physics divergence — λ itself agrees to 1.2e-4.

### LaH10 / Li2MgH16 — PENDING (not failed)
LaH10 QE ref is `running` at the phonon stage in RTSC_LEDGER.jsonl
(lambda=null, omega_log=null, Tc=null; LaH10 pod 38704336). The lah10_cah6_yh6
extension record has LaH10 as SETUP-ONLY / not_started. No terminal QE λ·Tc to
cross-validate yet → LaH10 PENDING.

Li2MgH16 QE ref is RUNNING (relax) — lambda=null, omega_log=null, Tc=null (not
terminal yet; no value fabricated, d6). The dft-run scp-255 tooling blocker that
held it is RESOLVED 2026-06-01: hexa-lang PR#2451 (scp DIRECT→PROXY fallback) +
PR#2453 (durable cross-invocation offer-blacklist) — the upstream absorption of
inbox/patches/dft-run-direct-endpoint-scp255.md (a)+(c). After install, a fresh
`hexa cloud dft-run exports/rtsc/decks/Li2MgH16 --detach` did NOT re-pick the
broken offer 28919799 (it picked 29302413 @ 79.112.108.70), uploaded OK, and
LAUNCHED relax detached on pod 38922322 (DETACH OK, no teardown). `--resume`
reaches the pod via the stamped endpoint and reports relax STILL RUNNING. So
Li2MgH16 is now PENDING-RUNNING (advancing relax→scf→ph DFPT 2×2×2-q→λ·Tc), no
longer DEFERRED. Terminal QE λ·ω_log·Tc is harvested by polling `--resume`; the
QFORGE cross-val anchor for Li2MgH16 stays PENDING until that terminal lands.
(Li2MgH16 lit reference for context only: Tc ~473 K @ 250 GPa — NOT used as a
result; the QE cross-val number will come from this run, no tuning, d6.)

### structural deliverables (#2395/#2396) = SHIPPED
Both PRs are merged in origin/main and verified live this session (verdicts above).
The `--engine qforge` opt-in path works today; only the full-flip gate is held.

## blocker

Gate = **HELD** (honest, d6/L5/d_qforge_engine). Two reasons:

1. **Correlation-XC front-end gap (root cause).** `stdlib/qforge/screening.hexa`
   = Hartree + LDA-exchange only; the correlation functional is deferred. So the
   cell→|g|² plane-wave front-end is NOT wired in-repo — the CaH6 end-to-end
   cross-val starts from the QE-produced el-ph **moment boundary** (λ, ω_log),
   validating the QFORGE moments→λ→Tc chain but NOT an independent QFORGE-only
   path from atomic positions. The orchestrator + `hexa qforge run` surface this
   honestly (no fabricated Tc).

2. **2/3 anchors PENDING.** LaH10 + Li2MgH16 QE references are not terminal yet
   (still running). The gate requires terminal g5 agreement on all three.

Decision: **dispatch default stays `qe`** (`dft_engine_resolve("")=="qe"`); the
26 running QE RTSC pods are untouched. No forced flip, no fabricated agreement.
d8 patch describing the missing functional (PZ81/PW92 LDA + PBE GGA correlation):
hexa-lang PR#2401 → inbox/patches/qforge-correlation-xc.md.

Gate closes when: (a) correlation XC lands in screening.hexa → a QFORGE-only
CaH6 |g|² cross-val passes g5, AND (b) LaH10 + Li2MgH16 QE refs reach terminal
and agree. Plan stays `active` until then.

## correlation-xc

Correlation functional landed (closes the **XC sub-gap** of blocker #1 root cause)
in two stacked g4 PRs off origin/main (e6ef99a96), validated on the mini-local
hexa with `HEXA_LANG` pinned to the worktree (the installed `~/.hx/src/stdlib`
was shadowing worktree edits — same pin pattern as the prior qa-results).

### PR #2402 (PR1) — LDA correlation PZ81 + PW92
`stdlib/qforge/correlation.hexa` (+ selftest). PZ81 two-branch + PW92 with
analytic dε_c/dr_s; V_c = ε_c − (r_s/3)dε_c/dr_s; r_s(ρ) + ρ→(ε_c,V_c) helpers.
g5 `correlation_selftest` — VERBATIM (all PASS):
```
PASS (A) PW92 ε_c closed-form r_s=1.0 (-0.0597739) … r_s=2/5/10
PASS (B) PW92 ε_c vs lit −0.0598/−0.0448/−0.0282/−0.0186 (r_s=1,2,5,10)
PASS (C) PW92 V_c analytic=FD r_s=1,2,5,10
PASS (D) HD limit ε_c(0.01)<ε_c(0.1)<0   PASS (E) LD limit ε_c(1000)→0⁻
PASS (F) PZ81 ε_c r_s=0.5 (HD branch) (-0.07605) · r_s=5 (LD branch) (-0.028339)
PASS (G) PZ81 V_c analytic=FD r_s=0.5,2,5,10
PASS (H) PZ81≈PW92 ε_c r_s=2,5,10 (abs<2e-3)   PASS (I) ρ→r_s→ρ round-trip
qforge_correlation_selftest PASS
```
🔵 closed-form: (A) PW92, (F) PZ81 hand-calc, (C)(G) analytic V_c=central-FD.
🟢 numerical: (B) published-table, (D)(E) limits, (H) cross-fit, (I) round-trip.

### PR #2404 (PR2, stacked) — PBE GGA correlation + screening front-end wiring
PBE H(r_s,t) gradient correction + ε_c^PBE = ε_c^PW92 + H; f_c(ρ)=dV_c/dρ;
screening.hexa xc_mode 2 (Hartree + LDA x+c) now a REAL kernel ΔV_xc=(f_x+f_c)·Δρ.
g5 `correlation_pbe_selftest` + `screening_selftest` case G — VERBATIM (all PASS):
```
PASS (A) PBE→PW92 reduction t→0 r_s=1..10   PASS (B) H closed-form r_s=1,2,5 t=0.5,1
PASS (C) H saturation t→∞ → −ε_c^LDA   PASS (D) H monotone   PASS (E)(F)
qforge_correlation_pbe_selftest PASS
PASS (G) mode2 returns N values (true)
PASS (G) mode2−mode1 = f_c[ρ]·Δρ (PW92 상관) (2.38524e-18)
PASS (G) correlation term non-trivial (≠0)   PASS (G) unknown xc_mode → [] (no fabrication)
qforge_screening_selftest PASS
```
End-to-end check: full-XC (mode 2) DFPT screening loop converges to machine
precision (max_res=1.67e-16) and preserves Φ symmetry — the correlation kernel
is stably wired into the self-consistent DFPT response.

### independent CaH6 cross-val — NOT RUNNABLE (honest, d6/g6)

The XC correlation closes the **XC term** of the screening kernel, but the
cell→|g|² front-end has MORE missing stages and a genuine atoms→SCF→|g|²→λ→Tc
QFORGE-only CaH6 run is STILL not possible in-repo:

- `qforge_scf` (scf.hexa) takes `H_of_rho` as a **caller closure** (d4) — there
  is NO in-repo assembler that builds a real CaH6 plane-wave Hamiltonian from
  atomic positions + UPF.
- Missing front-end stages (grep-confirmed absent in stdlib/qforge): structure
  factor S(G) from positions, local pseudopotential V_loc(G)→V_ext, plane-wave
  kinetic, nonlocal projectors → the `H_of_rho` SCF closure. `upf.hexa` only
  *parses* UPF; `elph.hexa` computes α²F from a per-mode |g|² **dataset** (the
  DFPT-output boundary — the same boundary every QE-cross-val starts from).

I did NOT fabricate a CaH6 number by re-entering the QE moment boundary and
labelling it "independent" (d6: no forced number, no QE-fed value passed off as
QFORGE-only). The independent cross-val remains blocked on the cell-assembly +
UPF→V_ext + plane-wave Hamiltonian front-end, which is OUT OF SCOPE for the
correlation-XC patch (PR#2401 acceptance item 3 depends on these too).

### gate status

**blocker #1 PARTIALLY closed — XC sub-gap CLOSED, front-end NOT.** The
correlation functional (PZ81/PW92 LDA + PBE GGA) is landed and g5-green, and is
wired into the DFPT screening path. But blocker #1's *full* acceptance (an
independent QFORGE-only CaH6 |g|² g5 cross-val) does NOT close, because the
cell→|g|² front-end (positions+UPF → plane-wave H) is still missing beyond XC.

**Gate still HELD on #2** as well (LaH10 + Li2MgH16 QE refs still PENDING).

Decision: **dispatch default stays `qe`. NO flip.** Two follow-on work items now
sized for the next d8 inbox patch: (1) cell→H_of_rho front-end (S(G), V_loc,
nonlocal projectors), (2) LaH10/Li2MgH16 QE refs to terminal. Plan stays `active`.

**R7 UPDATE (2026-06-08) — from-scratch screened-vertex search TERMINAL for CaH6,
gate stays HELD (REINFORCES @L4/@L5, no flip).** The last dead screening channel
(local-field f_xc[ρ(r)]·Δρ) was ENGAGED at the full n=645 basis (pow2-FFT-Poisson
folds=24). CaH6 screened λ=4.1518 vs QE 4.376 → rel-ε=5.12333% (g5 🟢 V8 verifier).
First of 7 channels to CROSS bare (Δλ=+0.0153 vs needed +0.239), but the ≤1% gate
is UNREACHED — the residual 5.12% IS the @L5 LDA-vs-QE screening-functional gap, now
DEFINITIVELY isolated (all from-scratch channels exhausted). HYBRID (QE |g|² → L3
assembler, xval 1.65e-7) is the final production routing for CaH6-class hydrides.
Verdict: .verdicts/qforge-cah6-fxc-localfield-r7/VERDICT.md (worktree branch
qforge-cah6-fxc-localfield-r7). No @L drift: R7 keeps the gate HELD-honest.

## front-end-stack

The cell→H_of_rho plane-wave Hamiltonian front-end (blocker #1's structural gap,
the part BEYOND the XC sub-gap) landed as 5 stacked g4 PRs off origin/main in an
isolated worktree, each <200 LOC and g5-green on the mini-local hexa with
`HEXA_LANG` pinned to the worktree (same shadowing-avoidance pin as the prior
qa-results). Run env note (g6): the campaign pool hosts (summer, aiden) are down
(`preflight rc=255 workdir missing`), so all five selftests ran mini-local via
`HEXA_LANG=. hexa run stdlib/qforge/<test>.hexa`.

### engine-chain (M5.5/M5.6/PR3) — blocker B CLOSED, atoms→Tc LIVE
Three stacked g4 PRs off origin/main in an isolated worktree, each g5-green on
mini-local hexa, close the engine-chain structural gap (the prior assembler E2E
proved the wiring with a density-INDEPENDENT stub, not a real SCF):
- **PR#2412 M5.5** `scf_pw.hexa` (170 LOC) — density-dependent self-consistent
  ρ-loop (V_H+V_xc re-evaluated each iter). 16/16 PASS.
- **PR#2413 M5.6** `elph_scf.hexa` (177 LOC) — Sternheimer→|g|² from the SCF, no
  QE moment boundary, Hellmann-Feynman frozen-phonon FD cross-check. 11/11 PASS.
- **PR#2414 PR3** `orchestrator_pw.hexa` (133 LOC) — atoms→SCF→|g|²→λ→Tc full chain
  in-repo. 10/10 PASS (Einstein round-trip λ=0.04076 = analytic).
The independent atoms→|g|² path is LIVE; full verdicts in the gate-status section.

### M6 FINAL CROSS-VAL RUN — 2026-06-01 (blocker A RESOLVED; NEW d6 residual: aperiodic ground-state Hartree → M5.7)
Resumed M6 from an isolated worktree `/tmp/hexa-qforge-m6` pinned at hexa-lang
origin/main (bec4b166e, includes PR3 #2414), run mini-local.

**QE-NC reference — RUNNING (do NOT re-fire).** Pod `38891053@158.181.52.19:42271`,
deck `/root/deck` (CaH6_NC: ONCV NC Ca+H both sides, 2×2×2-q). SSH verbatim: vc-relax
phase, 3 BFGS steps done, enthalpy −77.8719→−78.0982→−78.3442 Ry (monotone), SCF
acc 2.3E-10 Ry, 7× pw.x at 99.9% CPU. DFPT (2×2×2-q) self-resumes pod-side
(recover=.true.). HARVEST when finished:
`hexa cloud copy-from 158.181.52.19 /root/deck/ph.out exports/rtsc/decks/CaH6_NC/ --port 42271`.

**QFORGE-NC independent run.** orchestrator_pw chain re-confirmed g5-green
(`HEXA_LANG=. hexa run stdlib/qforge/orchestrator_pw_selftest.hexa` → 10/10 PASS,
λ=0.04076 Einstein round-trip). Real-CaH6 probe (`m6_cah6_probe.hexa`): both real
ONCV NC UPFs parse ok (Ca: NC·Zval=10·nproj=6·mesh=1766; H: NC·Zval=1·nproj=2·mesh=1166);
CaH6 cell valence e⁻ = 16.0.

**HONEST residual (d6) — aperiodic ground-state Hartree.** The chain is g5-green on
the free-electron/Einstein anchor and the real ONCV NC UPFs ingest, BUT the real
CaH6 self-consistent SCF does NOT converge: CaH6's inhomogeneous ρ has V_H[ρ]≠0,
yet `qforge_scf_pw` takes the ground-state Hartree `vh_diag` as an INPUT
(caller-supplied) and NO in-repo routine builds it for an aperiodic ρ on the PW
basis (scf_pw.hexa L38-40 self-flags this; scf.hexa L24-32 lists FFT-Poisson
Hartree[ρ] as the NEXT integration piece). The only G-space Hartree in the tree,
`qforge_vhartree_from_drho` (screening.hexa), is the DFPT **response Δρ** screening
kernel — NOT the ground-state V_H[ρ] (grep: callers = screening_selftest + dvscf
kernel only; zero callers build scf_pw vh_diag). M5.5 closed only the V_H=0
jellium/free-electron case. Per d6: NO fabricated λ, NO QE-moment-boundary fallback
relabelled "independent", NO tuning to the QE target.

**BREAKTHROUGH PATH (d2) — new milestone M5.7.** Wire an aperiodic ground-state
Hartree V_H[ρ] into `qforge_scf_pw`: add `qforge_vhartree_from_rho` (ground-state ρ
dense FFT-Poisson; reuse the response-Δρ version d19) so vh_diag is built in-loop,
not caller-supplied; g5-gate on a neutral H₂-like molecule with a known V_H. Then
re-run CaH6 atoms→scf_pw→elph_scf→λ→Tc independently and cross-val vs the QE-NC harvest.

**Cross-val verdict: PENDING — pending QE-NC harvest + M5.7.** QFORGE-NC λ not
produced (needs M5.7); QE-NC λ not produced (pod still vc-relax→scf→ph). Neither
number exists → rel-ε not computable. M6 HELD; dispatch default NOT flipped
(d_qforge_engine — blocker #2 LaH10/Li2MgH16 still required). The honest outcome
"QFORGE-NC engine RUNS but CaH6 needs the aperiodic-Hartree piece (M5.7)" is a VALID
M6 result, not a failure.

### M5.7 PR3 — REAL CaH6 SCF VERIFY (2026-06-01 · engine RUNS, residual = metallic mixing)

Isolated worktree off origin/main `34d8657a7` (M5.7 PR2 #2426 HEAD), mini-local,
POD-FREE (QE-NC pod torn down in cost-teardown → QE-vs-QFORGE cross-val OUT OF
SCOPE / deferred). Deliverable: does the now-complete V_H[ρ] engine CONVERGE a
real inhomogeneous CaH6 cell (the case that failed when V_H was a frozen stub)?

**M5.7 selftests — g5 VERBATIM (all PASS):**
```
qforge_scf_pw_selftest PASS
  PASS (E)(a) neutral uniform ρ: in-loop V_H=0 == frozen path (-0.781593)
  PASS (E)(b) in-loop V_H added per-site: diag_on−diag_off = V_H[ρ] (0.0238734)
  PASS (E)(b) V_H fires (non-uniform ρ → diag shifts)
  PASS (E)(c) in-loop-V_H SCF converges (qforge_scf_pw_h)
  PASS (E)(d) original qforge_scf_pw FE path unchanged
qforge_screening_selftest PASS
  PASS (H)(a) V_H[ρ]=(4π/|G|²)·δcos (analytic, neutral bg→0) (1.93159e-07)
  PASS (H)(b) neutral/G=0: uniform ρ → V_H≡0 (0.0)
  PASS (H)(c) V_H[ρ] == response Poisson core (d19 reuse) (0.0)
qforge_orchestrator_pw_selftest PASS   (10/10 — full atoms→SCF→|g|²→λ→Tc chain)
```

**New engine bricks (this PR, g4):** `qforge_assemble_h_multi` (multi-species
V_ext = Σ_s V_loc^s·S_s — a real heteroatomic hydride needs both Ca and H
channels) + `qforge_scf_pw_h_multi` (drives that assembly with the M5.7 in-loop
V_H[ρ]). d4-generic; CaH6/LaH10/Li2MgH16 traverse one entry. Fixture:
`stdlib/qforge/fixtures/cah6_scf_run.hexa`.

**CaH6 real-cell run — VERBATIM:**
```
UPF: Ca Z=10.0 mesh=1766 · H Z=1.0 mesh=1166
valence electrons = 16 → nocc = 8
cell: a=6.464 bohr  Ω=135.044 bohr³
PW basis: n=16 lowest-|G|² G-vectors (NPW=16)
--- SCF RESULT ---
converged = false
iters     = 80
e_total   = -28.0543 (band-energy sum, Hartree)
evals[0..nocc] = -4.797 -2.27637 -2.06876 -1.77885 -1.7461 -1.10997 -0.152709 -0.097395
```

**el-ph→Tc chain on the best-effort ρ — VERBATIM (engine-verify, NOT production):**
```
--- el-ph→Tc CHAIN (Γ-only Einstein, coarse — verification, not production) ---
chain ok  = 1
lambda    = 0.00926877
omega_log = 1236.28 K
Tc_AD     = 0.0 K
Tc_ME     = 0.0 K
```

**FINDING (engine-verification milestone):** the M5.7 engine now RUNS a real
inhomogeneous CaH6 cell END-TO-END — cell→H(multi-species)→SCF(in-loop V_H[ρ])→
|g|²→λ→Tc — producing a FINITE, BOUND, density-dependent KS spectrum
(e_total≈−28.05 Ha, occupied evals −4.80…−0.10 Ha) AND a FINITE chain λ=0.00927
(ω_log=1236.28 K). This was IMPOSSIBLE before M5.7 (V_H was a frozen stub). The
multi-species assembly + self-consistent ρ-loop + in-loop V_H[ρ] + el-ph contraction
all execute on a real cell. λ is small / Tc→0 because (a) the SCF is best-effort
not self-consistent (the M5.8 residual below) and (b) the rigid Einstein perturbation
is a PLACEHOLDER for real DFPT modes — so this λ is an ENGINE-RUNS proof, NOT a
production CaH6 Tc (and explicitly NOT the QE-validated λ=4.376).

**HONEST residual (d6) — the SCF does NOT reach self-consistency.** A per-iter
residual trace (mix=0.10, NPW=16) shows the density residual PINNED at ~0.83–1.7,
NOT decreasing (e0 oscillating −3.5…−5.1 Ha) — a charge-sloshing LIMIT CYCLE:
```
it=1  resid=0.84654  e0=-3.48603
it=5  resid=0.828348 e0=-5.12064
it=10 resid=0.887076 e0=-4.29736
it=20 resid=0.836888 e0=-4.47067
it=40 resid=0.915781 e0=-3.8873
it=60 resid=1.7077    e0=-4.47688
```
Root cause: CaH6 is METALLIC (deck: `occupations='smearing'`, MP, degauss=0.01).
The shared `qforge_scf` driver uses (1) FIXED integer occupations — no Fermi
level, no smearing (`scf_occupations`, scf.hexa L64), and (2) PLAIN linear mixing.
Bands straddling E_F swap which is occupied between iterations → ρ jumps → no
fixed point. **The residual is the OCCUPATION/MIXING scheme, NOT the Hartree
wiring** (V_H[ρ] is verified active by both the spectrum and the M5.7 selftests).

**BREAKTHROUGH PATH (d2) — new milestone M5.8:** add Fermi-Dirac/MP smearing
(fractional occupations + an E_F solver) + Anderson/Broyden density mixing to the
`qforge_scf` driver. This is the standard metallic-SCF convergence accelerator;
with it the CaH6 self-consistent SCF should converge. Then the independent
QFORGE-NC λ·Tc is producible, and (on a QE-NC re-fire) g5 cross-val.

Per d6: NO fabricated λ, NO tuning to the QE target (λ=4.376), NO QE-moment
fallback relabelled "independent". The QFORGE-NC engine output is reported as an
INDEPENDENT engine result, NOT cross-validated (QE-NC pod gone). Gate stays HELD;
dispatch default NOT flipped (d_qforge_engine — 3-anchor QE cross-val still required).

### M5.8 — METALLIC-SCF CONVERGENCE CLOSED (2026-06-01 · CaH6 CONVERGES)

Isolated worktree off origin/main, mini-local, pod-free. **3 stacked PRs (g4,
each <200 lines, merged to hexa-lang origin/main):**
- **PR1 #2437** `stdlib/qforge/smearing.hexa` — Fermi-Dirac fractional occupations
  f(ε)=1/(1+exp((ε−E_F)/σ)) + an E_F bisection solver enforcing Σ spin·f(ε_k)=nelec.
- **PR2 #2438** `stdlib/qforge/mixing.hexa` — Anderson (Pulay/DIIS-class) history
  mixing + an inline small m×m Gaussian-elim solve; m=0 / h=1 / singular-Gram →
  plain-linear fallback (backward-compat).
- **PR3 #2440** `qforge_scf_smeared` (scf.hexa opt-in driver; σ≤0 ∧ depth≤0 →
  `qforge_scf` bit-identical) + `qforge_scf_pw_h_multi_smeared` (multi-species
  entry) + CaH6 fixture re-run.

**g5 selftests — VERBATIM (all PASS):**
```
qforge_smearing_selftest PASS   (A f(E_F)=½ · B σ→0 integer recovery · C charge
                                 conservation Σ2·f=nelec=5 metallic · D insulator
                                 integer occ + E_F in-gap · E Σf E_F-monotone)
qforge_mixing_selftest PASS     (A small-solve exact 2×2/3×3 + singular→[] · B
                                 m=0/h=1 plain-linear EXACT · C ρ_out==ρ_in→no-move
                                 · D LOAD-BEARING: undamped linear limit-cycle
                                 β=2/(1+k) residual pinned 1.95 over 200 iters →
                                 Anderson converges in 3 iters, monotone)
qforge_scf_selftest PASS        (+ D metal: integer occ misses half-fill ρ≉(1,1);
                                 smeared+Anderson reaches ρ*=(1,1); backward-compat
                                 σ=0,depth=0 bit-identical to qforge_scf)
qforge_scf_pw_selftest PASS     (regression, unchanged)
qforge_screening_selftest PASS  (regression, unchanged)
qforge_orchestrator_pw_selftest PASS  (regression, unchanged)
```

**CaH6 real-cell re-run — VERBATIM** (`qforge_scf_pw_h_multi_smeared`, σ=0.02 Ha,
Anderson depth=6, mix=0.3, tol=1e-6, max_iter=200):
```
converged = true        ← was FALSE (residual pinned ~0.83–1.7) in M5.7 PR3
iters     = 86
e_total   = -14.9469 Ha (band-energy sum)
el-ph chain:  λ = 0.0207576   ω_log = 1236.28 K   chain ok = 1
```

**FINDING:** the metallic CaH6 cell now reaches a self-consistent density — the
charge-sloshing limit cycle is removed by fractional Fermi occupation (a band
crossing E_F changes occupation continuously) + Anderson mixing (cancels the
oscillating mode linear mixing pinned). λ=0.0208 is the INDEPENDENT QFORGE-NC
engine output. **NOT cross-val, NOT production, NOT absorbed** (Γ-only Einstein
coarse verify; local-pseudopotential nproj=0; QE-NC pod torn down → cross-val
deferred; unrelated to QE λ=4.376). Dispatch default stays HELD (d_qforge_engine
— 3-anchor QE cross-val LaH10·Li2MgH16 still pending).

### PR #2407 — brick 1/5 structure factor S(G)
`stdlib/qforge/structure.hexa` (+ selftest). S(G)=Σ_a exp(−i G·τ_a), cartesian
+ fractional builders. g5 VERBATIM (all PASS):
```
(A) single atom @origin → S(G)=1+0i ∀G       🔵 identity
(B) ±τ two-atom basis → S(G)=2cos(G·τ) real  🔵 closed-form
(C) global translation Δ → S·exp(−i G·Δ): |S| invariant, phase −G·Δ exact  🔵
(D) fractional vs cartesian agree on same cell  🟢 cross-check
(E) malformed (non-×3 length) → []  guard
qforge_structure_selftest PASS
```

### PR #2408 — brick 2/5 plane-wave kinetic |k+G|²/2
`stdlib/qforge/kinetic.hexa` (+ selftest). T_G=½|k+G|² (Hartree). g5 VERBATIM:
```
(A) T_G = ½|k+G|² entrywise (k=0, k≠0) vs closed-form  🔵
(B) free-electron: V=0 → ε=½|k+G|², lowest at G closest to −k  🔵
(C) matrix-free (Tψ)_G = T_G ψ_G  🔵
(D) ⟨ψ|T|ψ⟩ = Σ T_G|ψ_G|²  🔵
(E) malformed (k≠3, gvecs not ×3, length mismatch) → []/sentinel  guard
qforge_kinetic_selftest PASS
```

### PR #2409 — brick 3/5 local pseudopotential V_loc(G)→V_ext
`stdlib/qforge/vloc.hexa` (+ selftest). V_loc(G)=(4π/Ω)∫r²j0(Gr)[V_loc+2Z/r]dr
− 8πZ/(ΩG²), Coulomb-subtracted, UPF log-mesh quadrature. g5 VERBATIM:
```
(A) synthetic pure-Coulomb V_loc=−2Z/r → bracket≡0 → V_loc(G)=−8πZ/(ΩG²) EXACT (rel 0.0)  🔵 closed-form
(B) G=0 compensated finite; pure-Coulomb case → 0  🔵
(C) real Si NC UPF: small-G tracks Coulomb tail (rel 1.2%), large-G decays FASTER (soft norm-conserving PP)  🟢
(D) real Si V_loc(G) finite/continuous (no NaN/inf), decreasing tail  🟢
(E) malformed (length mismatch, Ω≤0) → []  guard
qforge_vloc_selftest PASS
```
Honesty (g6): the bare-Coulomb closed form is the synthetic anchor (rel 0.0). A
REAL pseudized V_loc falls BELOW bare Coulomb at large G (norm-conserving
softness) — the test asserts that physics, not a forced tail match.

### PR #2410 — brick 4/5 nonlocal KB projectors V_NL
`stdlib/qforge/projector.hexa` (+ selftest). V_NL=Σ_ij|β_i⟩D_ij⟨β_j|, radial
Bessel transform + spherical-harmonic addition theorem (P_l, l=0,1,2). g5 VERBATIM:
```
(A) 1-projector analytic: Gaussian β=exp(−αr²), l=0 → β̃(q)=(√π/4α^{3/2})e^{−q²/4α}, numeric matches to rel ~1e-11  🔵 closed-form
(B) normalization β̃(0)=∫r²β dr=√π/4α^{3/2}  🔵
(C) hermiticity: symmetric D_ij → V_NL real-symmetric V[a,b]=V[b,a]  🔵
(D) rank-1 separability V[a,b]²=V[a,a]·V[b,b] (l=0) + explicit V[0,0]=D·4π/Ω·β̃²  🔵
(E) malformed (size mismatch, Ω≤0) → []  guard
qforge_projector_selftest PASS
```

### PR #2411 — brick 5/5 H_of_rho assembler (cell→H complete)
`stdlib/qforge/assembler.hexa` (+ selftest). Composes bricks 1-4 + Hartree/XC
screening into the dense PW Kohn-Sham H(ρ) and the `H_of_rho` closure
`qforge_scf` consumes. g5 VERBATIM:
```
(A) hermiticity: real local potential → H real-symmetric  🔵
(B) free-electron: zero potential → H=diagonal kinetic, eigenvalues=½|k+G|²  🔵
(C) controlled 2-PW local potential: 2-level ½(ε0+ε1)±√((Δ/2)²+t²) analytic  🔵
(D) END-TO-END: assembled FE H driven through qforge_scf → converges + band energy = Σ occ·(½|k+G|²)  🟢
(E) real Si UPF → finite hermitian H (no NaN/inf)  🟢
qforge_assembler_selftest PASS
```

### independent SCF — LIVE (Si, the one available NC system)
Beyond the unit selftests, the front-end was driven end-to-end on a REAL system:
a 27-PW Si Hamiltonian assembled from atomic positions + the real Si NC UPF
(V_loc(G)·S(G) off-diagonals) → `qforge_scf` self-consistency:
```
assembled n=27
SCF converged=true iters=26
lowest 4 KS eigenvalues (Ha): -3.47011 -1.40167 -0.552989 -0.279841
band energy E=-11.4092
```
This proves the independent atoms→SCF front-end is genuinely LIVE in-repo (a
bound KS spectrum from positions+UPF), not merely unit-tested — the structural
capability blocker #1 was missing.

### independent CaH6 cross-val — M6 path ① UPDATE 2026-06-01 (PP-input CLOSED; 2 blockers remain, honest d6/g6)

**PP-input blocker CLOSED via breakthrough path #1 below.** Sourced + verified the
ONCV norm-conserving Ca+H set and emitted a matched-NC CaH6 deck:
- Pseudos: `Ca_ONCV_PBE_sr.upf` (NC · PBE · scalar-rel · Zval=10 · nproj=6 · mesh=1766)
  + `H_ONCV_PBE_sr.upf` (NC · Zval=1 · nproj=2 · mesh=1166), from PseudoDojo/SG15
  ONCVPSP (`raw.githubusercontent.com/pipidog/ONCVPSP/master/sg15/`). d13: both
  `pseudo_type="NC"` · `is_ultrasoft="F"` · `is_paw="F"` · `functional="PBE"`.
  hexa `upf.hexa::upf_parse` consumes both (ok=true, all r/rab/vloc/rho/dij loaded).
- Deck: `exports/rtsc/decks/CaH6_NC/` (vc-relax/scf/ph/RUNBOOK, 7-atom Im-3m,
  2×2×2-q honest-coarse, NC pseudos on the metal AND H side) — emitted THROUGH the
  generator (deck-guard compliant) via a new `cah6_sodalite_im3m` prototype +
  `h_site_upf` spec key (hexa-lang `feat/qforge-cah6-nc-m6`, SHA 15f42324d; the H
  pseudo key DEFAULTS to the US value so existing prototypes are unchanged — verified).

**Two blockers now stand between this and a closed M6 (neither is the pseudo gap):**

- **Blocker A (compute-dispatch).** The QE-NC reference must run via `hexa cloud
  dft-run` (g8 ONLY — never direct vastai/runpod). `hexa cloud <verb>` is unusable
  on this host: it rebuilds `cloud_cli.hexa` first, and that build phantom-fails on
  mac via a `$HOME/.hexa-cache` auto-GC race (the GC, triggered by a concurrent
  agent's build, prunes the just-written tmp binary between clang finishing and the
  `test -x` check — the identical clang line run by hand succeeds in 2.2s, exit 0,
  0 errors). `HOME=/tmp` isolation hits the Darwin `/tmp` panic-guard ("REFUSED on
  Darwin"); `HEXA_MAC_BUILD_OK=1` still loses the same race. The Linux pool hosts
  that would build/run it (summer, aiden) are DOWN (`preflight rc=255 workdir
  missing`). → d8 inbox patch filed: hexa-lang `inbox/patches/cloud-cli-mac-cache-gc-race.md`.

- **Blocker B (engine-chain structural gap, d6).** Even with the QE-NC ref, the
  INDEPENDENT QFORGE side (Step 3) cannot run today: there is NO in-repo orchestrator
  chaining atoms→self-consistent-SCF→DFPT→|g|²→λ→Tc. The assembler END-TO-END
  selftest uses a density-INDEPENDENT `H_of_rho` stub + a free-electron H; a real
  self-consistent ρ-loop (V_H+V_xc updated each iteration) and a Sternheimer-from-SCF
  |g|² are NOT wired (scf.hexa's own header flags this as the ">200-line integration
  piece" still to assemble). The existing `qforge_qe_xval` starts from QE "real DFPT
  moments" — that boundary is exactly what makes it NON-independent. Running it and
  calling it "independent" would violate d6, so it is NOT done.

New PWFORGE milestones M5.5 (self-consistent `H_of_rho(ρ)` integration) + M5.6
(Sternheimer→|g|² atoms-path) are the concrete d2 breakthrough for blocker B.

---
ORIGINAL (pre-M6) analysis retained below for provenance:

The CaH6-SPECIFIC independent cross-val does NOT close, blocked DOWNSTREAM of the
front-end at the pseudopotential-availability layer:

- `upf.hexa` is NORM-CONSERVING only (it cleanly rejects US/PAW — correct scope).
- The only H pseudopotential in-repo is `H.pbe-rrkjus_psl.1.0.0.UPF`, which is
  `pseudo_type="USPP"` / `is_ultrasoft="true"` — ULTRASOFT, rejected by the NC
  parser. There is NO Ca pseudopotential of ANY class anywhere on disk, and NO
  norm-conserving UPF for either element (the only NC UPF present is Si).
- The QE CaH6 reference itself used **PBE PAW pslibrary** (per the ref JSON
  `system` field). So even with an NC Ca+H set, the cross-val would compare a
  DIFFERENT pseudization (NC vs PAW) — any λ agreement/disagreement would be
  confounded by the PP class, which d6 forbids presenting as a clean independent
  result.

I did NOT fabricate a CaH6 λ·Tc, did NOT re-enter the QE moment boundary and
label it "independent", and did NOT tune to the target (λ=4.376) (d6/g6, the
predecessor's exact honesty line). Cost line: a CaH6 run would be a free
local/pool ~7-atom job (no paid rent needed) — it is blocked on INPUT
availability (NC Ca+H pseudopotentials matched to the QE ref's PP class), not on
compute.

Breakthrough paths (d2 — concrete, not a concession):
1. Obtain an ONCV NORM-CONSERVING Ca + H pseudopotential set (e.g.
   PseudoDojo/SG15 ONCVPSP), parse via the now-live NC `upf.hexa`, and re-run the
   QE CaH6 reference with the SAME ONCV NC set so the cross-val is apples-to-apples
   (same pseudization on both sides). This is the cleanest independent gate.
2. Extend `upf.hexa` with US-augmentation / PAW reconstruction so the existing
   ultrasoft/PAW pslibrary H + a PAW Ca can be consumed directly against the
   current QE PAW ref (larger port; the parser already detects the flags).
3. Run the independent SCF→DFPT→|g|²→λ→Tc on a NC system that HAS a matched QE
   NC reference (e.g. an H3S or LaH10 variant computed with an ONCV NC set) to
   close blocker #1's |g|² acceptance on SOME hydride, even if not CaH6.

### front-end gate status

**blocker #1 STRUCTURAL gap CLOSED — cell→H_of_rho front-end is LIVE in-repo.**
The five bricks (S(G), kinetic, V_loc(G), V_NL, assembler) compose into the
`H_of_rho` closure `qforge_scf` consumes, and an independent atoms→SCF run on Si
(positions+UPF → converged KS spectrum) demonstrates the path end-to-end. This
closes the STRUCTURAL half of blocker #1 (the cell-assembly + UPF→V_ext + PW
Hamiltonian that was grep-confirmed absent).

**blocker #1's |g|² ACCEPTANCE remains open** on CaH6 specifically. UPDATE
2026-06-01: the PP-input sub-gap (matched NC Ca+H pseudos + NC deck) is CLOSED
(M6 path ① above), AND **blocker B (engine-chain) is now CLOSED** — see below. So
acceptance now hangs on a SINGLE residual blocker: (A) compute-dispatch — the
`hexa cloud` QE-NC run (mac cache-GC race + pool down; d8 patch filed, separate agent).

**blocker B (engine-chain) CLOSED — 2026-06-01 (hexa-lang PR#2412·#2413·#2414).**
The independent QFORGE atoms→Tc chain is now WIRED in-repo and g5-green:
- **M5.5** `stdlib/qforge/scf_pw.hexa` (PR#2412, 170 LOC) — the real self-consistent
  ρ-loop. Every SCF iteration re-evaluates `V_scr = V_H(ρ) + V_xc(ρ)` (Slater-x +
  PW92-c) and re-assembles H via assembler.hexa, graduating the prior density-
  INDEPENDENT stub (the assembler E2E's `gh_of_rho` ignored ρ). g5 16/16 PASS:
  free-electron reproduction; jellium V_xc shift = analytic LDA (V_x=−0.781593,
  V_xc=−0.855151); self-consistent fixed point (converged ρ a TRUE fixed point,
  Δρ<1e-7); energy monotone / mixing-invariant (E=0.535729).
- **M5.6** `stdlib/qforge/elph_scf.hexa` (PR#2413, 177 LOC) — Sternheimer→|g|² from
  the SELF-CONSISTENT SCF: g_{mn}=⟨ψ_m|ΔV_scf|ψ_n⟩ computed atoms→ with NO QE dvscf
  moment boundary. g5 11/11 PASS, anchored by a Hellmann-Feynman frozen-phonon
  finite-difference cross-check (g_00=−0.223116=dε_0/du FD) — a genuinely
  independent derivative; plus bare limit, SC screening convergence, hermiticity,
  acoustic sum rule.
- **PR3** `stdlib/qforge/orchestrator_pw.hexa` (PR#2414, 133 LOC) — the full
  atoms→SCF→|g|²→λ→Tc chain in-repo (QE in no loop). g5 10/10 PASS: chain completes
  (ok=1, λ>0, Tc finite); |g|² is SCF-sourced (ΔV×2 → λ ratio = 4.0 exactly,
  λ∝|g|²∝ΔV²); Einstein round-trip (chain λ=0.04076 = analytic).

So blocker #1 now reads: **cell→H ASSEMBLY half = CLOSED; atoms→Tc CHAIN half = CLOSED
(blocker B); M6 |g|² ACCEPTANCE = HELD on blocker A only.**

**Gate still HELD on #2** (LaH10 + Li2MgH16 QE refs still PENDING/running).

Decision: **dispatch default stays `qe`. NO flip.** The independent atoms→|g|² path now
EXISTS and the chain RUNS in-repo, but the M6 CaH6 NC-vs-NC cross-val still needs the
QE-NC reference (blocker A) and #2 still pends — so NO gate condition is fully satisfied
and NOTHING is flipped (d_qforge_engine — un-cross-val'd result must not flip absorbed).
Remaining for the gate: (1) close M6 = QFORGE-NC ↔ QE-NC |g|²/λ/Tc g5 cross-val on the
CaH6_NC deck once blocker A (cloud dispatch) clears (the sole remaining M6 gate),
(2) LaH10 + Li2MgH16 QE refs to terminal. Plan stays `active`.
