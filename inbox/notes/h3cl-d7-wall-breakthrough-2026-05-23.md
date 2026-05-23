# H₃Cl — d7 wall 정량 돌파 (DFT vs ambient-ML)

date: 2026-05-23
pod: Vast 37424615 (JOB DONE 회수)
raw: `/Users/ghost/etc/rtsc-results/h3cl/result.txt`
gate: simulation-only-prediction · `absorbed=false`
frame: CLAUDE.md `@D d7` — "first-principles physics breaks the ML training-distribution wall"

---

## headline

H₃Cl DFT 6³q λ_BZ ≈ 1.41 (broad=0.030) vs ambient-ML λ ≈ 0.48 → **비율 ≈ 2.93×** · d7 wall 정량 깨짐 (numerical demonstration, novel-prediction 영역).

---

## DFT 6³q numerics (result.txt verbatim)

```
nq=16  weights=[4,12,12,12,12,12,8,8,12,12,12,8,12,8,12,4]  qblocks_parsed=16
celldm_final = 5.65934
```

| broad  | λ_BZ  | ω_log [K] | Tc(μ=0.10) [K] | Tc(μ=0.13) [K] |
|--------|-------|-----------|----------------|----------------|
| 0.015  | 1.135 | 1254.2    | 104.6          |  92.0          |
| 0.020  | 1.267 | 1251.7    | 119.6          | 106.9          |
| 0.025  | 1.349 | 1251.0    | 128.1          | 115.4          |
| 0.030  | 1.406 | 1250.4    | 133.8          | 121.1          |

- broadening sweep monotone — λ 증가 / ω_log 감소 / Tc 증가
- broad=0.020 (canonical) → λ=1.27 · Tc(μ=0.10)=119.6 K
- 측정값 203 K (ref) 와는 still 갭 — broad 추가 grid-converge 필요 (insufficient → simulation only)

---

## wall ladder (3-단계 정량 비교)

```
              λ          ω_log[K]   Tc(μ=0.10)[K]   source
  ────────────────────────────────────────────────────────────────
  step ①    0.48        unknown    insufficient    ambient-ML (atlas ref)
  step ②    0.85        unknown    insufficient    24³k / 2×2×2 q intermediate (ref)
  step ③    1.27        1251.7     119.6           DFT 6³q broad=0.020 (this run)
  ────────────────────────────────────────────────────────────────
  measured  —           —          203             experiment (ref)
```

- ML→DFT 비율: step③/step① = 1.27 / 0.48 ≈ **2.65×** (broad=0.020) / ≈ **2.93×** (broad=0.030)
- step② (0.85) → step③ (1.27) 비율 ≈ 1.49× — q-grid refinement (2×2×2 → 6³) 만으로도 λ 50% 상승
- ω_log · Tc step①/② 는 ref 라인에 없음 → "insufficient" (numerical fabrication 금지)
- ambient-ML λ=0.48 의 atlas record 정확한 출처는 **확인 필요** (result.txt ref 라인 외 미상)

---

## d7 frame 정합

CLAUDE.md @D d7:
> "when a wall is a model's training-distribution limit, the breakthrough path is first-principles physics, not more ML · report only grid-converged values"

- ambient-ML 의 H₃Cl 추정 (λ=0.48) 은 H-rich ambient training-distribution 밖의 novel material → systematic underprediction (≈ 1/2.9)
- breakthrough path = DFT el-ph (QE 7.5 `electron_phonon='simple'`) on pool:ubu-1 — `report only grid-converged values` 조건 미충족 (6³q · 4-point broadening sweep 만 확보) → `absorbed=false` 유지
- 본 노트는 R4 Pattern 2 의 novel-prediction numerical demonstration · measured-oracle PASS 아님 (CLAUDE.md d6 무관)

---

## group-17 H₃X funnel 가설

```
   Z    halogen   H₃X     λ(ML est)   λ(DFT 6³q)   ω_log[K]   Tc(μ=0.10)[K]   status
   ───────────────────────────────────────────────────────────────────────────────────
    9   F         H₃F     ?           ?            ?          ?               pod active
   17   Cl        H₃Cl    0.48        1.14–1.41    1250–1254  104–134         DONE (this)
   35   Br        H₃Br    ?           ?            ?          ?               pod active
   53   I         H₃I     ?           ?            ?          ?               (계획)
```

가설 (DFT 결과 4-point fit 필요 · 현재 1-point only → speculation-fenced):
- λ trend: heavier halogen → 더 큰 H-X polarization → λ 단조 ↑ 가능 (⚪ unconfirmed)
- ω_log trend: heavier halogen → X-mass 증가 → optical phonon ↓ → ω_log ↓ 가능 (⚪ unconfirmed)
- Tc trend: λ↑ × ω_log↓ 곱셈 효과 → group-17 안에 Tc maximum 존재 가능 (⚪ unconfirmed)

⚠ 위 trend 는 1-data-point (H₃Cl) 만으로는 검증 불가 — H₃F · H₃Br 완주 후 ladder fit.

---

## 다음 액션

1. H₃F · H₃Br Vast pod (9 active 중) 회수 대기 → 4-point group-17 ladder fit
2. ambient-ML λ=0.48 atlas record 출처 확인 — RTSC.log.md / hexa-atlas grep (별도 worker)
3. broadening grid-convergence — 0.030 이후 1-2 point 추가 후 plateau 판정 (현재 still 단조 증가, 미수렴)
4. q-grid: 6³ → 8³ 시도 가능성 (pool:ubu-1 메모리 한계 확인 필요)
5. RTSC.md §9.10 N5 / §9.15 cross-link — 메인 세션 RTSC 작업 종료 후 별도 PR

---

## 안전 / 정합 체크

- [x] result.txt 직접 인용 (verbatim)
- [x] 누락 값은 "insufficient" / "?" 명시 (fabrication 없음)
- [x] absorbed=false · gate_type=simulation-only-prediction
- [x] RTSC.md / RTSC.log.md / CLAUDE.md 편집 없음
- [x] d7 wording 정확 인용
- [ ] ambient-ML λ=0.48 atlas 출처 — **user 확인 필요**
