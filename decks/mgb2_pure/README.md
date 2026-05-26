# MgB₂ pure (P6/mmm) — non-hydride RTSC frontier Pilot #2

> **status**: **SPEC ONLY · DISPATCH DEFERRED to next round**
> **kind**: non-hydride RTSC family pilot deck (ambient 39K anchor · BETE-NET training-set coverage)
> **date**: 2026-05-27 KST · **domain**: RTSC · **governance**: d6 · d7 · d11 · d13 · d14 · d15 · d16 · d17 · g3 · g63 · R4

---

## 0. Why pure MgB₂ (motivation 1-paragraph)

MgB₂ (Akimitsu 2001 측정 Tc = 39 K · σ + π double-gap BCS) 는 historically *intermediate-Tc surprise* 로 hydride 시대 이전의 가장 정직한 ambient phonon-SC anchor. 2-atom primitive (P6/mmm AlB₂ prototype) · 60 Ry ecutwfc · 12³ k 로 ubu-1 free 에서 **<6.5h wall** 에 완주 가능. demiurge V3 numerical recompute ledger 의 hydride-편향(10/10) + ambient(0 GPa) 안 든 anchor 부재를 *동시 해소* — h3cl(140K)/h3o(191K) hydride ladder 의 *ambient counterpoint* (ω_log~460K @ 0 GPa) 로 cross-tool consistency baseline.

## 1. Cell (P6/mmm, AlB₂ prototype)

- space group #191 P6/mmm (hexagonal)
- 3 atoms / primitive (= conventional cell · 1 Mg + 2 B)
- Wyckoff: Mg at 1a (0,0,0) · B at 2d (1/3, 2/3, 1/2) + (2/3, 1/3, 1/2)
- a_lit = 3.086 Å = 5.832 Bohr · c_lit = 3.524 Å · c/a = 1.142 (Akimitsu 2001 measured @ RT)
- VEC = 2(Mg) + 2×3(B) = 8

## 2. Pseudopotentials (d13 check)

| element | UPF | source | staged? |
|---|---|---|---|
| Mg | Mg.pbe-spnl-rrkjus_psl.1.0.0.UPF | PSlibrary 1.0.0 PBE rrkjus | **likely on ubu-1** (사용된 적 있음 — mg2irh6 campaign) |
| B | B.pbe-n-rrkjus_psl.1.0.0.UPF | PSlibrary 1.0.0 PBE rrkjus | **TBD before dispatch** — verify with `ls ~/etc/pseudos/B*.UPF` |

→ **d13 gate**: dispatch 직전 확인 + 부재 시 PSL 1.0.0 PBE rrkjus 다운로드.

## 3. Flow

```
(0) d13 gate: pseudopotential check + stage to ubu-1:~/rtsc_mgb2_pure/pseudo/
(1) vc-relax (relax.in) — settle a, c (cell_dofree='all') under P6/mmm
(2) edit scf.in with relaxed celldm, then SCF (scf.in) — 12³ k Monkhorst-Pack
(3) ph.x (ph.in) electron_phonon='simple' 6³ q — IBZ ~16 q-points (P6/mmm symmetry)
(4) harvest: σ-plateau + per-q λ + ω_log + Allen-Dynes Tc
(5) verify: hexa verify --expr allen_dynes_tc <λ> <ω_log> 0.10 --compute
            expected: Tc ≈ 39.0 ± 5 K → 🟢 ambient anchor lock
```

## 4. d7 sizing (pre-rent feasibility)

- 3-atom primitive · 60 Ry ecutwfc · 12³ k · 6³ q (IBZ ~16 q-points)
- ubu-1 -np 6 estimate: SCF ~30 min · ph.x el-ph ~16 q × ~20 min ≈ 5h · **total ~5.5h**
- **pool free OK (d7 small-cell)** — paid rent 불필요 (cheapest pilot in cycle)
- d11 pre-feasibility ✓

## 5. d16 dry-run plan

dispatch 직전 ubu-1 free 에서 1-iter SCF dry-run (`electron_maxstep=1`) → directive/basis syntax 검증 → 정상 시 full SCF 진행. MgB₂ 는 well-known cell → 의외 syntax 함정 적음.

## 6. Falsifier (pre-register)

> **MgB₂ @ ambient, vc-relax → SCF → ph.x el-ph 6³ q full chain 의 σ-plateau Allen-Dynes Tc(μ\*=0.10) 가 39.0 ± 5 K 범위 내면 🟢 ambient MgB₂ anchor lock; 범위 밖이면 pseudopotential / Coulomb pseudopotential μ\* / σ-broadening convergence 검토. dynamically unstable (q 의 min_freq < −50 cm⁻¹) 면 🔴 — P6/mmm AlB₂ prototype DFT 재현 실패 (literature 와 충돌 = pseudopotential 또는 ecutwfc 의심)**.

threshold:
- Tc lock window: 34 K ≤ Tc_AD(μ\*=0.10) ≤ 44 K
- dynamical stability: all q min_freq > −50 cm⁻¹ AND hard-imag count ≤ 1/q
- σ-plateau: |Tc(σ=0.025) − Tc(σ=0.030)| ≤ 1 K

note: MgB₂ 의 σ+π double-gap 은 *anisotropic Eliashberg* 풀이가 필요하나, 본 pilot 의 isotropic Allen-Dynes 도 ω_log ≈ 460-500 K · λ ≈ 0.7-0.9 으로 Tc 39K 근방 reproduce 가능 (literature 검증). isotropic 한계 caveat 는 record 의 honest_scope 에 명기.

## 7. Cross-reference

- `domains/RTSC/research/non_hydride_candidates_brainstorm_20260527.md` — pilot selection rationale
- `domains/RTSC/falsifiers/F-N6.md` — same-cycle N6 falsifier ledger (different scope — hydride ternary)
- `domains/RTSC/verify/V3_numerical_recompute.md` — land destination of Tc_AD lock
- `decks/nb3al/` — sister non-hydride pilot #1
- `decks/mg2irh6/`, `decks/li2cuh6/` — same-style hydride deck templates

## 8. Honest scope

- isotropic Allen-Dynes 는 MgB₂ 의 σ+π double-gap 을 *single 평균* 으로 환원 — Tc 39K 에 근접해도 *physical-correct* 아님. anisotropic Eliashberg / EPW 필요 시 별 cohort.
- BETE-NET training-set 포함 → ML cross-tool sanity check 가능 (이건 별 step — 본 deck 은 DFT only).
- R4 absorbed=false 영구 (simulation tier, no measured oracle PASS — 측정 Tc=39K 는 literature anchor 이지 demiurge 의 self-measurement 아님).
