# SENOLYX 선택성 발견 — 종결식 (FINAL, 4-lens converged) · 2026-06-19

**Question closed:** can a selective senolytic with a usable therapeutic window be found, what is
the selectivity ceiling, and what is the breakthrough route? (the senolytics analog of the RTSC
material-discovery closing formula — affinity-axis depleted at the FF ceiling, pivoted to LAW hunt.)

## THE CLOSING FORMULA — selectivity is a DIFFERENTIAL-DEPENDENCY quantity, ceiling-bound, AND-gate-escapable

Three coupled relations (scap-law · window-ceiling · selectivity-escape, all corpus-confirmed):

  ┌ (1) SELECTIVITY LAW  — selectivity is ORTHOGONAL TO AFFINITY
  │     kill occupancy  x* = (B − A)/(f·B)   [A=activator BH3 stress, B=anti-apoptotic buffer,
  │                                           f=fraction of B on the DRUGGED protein, x=occupancy]
  │     selectivity exists ⟺ Δx* = (B_q−A_q)/(f_q·B_q) − (B_s−A_s)/(f_s·B_s) > 0
  │     dominant lever = f_s ≫ f_q.  ΔG_bind (affinity) is ABSENT from Δx*  ⇒ ABFE wall explained:
  │     selectivity is a differential-dependency quantity, not a binding-affinity quantity.
  │
  ├ (2) CEILING  — single-target monotherapy is theorem-bounded
  │     f_clear(T) ≤ p_dep(T) · F_b(D_tox)            [p_dep = senescent fraction depending on SCAP T]
  │     window closes (wall) when  EC50_healthy(T) ≤ EC50_sen,tail(T)   [navitoclax ↔ platelet BCL-xL]
  │     THEOREM (SenePy: "no gene in every signature" ⇒ p_dep<1 ⇒ f_clear(single-agent)<1) — binds
  │       any single-SCAP agent and any dose-escalation (refractory other-SCAP fraction invariant in TW).
  │
  └ (3) ESCAPE  — multiplicative AND-gate on ORTHOGONAL axes (the only mathematical escape)
        S_total = ∏ S_i   (independent markers)  — escapes the additive single-target cap
        valid ONLY if (a) axes orthogonal/independent (ρ→0)  AND  (b) ~zero systemic leak
          ρ=0.6 collapses 25×→9.5× ; 10% leak drags 80×→57× (Nav-Gal measured 35× ⇒ ~31% leak)
        toxicity must ALSO be orthogonal (shared-tox combo: net window +7.5%→+5.3%, never opens)
        + PAN-SENESCENT axis (GLS1) escapes the DIFFERENT (heterogeneity) wall; PROTAC decouples dose↔tox.

## THE DISCOVERY RECIPE (actionable payoff — what to build, what to STOP doing)
STOP optimizing absolute binding affinity (ABFE/RBFE — the depleted, mechanistically-wrong axis).
DESIGN OBJECTIVE = maximize the DIFFERENTIAL dependency f_s/f_q, screened by **selective-peptide BH3
profiling Δ (HRK/NOXA), not by Kd**. Then escape both walls at once:
  • build a MULTIPLICATIVE AND-gate on ORTHOGONAL axes — metabolic(GLS1) × surface(uPAR) × lysosomal(SA-β-gal)
  • on a PAN-SENESCENT backbone (covers the heterogeneity ceiling)
  • with EVENT-DRIVEN (PROTAC/glue) pharmacology to decouple dose from on-target healthy toxicity.
The unexplored NOVEL frontier (d_novel_only): an orthogonal AND-gate on a pan-senescent axis — no
primary paper yet quantifies a 2-marker senescence selectivity factor.

## VERDICT (honest, d6)
- The AFFINITY axis is CLOSED twice over: empirically (FF ceiling, R12 RBFE close-negative) AND
  mechanistically (selectivity is orthogonal to ΔG_bind — affinity is absent from Δx*). Our own R13
  ABFE proves it: BCLXL −29.28 (huge affinity) is the WORST selectivity target (navitoclax lesson).
- SINGLE-TARGET monotherapy is THEOREM-ceiling-bound (heterogeneity: p_dep<1). Not escapable by dose.
- An ESCAPE EXISTS (multiplicative AND-gate on orthogonal axes + pan-senescent backbone + PROTAC
  dose-decoupling) but is CONDITIONAL (independence + leak + toxicity-orthogonality) and, to date,
  CLINICALLY UNPROVEN — every clinical readout is a Ph2 miss (UBX0101, UBX1325 ASPIRE) or feasibility
  (D+Q, fisetin); there is NO approved senolytic. Room-window via single-target is CLOSED; a usable
  window remains OPEN only via the conditional orthogonal-AND-gate route.

