# 🧱 SUPERLATTICE CELL-DESIGN — commensurate stacking protocol for role-separation hydride candidates

**alias**: "초격자 셀-설계 protocol" · "역할분리 stacking 규칙" · "naive on-top 금지"
**date**: 2026-05-27 KST · **domain**: RTSC · **stage**: PROTOCOL (Tier-3 design doc — pre-dispatch cell construction rules)
**governance**: d1 (non-wet-lab → completed-form) · d6 (first-principles, NOT ML · Tc 강제 금지) · d11 (pre-rent feasibility-size) · d13 (basis/ECP coverage check) · d16 (deck syntax dry-run FREE on pool) · d17 (1-validation cell before scale)
**sibling**: `RTSC/protocols/VALIDATION_FIRST.md` (4-gate dispatch mandate — 본 문서는 gate 4 stability_pre_check 의 *셀-구성* 선행 단계) · `RTSC/protocols/CANDIDATE_SCORING.md` · `RTSC/walls/N5_wall_redefinition.md`

> **honesty 경계**: 본 문서는 *design protocol* — **DFT 는 아직 안 했다**. 다음 round 의 dispatch 준비물이다. 역할분리 가설("딱딱한 stabilizer 층이 H soft-mode 를 클램프 + 강결합 H층 제공") 은 **미반증** (아직 살아있음) — 다만 첫 검증셀 `mgb2_mgh2` 가 **나빴음** (셀 설계 결함, 가설 결함 아님) 을 정직히 분리한다. 아래 cell-design table 의 모든 Tc·λ·ω_log 추정은 *입력 추정*이며 verify-grade 가 아니다 (d6). compute 비용 $0 (doc only).

---

## 0. one-paragraph thesis

N5 wall (`N5_wall_redefinition.md`) 의 진단은 — binary H₃X 에서 `stable AND strong-λ AND high-ω_log` 동시 달성이 불가능하다 (λ 큰 후보는 imaginary mode, stable 후보는 ω_log ≤ 1350K 천장). **역할분리 가설**은 이 trade-off 를 *공간적으로* 분리한다: 한 층(stabilizer)이 dynamical stability 와 stiff lattice(높은 ω_log frame)를 담당하고, 다른 층(H-rich)이 강한 electron-phonon λ 를 담당한다. 단, stabilizer 는 *ω_log 를 깎지 않으면서* H 층의 soft mode 를 클램프해야 한다 (그렇지 않으면 N5 의 ω_log bottleneck 을 그대로 상속). 첫 검증셀 `mgb2_mgh2` 가 🔴 (Γ −1373 cm⁻¹ × 2 · −1362) 로 죽은 것은 가설의 반증이 아니라 **셀 구성의 naive 함** 때문이다 — 본 protocol 이 그 naive 함을 5 단계로 제거한다.

---

## 1. failure recap — 왜 `mgb2_mgh2` 가 죽었나

| 항목 | mgb2_mgh2 (실패 검증셀) |
|---|---|
| 셀 구성 | MgB₂ hex (ibrav=4) 의 c-축 2배로 늘려 MgH₂ 층 stack · H 를 **on-top Mg** 위치에 naive placement |
| Γ-only phonon | **−1373 cm⁻¹ × 2 · −1362 cm⁻¹** (hard imag <−50, clean closed-negative) — `mgb2h(−1373×2)` 로 labeh8 entry 가 참조하는 precedent |
| 진단 | (a) on-top Mg 위치는 **비현실적** — H 가 Mg 양이온 바로 위 (전자밀도 최소·반발) 에 놓여 거대 imaginary · (b) MgB₂ 와 MgH₂ in-plane lattice 의 **commensurability 미검토** (strain → soft mode) · (c) c-축 2배 = arbitrary registry, LCM 주기성 무시 |
| verdict | 🔴 가설 반증 **아님**. 셀이 나빴음. |

**교훈** — superlattice 후보는 binary 처럼 "prototype 잡고 vc-relax 발사" 로 만들 수 없다. *두 sub-lattice 의 commensurability 와 interstitial chemistry* 가 셀 품질을 지배한다. 이것이 `VALIDATION_FIRST.md` gate 4 (stability_pre_check) 의 **앞단** 으로 본 protocol 이 필요한 이유다 — gate 4 는 "vc-relax → Γ-phonon → reject" 인데, *입력 셀이 naive 하면 gate 4 는 매번 🔴 만 찍는다* (mgb2_mgh2 가 정확히 그 경우).

---

## 2. 5-step commensurate stacking protocol

### step 1 — sub-layer 독립 안정화 (per-layer relax)

각 층(stabilizer + H-rich)을 **단독** 으로 DFT-tight relax → in-plane lattice parameter 추출.

