# session-journal — ANTIMATTER FACTORY 모노그래프 작업 arc

이 파일은 ANTIMATTER FACTORY 페이퍼를 만든 작업 세션들의 narrative를 한글로 압축한다.
모든 sim 레코드는 `absorbed=false` — 6개 non-wet-lab 공정을 통과한 디자인은 *공장
engineering feasibility의 witness*이지, 생성·측정된 반수소 샘플이 아니다. CPT 측정
(공정 ⓻)은 영구 measured-oracle 경계로 남는다 (@D d5).

---

## arc 1 — 도메인 탄생: 공정 = 축 (RTSC 미러링)

CERN이 자기네 AD/ELENA 시설을 *Antimatter Factory*라 부르듯, ANTIMATTER 도메인은
**생산라인의 각 공정을 곧 한 축**으로 둔다 — RTSC가 자석 하나를 5축으로 펼친 것과 같은
패턴. 분광·가둠·생성을 별개 도메인으로 쪼개지 않고 한 우산 아래 *공정 축*으로 둔다
(Occam g0). 7공정: ⓵생성 → ⓶감속 → ⓷포획 → ⓸냉각 → ⓹합성 → ⓺가둠 → ⓻측정.

## arc 2 — 6개 non-wet-lab 공정 verify-native 닫기

⓵생성(pair-threshold 6·7 m_p c²) · ⓶감속(rel ladder, #1014) · ⓷포획(Penning 3-freq +
invariance, atlas-fold) · ⓸냉각(τ∝B⁻², #1015) · ⓹합성(n_e²T⁻⁹ᐟ², #1018) ·
⓻측정 leading(¾R∞c, #1005). 전부 `hexa verify --expr`로 닫음, verbatim verdict
인용(@D g5, LLM 자기판정 금지).

### war-story callout: Penning invariance 잔차 0.0
불변량 정리 ω_c² = ω₊² + ω_z² + ω₋²의 재구성 잔차가 machine precision에서 정확히
0.0. tier는 🟢(SUPPORTED-NUMERICAL)이지만 — 밑에 깔린 sqrt 때문 — 정리 자체는
exact algebraic identity. 이 도메인의 가장 날카로운 closed result.

## arc 3 — ⓺가둠: RTSC 자석 toolchain 직계 상속 (PR #168)

⓺가둠은 **신규 코드가 아니라 RTSC 자석 cell의 직계 확장**. Wheeler on-axis 현재-루프
폐형해(loop_offaxis_Bz r=0)를 두 mirror coil로 중첩 → 자기최소(magnetic bottle)
우물. μ_B/k_B = 0.67171 K/T로 1T 우물 = 0.672 K. 솔레노이드가 자기장을 *모으는*
장치라면, Ioffe-Pritchard 트랩은 자기장 *최소점(우물)*을 만들어 중성 반수소를 가두는
장치 — 같은 getdp magnetostatic 척추, 형상만 다름. 🟢×7 + 🔴×1 닫음.

### war-story callout: wrap-and-fix가 필요 없던 이유
HEXA-FUSION은 3개 외부-솔버 어댑터를 wrap-and-fix하며 3개 결함을 surface했지만,
ANTIMATTER는 자석 커널을 *상속*했기에 새 어댑터 wrap이 없었고 → 새 결함도 없다.
`adapter-defect-catalog.json`이 비어있는 건 gap이 아니라 정직 — verify-once-reuse-twice.

## arc 4 — BLUE-MAX 11/11 + g69 PASS (#1094 → #1107)

모든 libm-class atom(sqrt/pow) 밑에 깔린 정수 지수/계수를 🔵 SUPPORTED-FORMAL로 백업.
core 3개(pair_factor 6 · cooling_bexponent -2 · recomb_density 2) + BLUE-MAX 8개
(6·7·3·4·3·2·-9·9) = 11/11 coverage. `hexa verify --blue-max ANTIMATTER` → ✅ PASS
(g69 finalization-gate cleared). 음성대조 8건 전부 🔴 → result-agnostic 입증.

## arc 5 — honest stance: absorbed=false 유지

7/7 공정 폐형해/수치 닫힘(🔵 3 · 🟢 20 · 🔴 8 controls) + BLUE-MAX 11/11에도 불구하고
도메인 `absorbed=false` 유지: CPT Δ(H vs H̄ 1S-2S)는 **측정 oracle 필요**(ALPHA 2018
≈2e-12, BASE g-factor). leading 폐형해는 f≈2.4674 PHz 재현하나 측정 15자리와
5.35e-4 차이(reduced-mass + QED) — overclaim 금지. measured oracle은 downstream
wet-lab confirmation이며 projection으로 flip 금지 (@D d5 · d6).

## arc 6 — 이 모노그래프 (SKELETON + BODY)

HEXA-FUSION 58-page 모노그래프를 ANTIMATTER 도메인으로 미러. 본 pass = body §1-9 +
§Full Pipeline + 12-appendix SKELETON(A-L, TODO 마커) + companion/ + fal.ai cover.
appendix FILL은 다음 batch. xelatex, absorbed=false 정직 throughout.

### war-story callout: 형제 agent가 worktree를 wipe
첫 worktree(`~/wt-antimatter-mono`)가 작업 중 형제 agent의 prune/cleanup으로
.git + 대부분 파일이 삭제됨 (project_hexa_lang_recurring_wipes 패턴). 격리된 /tmp
worktree off origin/main으로 재구성 후 전 파일 재기록 → land (@D d9 isolation).
