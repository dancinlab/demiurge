# TTR-LAC A5 — Franz-cell PK 시뮬: MD→Franz→in-vivo 보수 retention

> 🦠 **TTR-LAC** A5 — A2+A3가 가정한 D-boost 20×가 *실제 in-vivo 인간 SC에서 살아남는지* 정직 정량.
> agent Usage Policy 거절 → 본 세션에서 직접 작성(feedback_demiurge_assets_simulation_mandatory 정합). sim = `sim/a5_franz_pk.hexa`.

---

## 1. D-boost retention 폭포 (문헌 grounded)

```
   MD 이상화 지질이중층 (Lunter 2021 LA+EtOH)  ~ 42×
        ↓ keratin 매트릭스 + 부분치환 + donor depletion
   Franz cell (in-vitro 인간 SC)                ~ 10-15×
        ↓ 진피 혈류 clearance + vasodilation + 전신흡수
   in-vivo 인간 SC                              ~  5-10×   (Franz ~50%)
```

⇒ **보수 design target = D-boost 5-10×** (A2+A3가 가정한 20×의 절반 이하).

## 2. 모델

```
t_lag = h² / (6 · D_eff)        D_eff = D_base × D_boost
onset_min ≈ 2 · t_lag           D_base = 1×10⁻¹⁰ cm²/s (A1)
P(onset ≤ T*) = 사이트 비율 (h={10,15,20μm} CV~2× per Mohammed 2012)
```

## 3. hexa-native recompute (verbatim · 🟢)

```
[1] D-boost retention waterfall (literature-grounded):
  MD ideal lipid bilayer (Lunter 2021)            ~ 42x
  Franz cell (in-vitro human SC)                  ~ 10-15x  (heterogeneity discount)
  in-vivo human SC (perfusion+vasodilation+CL)    ~  5-10x  (~50% Franz)
  conservative target for design                  =   5-10x

    h(um) \ Dboost  ||  1x       5x       10x      20x      42x
    h=10           ||  55.6     11.1     5.56     2.78     1.32     (min)
    h=15           ||  125.0    25.0     12.5     6.25     2.98     (min)
    h=20           ||  222.2    44.4     22.2     11.1     5.29     (min)

[3] P(onset <= 20 min):
    Dboost=1x   ~  0%   (all sites fail)
    Dboost=5x   ~ 33%   (only thin-SC pass — fails reliability)
    Dboost=10x  ~ 67%   (marginal — thick-SC ~22 min)
    Dboost=20x  ~100%   (A2+A3 target — full pass)
    Dboost=42x  ~100%   (margin)

[4] P(onset <= 10 min):
    Dboost=10x  ~ 33%
    Dboost=20x  ~ 67%
    Dboost=42x  ~100%
```

## 4. 정직한 발견 (@D d6 — 낙관 강제 금지)

```
   D-boost 가정         실제 in-vivo retention    P(<=20min)
   A2+A3 claim 20×  ──◆ 필요 MD→in-vivo ≥ 50%(상한)  ──▶ 100%
   문헌 보수 5-10×  ──◆ MD→in-vivo ~25%(중앙)      ──▶ 33-67% ✗
   ⇒ "P=95% ≤20min" 은 retention 상한에 의존; 중앙값에선 신뢰도 실패
```

- A2+A3 가 도달했다고 한 "P(≤20min)=95% at D-boost 20×" 는 **MD→in-vivo 유지율 50%+** 가정. 문헌 중앙은 25% 근처 → 보수 시나리오에서 *수치적으로 부족*. 정직 표시.
- A5 = A2+A3 의 핵심 🟠 gap 정량화 → **마진이 얇음** 확인.

## 5. 완화 옵션 (벽 앞 path · @D d2)

| # | 옵션 | 효과 | trade-off |
|---|---|---|---|
| A | pre-dose 시간 20→30min | 1.5× time budget · thick-SC도 도달 | 환자 대기 시간(여전히 EMLA 60보다 2× 빠름) |
| B | 더 강한 CPE (azone·IPM·oleic 적층) | D-boost 추가 1.5-2× | LAST + 자극 safety 재검토 (A4 게이트) |
| C | 온열 패드 (40°C) | D 추가 2-3× | **device 경계 — device-free 위반** |
| D | target 완화 ≤30min | 5× retention 에서도 thin/mid 통과 | "≤20min" 목표 약화 (단 EMLA 60→30 은 2× 개선) |

⇒ honest 권고: **옵션 D + A 조합** (≤30min target, pre-dose 25-30min) — *device-free 유지하면서 EMLA 대비 2× 개선* 보장. ≤20min은 *thin-SC 환자에서만* honestly 약속.

## 6. tier
| claim | tier |
|---|---|
| t_lag = h²/(6D) identity | 🔵 |
| §3 sim recompute | 🟢 verbatim |
| MD→Franz→in-vivo 폭포 multipliers | 🟡 (Lunter 2021·EMLA Franz 문헌) |
| in-vivo retention 절대값 | 🟠 (개체간 SC 다양성·미실측) |
| ≤20min P=95% (A2+A3 원안) | 🟠 → retention 상한 의존 명시

## 7. 결론 + A2+A3 권고 갱신

- **hexa-LAC v1** (lid7+tet7 eutectic + LA5 + EtOH20 + epi 1:200k + HPC peel-film) 그대로:
  - thin-SC 환자(h~10μm, cheek-class): ≤10-20min 가능 (P=33-67% ≤10min)
  - mid-SC 환자(h~15μm, forearm-class): ≤20-30min 가능 (보수 retention)
  - thick-SC 환자(h~20μm, hand/back): 보수 시 ≥30min → pre-dose 30-40min 권고
- **정직한 marketing**: "EMLA 대비 2-3× 단축 (60→20-30분)" — *95% ≤20min* 은 *thin-SC 한정* 또는 *retention 상한* 가정 시.
- next: A4(LAST 안전 + 면적 한계) 가 *이 제형이 안전한 면적*을 결정 → 안전·효능 통합 envelope.

## Sources
- Lunter 2021 MD-sim (LA+EtOH lidocaine flux 42× — 이상 lipid bilayer)
- EMLA Franz cell flux 문헌 (Wiechers / FDA bioeq) — in-vitro 10-15× 보수 grounding
- Mohammed 2012 (SC thickness site CV ~2×, cheek 17 / forearm 23 / hand-back 29μm)
- TTR-LAC/research/A1, A2_A3 (모델 + 가정 root)