```
for each sublayer L in {stabilizer, H_rich}:
    bulk vc-relax L (BFGS, 8³ k, ecutwfc≥80 Ry, conv_thr 1e-8)
    extract in-plane (a_L, b_L) at equilibrium  # 2D-projected lattice
    record bulk Γ-phonon min freq  # sublayer 자체가 stable 한지 sanity
```

- **목적**: 각 층의 *natural* in-plane lattice 를 알아야 step 2 의 mismatch 를 계산할 수 있다. mgb2_mgh2 는 이 단계를 건너뛰고 MgB₂ a 만 채택 → MgH₂ 가 strain.
- **gate**: sublayer 가 단독으로도 hard-imag → 그 sublayer 는 stabilizer/H-rich 후보로 부적격 (escape 우선).

### step 2 — 2D commensurate lattice-match

두 sublayer 의 in-plane lattice 를 매칭 → **strain ε_lattice 필터**.

```
ε_lattice = |a_stab − a_Hrich| / min(a_stab, a_Hrich)
filter:  ε_lattice < 2%   → PASS (commensurate, low strain)
         2% ≤ ε < 5%      → AMBER (supercell matching 시도 — m×a_stab ≈ n×a_Hrich)
         ε ≥ 5%           → REJECT (strain → forced soft mode, mgb2_mgh2 류 죽음)
```

- supercell matching: 작은 정수 (m,n) 로 `m·a_stab ≈ n·a_Hrich` 인 commensurate supercell 을 찾는다 (단 셀 크기 ↑ → d11 feasibility 재점검).
- **근거**: lattice mismatch 가 곧 in-plane strain 이고, strain 이 acoustic/optical soft mode 의 1차 원인. ε<2% 가 commensurate superlattice 의 통상 임계.

### step 3 — interstitial H placement (on-top Mg 금지)

mgb2_mgh2 의 핵심 실패. H 를 양이온 on-top 에 놓지 **않는다**. 다음 세 휴리스틱을 우선순위로 적용:

- **(a) electrostatic potential 최소점** — stabilizer 층의 Hartree+ion potential map 에서 H 를 **최소점(전자가 모이는 interstitial void)** 에 배치. on-top Mg(potential 극대·반발) 의 정반대.
- **(b) bond-length 휴리스틱** — H–H > 0.8 Å (H₂ molecular bond 0.74 Å 보다 길게 — atomic/metallic H 영역, 분자화 회피) · H–metal ~1.5–2.0 Å (정상 metal-hydride bond) · H–H 가 ~0.74 Å 로 떨어지면 H₂ 분자 escape → λ 붕괴.
- **(c) 기존 안정 hydride motif 차용** — 검증된 안정 hydride 층의 H sublattice 를 그대로 이식. e.g. CaH₆ clathrate H₂₄-cage · H₃S 의 Im-3m H octahedral void · MgH₂ rutile H 위치. naive on-top 대신 *measured-stable hydride 의 H registry* 를 import.

```
placement_priority: (c) known-stable motif  >  (a) electrostatic minimum  >  (b) bond-length heuristic-only
# (c) 가 가장 안전 — 이미 stable 이 입증된 H sublattice
```

### step 4 — stacking commensurability (c-axis registry)

c-축 주기와 층간 registry 를 arbitrary 2배(mgb2_mgh2) 가 아니라 **LCM 으로** 결정.

```
c_super = LCM(c_period_stab, c_period_Hrich)   # 두 층의 자연 c-주기의 최소공배수
registry: AA (eclipsed) vs AB (staggered) 둘 다 만들어 비교
  → 각 registry 의 static total energy E(AA) vs E(AB) → 더 깊은 것 채택
  → tie-break: 더 낮은 Γ-phonon min freq (clamp 가 더 강한 쪽)
```

- mgb2_mgh2 의 "c-축 2배" 는 두 층의 자연 주기를 무시한 arbitrary 선택 → registry mismatch → optical soft mode.
- AA vs AB 비교는 cheap (static SCF 2회) 이고 stacking 의 가장 큰 자유도.

### step 5 — stability pre-check gate (full el-ph 전 차단)

`VALIDATION_FIRST.md` gate 4 를 superlattice 에 그대로 적용 — full electron-phonon **전에** 즉시 reject.

```
1. vc-relax (cell_dofree='all' 또는 'c'만 고정 시 'shape', BFGS)
2. Γ-only phonon (ph.x ldisp=.true. nq=1)
3. inspect dyn1 lowest mode:
   - hard imag (<−50 cm⁻¹) → 🔴 REJECT 즉시 (full el-ph 미발사 · ph.x 75-90% 절약)
   - mild Γ-soft (−50 ~ 0)  → 🟡 AMBER (step 3 placement 재시도 / displaced-seed escape — h3as 모형)
   - all real               → 🟢 PROCEED full-grid el-ph
```

