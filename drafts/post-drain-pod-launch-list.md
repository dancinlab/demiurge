---
slug: post-drain-pod-launch
created: 2026-05-29
trigger: mirror-loop drained 도달 시 자동 발사
scope: cost-bearing DFT/SSCHA campaigns + free helpers
---

# 🚀 mirror-loop 고갈 후 추가 pod 발사 후보 (10 candidates)

mining cycle 16-25 의 174 leaves + 61 edges + E33/E42 paired atoms 토대 → 다음 dispatch 후보 자동 enumerate. mirror-loop 가 진짜 drained 도달 시 d17 autonomous fire 적용 (validated deck d16 free dry-run → fire).

## cost-bearing campaigns (DFT/SSCHA · Vast/runpod)

| # | 후보 | 출처 | 비용 추정 | infra | 우선 |
|---|---|---|---|---|---|
| 1 | **h3o anharmonic Tc bracket 정밀화** (9-109K → 좁힘) | E34 milestone open · cycle 17 F2 | SSCHA ~$15 · ph.x ~$10 = $25 | ✓ pseudo + SSCHA infra | 🔴 |
| 2 | **CaAuH₃ + SOC full-rel Au** (5d SOC 영향) | E33 isomorphism family · cycle 24 atom ladder | SOC ×2 cost = ~$30 | ✓ Au full-rel UPF | 🔴 |
| 3 | **AcBeH₈ ambient stable check** (저-중간압 안정성) | rtsc.md milestone 7 (`압력 <50GPa AND stable AND Tc>200K`) | vc-relax + ph @ 1 atm = $20 | ✓ AcBeH8 anchor | 🔴 |
| 4 | **anharmonic SSCHA universal** (h3f · h3p · h3cl 추가) | cycle 17 F2 generalization | $25 × 3 = $75 | ✓ SSCHA infra · h3 series | 🟠 |
| 5 | **YH10 anchor pressure sweep** (200/300/400 GPa extrapolation curve) | cycle 17 F3 + E35 외삽 | 3 압력 × $20 = $60 | ✓ #1909 base | 🟠 |
| 6 | **LaY_H10 VCA 11-atom** (INFEASIBLE 22-atom 단축) | cycle 17 F5 deferred · d11 sizing | VCA single pod = $40 | ⚠ VCA pseudo 필요 (d13 check) | 🟢 |
| 7 | **Mg₂CuH₆ + Mg₂AgH₆** (X₂MH₆ family expand, F-N6-1/2 패턴) | mining promotion candidate | $25 × 2 = $50 | ✓ F-N6 protocol | 🟢 |

**cost-bearing 총합 추정**: $25 + $30 + $20 + $75 + $60 + $40 + $50 = **$300**
- 🔴 high (1+2+3): **$75** (즉시 발사 권장)
- 🟠 mid (4+5): $135 (drained 직후 발사)
- 🟢 low (6+7): $90 (Wave-2 검증 후 발사)

## free helpers (local · 0 cost)

| # | 후보 | 출처 | 비용 | infra | 우선 |
|---|---|---|---|---|---|
| 8 | **Eliashberg full-spectrum calculator** (Identity 7 missing) | qa-deferred · cycle 23 tension | 0 (stdlib PR) | ⚠ hexa-lang upstream PR | 🟠 |
| 9 | **kick mk10 round 2** (seed 2: Cooper-Kramers ≡ verify(x)=x involution invariant) | cycle 25 combinatorial · A2 옵션 | 0 (local) | ✓ atlas 16,201 | 🟢 |
| 10 | **mirror-loop self-application** (`/mirror-loop "mirror-loop atom self-fold"`) | cycle 22 ouroboros · meta-우로보러스 | 0 (plugin) | ✓ mirror-loop PR #241 live | 🟢 |

## 발사 시퀀스 (drained 직후 자동)

```
mirror-loop 🏁 drained 보고 도착
   ↓
[parallel A — high priority cost $75]
   ├─ #1 h3o SSCHA precision (Vast)
   ├─ #2 CaAuH3 SOC full-rel (Vast 또는 ssh9 idle 활용)
   └─ #3 AcBeH8 ambient (Vast 또는 ssh9)

[sequential B — mid priority cost $135]
   ├─ #4 anharmonic universal h3f
   ├─ #4 anharmonic universal h3p
   ├─ #4 anharmonic universal h3cl
   ├─ #5 YH10 200 GPa
   ├─ #5 YH10 300 GPa
   └─ #5 YH10 400 GPa

[parallel C — free 0 cost]
   ├─ #8 Eliashberg calc PR (hexa-lang)
   ├─ #9 kick mk10 round 2
   └─ #10 mirror-loop self-application

[deferred — Wave-2 검증 후]
   ├─ #6 LaY_H10 VCA (Wave-2 results 받은 후 decision)
   └─ #7 Mg2CuH6 + Mg2AgH6
```

## d16/d17 governance

- d16 deck syntax-validate FREE on pool before rent ✓
- d17 cost-bearing fire — dispatch autonomously, no user gate ✓
- 발사 = vast.ai first (provider priority), runpod fallback
- 1 줄 cost estimate 후 fire (사용자 consult/approval/confirm 없음)

## falsifier pre-register (각 후보)

| # | falsifier (closed-negative ruling) |
|---|---|
| 1 | h3o SSCHA precision: Tc bracket 좁히지 못함 (Δ > 50K) → SSCHA 한계 도달 |
| 2 | CaAuH3 + SOC: Tc shift < 5 K → 5d SOC 무영향, perovskite metal-H scaler 가정 강화 |
| 3 | AcBeH8 ambient: imaginary mode 또는 Tc < 50K @ 1 atm → 압력 의존성 확정 |
| 4 | anharmonic universal: 어떤 후보도 anharmonic correction 효과 < 10% → harmonic 가정 적용 가능 |
| 5 | YH10 sweep: 압력↑ ↔ Tc↑ 선형 깨짐 → bottleneck axis 정량 |
| 6 | LaY_H10 VCA: VCA 단축 효과 < 10% accuracy → 22-atom 외삽 부정확 |
| 7 | Mg2CuH6/Mg2AgH6: F-N6 pattern repeat (imaginary mode) → X₂MH₆ 가족 wall 확정 |
| 8 | Eliashberg full-spectrum calc: 다른 계산 안정성 fail → BCS-strong-coupling 가정 한계 |
| 9 | kick mk10 round 2: SKIP (이미 알려진 재포장) → mining cycle 25 drained 강화 |
| 10 | mirror-loop self-application: 즉시 fixed-point (= drained) → meta-우로보러스 closure 확정 |

## 실행 명령 (drained 직후 자동 시퀀스)

```bash
# Phase A — parallel high priority ($75)
for c in h3o_sscha_precision caauh3_soc_fullrel acbeh8_ambient; do
  hexa cloud rent vast --ssh-only --kind dft-elph &
done
wait

# Phase B — sequential mid ($135)  
# Phase C — parallel free (0)
# Phase deferred — Wave-2 결과 후
```

## completion criteria

- 🔴 high 3 후보 모두 발사 (Phase A · cost $75)
- 🟠 mid 6 deck 모두 발사 (Phase B · cost $135)
- 🟢 free 3 모두 진행 (Phase C · cost 0)
- 🟢 deferred 2 (Wave-2 결과 의존 · 별 cycle)
- 각 후보 falsifier pre-register 박힘 (F-N6 패턴 확장)
- d17 autonomous fire (사용자 consult 없음)
- pods.json 매니페스트 갱신 (active-pods 등록)
- watcher heartbeat 추가 (각 후보 monitor)