## Provenance (4-lens fleet, all g5 PASS, 2026-06-19)
scap-law 🔵 (Δx* closed-form; Soto-Gamez Cell Death Differ 2024 10.1038/s41418-024-01431-1) ·
window-ceiling 🔵/🟠 (p_dep ceiling theorem; SenePy 10.1038/s41467-025-57047-7) ·
selectivity-escape 🟢 (S_total=∏S_i; GLS1 Science 2021 10.1126/science.abb5916; PROTAC 10.1038/s41467-020-15838-0) ·
senolytic-corpus 🟢/🟠 (affinity≠selectivity confirmed via navitoclax; UBX1325 NEJM Evid 2025 10.1056/EVIDoa2400009).
Lane detail: state/senolyx-selectivity-law/<lane>/FINDINGS.md.

---

## R2 — NOVEL frontier 정량 + 게이트 변수 정정 (3-lens, 2026-06-19)

### THE NUMBER (escape 항을 실측 수치로 닫음 — 문헌 최초)
직교 AND-gate(metabolic×surface×lysosomal) 현실적 S_total = **~4× (median; 90%대역 1.4–11×)**
→ 전신투여 시 노화세포 **~7–28% 만 <5% 건강세포 손상으로 청소 가능**.
- 단일 마커 = 순 ANTI-selective ~0.5× (Hill 동시개방 페널티) · 2-marker 한계 ~1.6× (1× 걸침) · **3-marker = 최소 가용**.
- 값의 전부가 **독립성(ρ)+곱셈적 누출** 가정에 달림 (ρ0→9.9× · ρ0.6→1.5×; 축이 누출경로 공유하면 sub-1× 붕괴).

### THE BACKBONE (pan-senescent 천장 정량)
**진정한 pan-senescent 의존성은 없음** (best=BCL-xL+MCL-1 priming p_dep≈0.65; dual BCL∪GPX4 0.73–0.85; **불가역 잔존 refractory 15–35%**).
SA-β-gal(0.92)는 KILL이 아니라 **near-universal 인식 태그** → 설계: 백본=pan-senescent DEPENDENCY(BCL-combo±GPX4), AND-gate 선택성=비치사 인식태그(SA-β-gal+context). GLS1 강등(EMBO Rep 2026 in-vivo 재현실패).

### THE GATE-VARIABLE CORRECTION (2차 "틀린 축" — affinity에 이어)
clearance-% → η_neo → cure 전달함수가 **비단조·문헌 미근거**. UBX0101 ~50% 청소로 전임상 OA 완전재생했으나 인간 OA Ph2 실패; UBX1325 망막은 **국소전달+정확한 causal subtype**으로 성공(높은 청소% 아님). ARCHITECTURE의 72/78% 게이트 = 투영값(문헌 근거 없음).
**정정:** η_neo-lift = f(SASP-구동 SUBTYPE 청소 · 국소 부담경감 · 재축적속도). clearance-%는 약한 비단조 proxy = 잘못된 게이트 변수.

### CURE-domain PASS/FAIL (현실 f_clear ~30-60% 전신)
OA 🔴(2중 실패: f_clear<78% + 78% 게이트 자체 falsified) · RETINA 🟠(precedent PASS·clearance-% 아님·국소) · PERIO 🔴 · AGA 🔴.

## UPDATED VERDICT (honest, d6 · R1+R2)
1. **선택성 ≠ 친화도** (R1, 기전적): affinity 축 closed.
2. **clearance-% ≠ cure-predictor** (R2, 기전적): 다운스트림 게이트 변수도 closed — η_neo는 subtype·국소·재축적이 정함.
3. 단일표적 = 정리-천장(p_dep<1). 전신 broad senolytic = 약한 선택성(~4×)+낮은 청소(~7-28%)+잔존 15-35% = **CLOSED**.
4. **유일 가용 경로 = 국소전달 + 단일 dominant causal subtype + 느린 재축적 + BCL/GPX4 백본 위 직교 AND-gate(SA-β-gal 인식태그)** — 망막-class만. 임상 미증명.
5. **NOVEL frontier (d_novel_only·미선례):** *재생niche 섬유아세포 선택적·국소전달·직교 AND-gate* senolytic — 어떤 논문도 2-marker senescence 선택성 인자를 정량한 바 없고, fibroblast-niche 국소 AND-gate senolytic 선례 0. = SENOLYX의 진짜 다음 캠페인(법칙사냥 아닌 설계·계산).