- **escape 옵션** (AMBER 시): h3as R3m precedent (rtsc.log 2026-05-26 — soft-mode eigenvector 추출 → ε 변위 displaced seed → nosym=.true. vc-relax → −0.16 eV 더 깊은 폴리모프 + 14/14q stable + Tc 56K). superlattice 도 AMBER 면 Γ soft-mode 를 condensation 시킨 저대칭 variant 로 escape 시도 가능.
- **ω_log 보존 체크** (역할분리 가설의 핵심 정직 게이트): step 5 PROCEED 후 harvest 에서 `ω_log(superlattice) ≥ ω_log(stabilizer bulk)` 인지 확인. stabilizer 가 ω_log 를 *깎으면서* 클램프하면 N5 ω_log bottleneck 을 상속 — 가설의 진짜 시험은 "stable AND ω_log 유지" 동시 달성이다.

---

## 3. 5-후보 cell-design table (protocol 적용)

아래는 5 deferred 후보에 §2 protocol 을 *적용한 설계안* — **DFT 아직 안 함**. ε_lattice·예상 위험은 문헌 lattice 추정 기반 *입력 추정* (d6 honest — verify-grade 아님, dispatch 후 step 1-2 가 실측치로 갱신).

| 후보 | stabilizer 층 | H-rich 층 | lattice-match ε (추정) | H placement (step 3 전략) | 예상 위험 |
|---|---|---|---|---|---|
| **lah_bn** | BN (h-BN, a≈2.50 Å · stiff sp² frame · 매우 높은 ω_log) | LaH_x (La-hydride, a≈ depends on phase) | ⚠ ε 큼 (~10-15%, BN a 2.50 vs La-H ~4 Å) → step 2 supercell matching 필수 (3×a_BN ≈ 2×a_LaH 류) | (c) LaH₁₀-motif 차용 — La clathrate H-cage 의 검증된 registry; BN void interstitial 회피 | 큰 ε → supercell 크기 ↑ (d11 atoms 재점검) · BN π-electron 이 La-H DOS 와 decouple 시 λ 기여 0 위험 |
| **cah6_b** | B layer (보론 sheet/network · light · stiff B-B) | CaH₆ (clathrate H₂₄-cage · measured 215K @ 가압) | 🟢 ε 작을 가능성 (Ca-B-H 격자 근접 · B a~2.9 Å vs CaH₆ a~3.6 Å → ε~20% raw, supercell 시 개선) | (c) CaH₆ clathrate H-cage motif 직접 import (measured-stable) — 가장 안전 | CaH₆ 자체가 가압 필요(ambient 미확정) → step 1 에서 P>0 GPa 로 sublayer relax 필요 가능 · B layer 가 clathrate cage 를 깨뜨릴 위험 |
| **h3as_h3o** | h3as (R3m 폴리모프 — 검증된 stable 14/14q · Tc 56K) | h3o (강λ harmonic 2.479 BUT SSCHA collapse → anharmonic) | 🟡 ε 중간 (둘 다 H₃X · As vs O 양이온 크기 차 → a 차이) | (c) h3as R3m 의 H registry + h3o H₃O motif 혼합 — 같은 H₃X family 라 motif 호환성 ↑ | h3o 의 anharmonic soft mode 가 superlattice 에 상속 → AMBER 가능성 高 · h3as 가 h3o 의 −682cm⁻¹ Γ-soft 를 클램프할 만큼 stiff 한지 미지수 (이 후보의 *핵심 가설* — h3as=clamp, h3o=λ source) |
| **mgb2_h3s** | MgB₂ (stiff B sp² · ω_log 높음 · BETE-NET trustworthy frontier) | H₃S (measured 203K @ 가압 · 강λ benchmark) | ⚠ ε 큼 (MgB₂ a 3.09 Å vs H₃S Im-3m a~3.0 Å @ 가압 → raw ε 작아보이나 H₃S 가압 격자) → step 2 정밀 매칭 | (c) H₃S Im-3m H-octahedral-void motif import (measured-stable @ 가압) | mgb2_mgh2 의 자매 — **MgB₂ 를 stabilizer 로 재시도** (이번엔 H-rich 를 naive MgH₂ on-top 이 아니라 H₃S motif 로). H₃S 가압 요구 → ambient 에선 H₃S 층 자체 불안정 위험 · MgB₂-H₃S 계면 chemistry 미검증 |
| **h3as_h3o_h3s** | h3as (R3m stable clamp) | h3o + h3s (이중 H-rich · 강λ stack) | 🟡 삼중층 — 각 계면 ε 누적 (step 2 를 2 계면에 적용) | (c) 각 H₃X 의 motif 를 층별 import · 계면마다 step 3 독립 적용 | **3-layer = 복잡도·atoms 최대** (d11 feasibility 위험 — atoms/cell 클 가능성 → GPU pod 필요) · 계면 2개 = soft mode 발생 지점 2배 · ω_log 보존이 가장 어려움 (이중 H 층) · 첫 검증 후보로는 부적합 — h3as_h3o (2-layer) PROCEED 후에만 시도 권장 |

**dispatch 우선순위 권고** (info_gain × feasibility, `ACTIVE_ACQUISITION.md` 정신):
1. **cah6_b** 또는 **h3as_h3o** — measured-stable motif (CaH₆ / h3as-R3m) 를 import 하므로 step 3 위험 최저. h3as_h3o 는 가설("h3as clamps h3o")의 가장 직접적 시험.
2. **mgb2_h3s** — mgb2_mgh2 실패의 정정 재시도 (같은 stabilizer, 더 나은 H-rich motif). BETE-NET trustworthy 영역.
3. **lah_bn** — ε 큼 → supercell 필요, feasibility 재점검 후.
4. **h3as_h3o_h3s** — 3-layer, h3as_h3o 가 🟢 PROCEED 입증된 *후에만* (복잡도·cost 최대).

---

## 4. dispatch record — `superlattice_design` block (mandatory)

후보를 dispatch 할 때 export record (`exports/material_discovery/rtsc_<cand>_dispatch_live_<date>.json`) 에 본 블록 + `VALIDATION_FIRST.md` 의 `validation_log` 블록을 함께 박는다.

```json
{
  "superlattice_design": {
    "candidate": "h3as_h3o",
    "step1_sublayer_relax": {
      "stabilizer": {"phase": "h3as_R3m", "a_inplane_ang": null, "bulk_gamma_min_cm-1": null},
      "h_rich":     {"phase": "h3o",      "a_inplane_ang": null, "bulk_gamma_min_cm-1": null}
    },
    "step2_lattice_match": {"epsilon_lattice_pct": null, "verdict": "PASS|AMBER|REJECT", "supercell_mn": null},
    "step3_h_placement": {"strategy": "(c) known-stable motif", "motif_source": "h3as_R3m + H3O", "min_HH_ang": null, "min_Hmetal_ang": null},
    "step4_stacking": {"c_super_ang": null, "registry_chosen": "AA|AB", "dE_AA_AB_eV": null},
    "step5_stability_gate": {"vcrelax_done": false, "gamma_min_cm-1": null, "verdict": "RED|AMBER|GREEN", "omega_log_preserved_vs_stabilizer": null}
  }
}
```

→ harvest agent 가 본 블록을 parse · post-mortem 시 어느 step 에서 셀이 죽었는지 1-grep (mgb2_mgh2 는 step3 H-placement 결함이 step5 RED 로 발현).

---

## 5. cross-ref

- `RTSC/protocols/VALIDATION_FIRST.md` — 4-gate dispatch mandate (본 protocol = gate 4 의 *셀-구성* 선행 단계)
- `RTSC/protocols/CANDIDATE_SCORING.md` — step 5 PROCEED 후보 ranking
- `RTSC/protocols/ACTIVE_ACQUISITION.md` — 5-후보 dispatch 우선순위 triage
- `RTSC/walls/N5_wall_redefinition.md` — ω_log bottleneck (역할분리가 깨려는 벽 · step 5 ω_log 보존 게이트의 근거)
- `domains/rtsc.log.md` — mgb2_mgh2 실패 (Γ −1373, mgb2h precedent) · h3as R3m escape 방법론 · 본 protocol 의 motivating evidence

---

## 6. status

- **status**: PROTOCOL ACTIVE — 5 deferred superlattice 후보 (lah_bn · cah6_b · h3as_h3o · mgb2_h3s · h3as_h3o_h3s) dispatch 전 §2 5-step 적용 mandatory · blind-dispatch 금지 (mgb2_mgh2 precedent).
- **honesty 경계 (재명시)**: 본 문서 = design protocol, **DFT 미실행**. 역할분리 가설 **미반증** (mgb2_mgh2 는 셀 결함, 가설 결함 아님). table 의 ε·Tc·위험 = *입력 추정* (verify-grade 아님). compute $0. R4 absorbed=false 영구 (d5/d6).
- **next**: dispatch 우선순위 1순위 (cah6_b 또는 h3as_h3o) 에 step 1 (sublayer relax) 부터 — pool free, d7 small-cell 우선 / 3-layer 는 feasibility 재점검 후.
