# 🛸 UFO meta — EXPERIMENTS + HYPOTHESES 카탈로그 흡수 (13-falsifier monotone)

> 도메인: UFO (`UFO.md`) · Phase D 메타 (lattice + bookkeeping + cross-domain)
> 성격: **흡수 manifest** — in-tree source `UFO/EXPERIMENTS.md` + `UFO/HYPOTHESES.md` 의 실험/가설 카탈로그를 흡수하고, Stage-4~7 13-falsifier 의 상태 set `{OPEN,CONFIRMED,DEMOTED}` monotone 표를 한 곳에 봉합. **13개 전부 OPEN · academically UNPROVEN** (CONFIRMED 거짓 표기 금지).
> 별칭: experiments-hypotheses · alias `exp-hypo`

---

## 0. TL;DR — 실험 카탈로그 + 가설 + 13-falsifier 전부 OPEN

UFO 의 실험·가설 surface 는 **두 계층**으로 나뉜다. (1) `EXPERIMENTS.md` 의 3-STACK×12 hardware 실험 (RTSC/MHD/Fusion 벤치 — bench-scale, 실 측정은 wet-lab downstream) + (2) Stage-4~7 13-falsifier preregister (warp/wormhole/dim-jump/dim-use — academically UNPROVEN). 이 manifest 는 두 카탈로그를 흡수하고, **13-falsifier 의 monotone 상태 set 을 SSOT (`UFO/verify/stage4-7-falsifier-preregister.md`) 와 동기화**한다.

```
┌──────────────────────────────────────────────────────────────────────────┐
│  UFO 실험·가설 카탈로그 — 2 계층                                          │
├──────────────────────────────────────────────────────────────────────────┤
│  계층 ①  EXPERIMENTS.md §8 — 3-STACK × τ=4 = σ=12 hardware 실험           │
│           Stack A (RTSC/Meissner) · B (MHD) · C (Fusion 벤치)             │
│           gate: SNR≥24dB ∧ 1-β≥0.92 ∧ α≤0.0139 ∧ χ² p<0.001              │
│           → bench-scale design target (실 측정 = wet-lab downstream)      │
│                                                                            │
│  계층 ②  Stage-4~7 13-falsifier — warp/wormhole/dim-jump/dim-use          │
│           F-WARP×3 · F-WORM×3 · F-DIM×3 · F-USE×4                         │
│           상태 set {OPEN,CONFIRMED,DEMOTED} monotone — 전부 OPEN @ v1.0   │
│           → academically UNPROVEN (절대 verified/proven 미표기)           │
│                                                                            │
│  HYPOTHESES.md — P-H1~P-H6 가설 + n=6 testable predictions (사전등록)     │
└──────────────────────────────────────────────────────────────────────────┘

monotone:  OPEN ──► CONFIRMED  (반증 명제 경험적 확정 → lattice claim DEMOTED)
           OPEN ──► DEMOTED    (경험적 진전이 lattice 예측 확증 → falsifier 무력화)
           ⚠ 13/13 전부 OPEN — 어느 것도 flip 되지 않음 (CONFIRMED 거짓 도장 금지)
```

---

## 1. 흡수 source (provenance)

| source | git blob SHA | LOC | 흡수 범위 |
|--------|--------------|-----|-----------|
| `UFO/EXPERIMENTS.md` | `b02edd297704328025dd4d95f3e0d846ea7c7c6e` | 681 | §8 3-STACK×12 hardware 실험 pipeline · §8.5 실험 falsifier |
| `UFO/HYPOTHESES.md` | `cafa8a974975d3cb9f53c17c1ae9c5fad2dd55ea` | 2818 | §6 Testable Predictions P-H1~P-H6 · n=6 가설 카탈로그 (H-OURO 등) |
| `UFO/verify/stage4-7-falsifier-preregister.md` | (in-tree SSOT) | 256 | 13-falsifier 표 (F-WARP/WORM/DIM/USE) — monotone 상태 set |

- 흡수 = manifest 만 — 원본 실험 설계/가설 서술은 source 에 보존. 여기서는 **카탈로그 요약 + 13-falsifier 상태 동기화**만.
- 13-falsifier 의 **SSOT 는 `UFO/verify/stage4-7-falsifier-preregister.md`** — 본 manifest 는 그 view (상태 거짓 변경 금지).

---

## 2. 13-falsifier 카탈로그 — 상태 set {OPEN, CONFIRMED, DEMOTED} monotone

Stage-4~7 의 13개 반증 명제. **전부 `OPEN` @ v1.0** · 물리는 academically UNPROVEN. 상태는 `.own` own 2 계약에 따라 **단방향 monotone** 으로만 전이한다 (silent retract 금지). SSOT = `UFO/verify/stage4-7-falsifier-preregister.md` §0 표 + `.tape` `@F` 노드 ×13.

| Stage | ID | 반증 명제 (요약) | 측정량 | falsify ⇒ DEMOTE | status |
|-------|-----|------------------|--------|------------------|--------|
| 4 warp | **F-WARP-1** | σ=12 Casimir 판 배열이 warp-bubble 스케일 음에너지 밀도 못 만듦 | ρ_Casimir = −ℏc/(τ·d⁴) vs Pfenning-Ford QI bound | warp-bubble 음에너지 claim | `OPEN` |
| 4 warp | **F-WARP-2** | bubble wall 관측자가 bubble 밖 신호 불가 (Alcubierre horizon) | causal signal reach vs R | controllable warp drive claim | `OPEN` |
| 4 warp | **F-WARP-3** | Hawking-류 back-reaction 이 추진 완료 전 bubble 파괴 | τ_collapse vs τ_propulsion | self-stable warp claim | `OPEN` |
| 5 worm | **F-WORM-1** | 어떤 양자장 source 도 b₀>ℓ_Pl 외계물질 밀도 못 유지 | exotic ρ @ b₀>ℓ_Pl | macroscopic Morris-Thorne throat claim | `OPEN` |
| 5 worm | **F-WORM-2** | quantum-interest back-reaction 이 throat 붕괴 (Ford-Roman/Pfenning-Ford) | ∫T_μν kᵘkᵛ dλ vs ANEC bound | stable-throat claim | `OPEN` |
| 5 worm | **F-WORM-3** | chronology protection (Hawking 1992) 가 통과 차단 (CTC 금지) | CTC formation 가능성 | traversable claim | `OPEN` |
| 6 dim | **F-DIM-1** | LHC 14 TeV KK-resonance 사냥 null | m_KK = n·ℏ/(R_c·c) | m_KK closed-form (R_c probed) | `OPEN` |
| 6 dim | **F-DIM-2** | sub-mm 중력시험 (torsion-balance/Eöt-Wash) null | R_c = ℓ_Pl·σ^(n/φ) = 1728 ℓ_Pl | σ^(n/φ) compactification radius | `OPEN` |
| 6 dim | **F-DIM-3** | dimensional-fold 진공에너지 전이 미관측 | E_fold = M_Pl c²/(σ−φ)^d | E_fold barrier scale | `OPEN` |
| 7 use | **F-USE-1** | warp Stage-4 ANEC bound 포화 (upstream-derived) | upstream F-WARP-* 처분 | 10c warp factor | `OPEN` |
| 7 use | **F-USE-2** | dimjump Stage-6 KK m > 14 TeV (upstream-derived) | upstream F-DIM-1 처분 | 10× dimensional compression | `OPEN` |
| 7 use | **F-USE-3** | self-cycle 가 4D 투영에서 열역학 2법칙 위반 (composite) | E_fold release vs E_warp consume | closed-loop energy claim | `OPEN` |
| 7 use | **F-USE-4** | composite back-reaction 이 두 stage 동시 불안정화 (composite) | τ=4 cycle 안정성 | τ=4 cycle stability | `OPEN` |

**집계: OPEN 13 · CONFIRMED 0 · DEMOTED 0** (= 13/13 OPEN · UNPROVEN).

> **monotone 계약**: `OPEN → CONFIRMED` (반증 명제 경험적 확정 → 대응 lattice claim DEMOTED) · `OPEN → DEMOTED` (경험적 진전이 lattice 예측 확증 → falsifier 무력화). 한 번 flip 되면 OPEN 으로 복귀 금지. 어떤 sentinel/PASS 출력도 경험적 claim 을 validate 하지 않는다.
> **CONSTRAINT (정직)**: 이 13개를 CONFIRMED 로 표기하는 것은 거짓이다 — lattice 산술(σ·τ=48 등)은 검증 가능하나 그 물리는 미증명. `UFO/CHANGELOG.md` 의 "T1/T2/T3 anchored 100%" 는 **algebraic + spec-doc cross-check** 일 뿐 wet-lab 확증이 아니다 → falsifier status 는 여전히 OPEN.

---

## 3. experiments 카탈로그 요약 — 어떤 실험이 어떤 falsifier 를 닫나

`EXPERIMENTS.md §8` 의 3-STACK×12 hardware 실험은 **하위 Stage-1~3 (RTSC/MHD/Fusion) 의 bench-scale 측정**을 다룬다 (계층 ①). Stage-4~7 13-falsifier (계층 ②) 는 이 hardware 벤치로 직접 닫히지 않으며, 별도의 음에너지원·여분차원 관측·simulator 경로를 요구한다.

| Stack | 실험 (대표) | 성공 조건 | 닫는 대상 | wet-lab? |
|-------|-------------|-----------|-----------|----------|
| A (RTSC/Meissner) | A1 YBCO 77K 부상력 · A4 RT-SC Mk.I | F/m ≥ 10 N/kg · τ_hold ≥ 24h | Stage-1 hover substrate (계층 ①) | yes (downstream) |
| B (MHD) | B1 해수 MHD thrust · B4 6-coil duct | F ≥ 48 N/m³ · η ≥ 12% | Stage-2 cruise substrate (계층 ①) | yes (downstream) |
| C (Fusion) | C1 IEC fusor · C3 pB¹¹ micro-reactor | n/s ≥ 4.8e5 · Q ≥ 3 | Stage-2 추진 에너지 substrate (계층 ①) | yes (downstream) |
| (sim) | F-USE-3/4 composite simulator (v1.1.0) | 2법칙 net energy · τ=4 안정성 | F-USE-3 · F-USE-4 (계층 ②) | no (sim — pool/cloud @D d7) |
| (관측) | LHC KK-resonance · sub-mm gravity | m_KK · R_c 감도 | F-DIM-1 · F-DIM-2 (계층 ②) | no (외부 관측 downstream) |
| (벤치) | Casimir σ=12 plate 음에너지 | QI bound 내 외삽 | F-WARP-1 (계층 ②) | yes (bench downstream) |

- **계층 ①** (hardware 실험): gate = `SNR≥24dB ∧ 1-β≥0.92 ∧ α≤0.0139 ∧ χ² p<0.001`, ≥9/12 PASS → 3-stack 통합 candidate. 실 측정은 wet-lab downstream — 본 manifest 에서 어떤 것도 PASS 도장 없음.
- **계층 ②** (13-falsifier): hardware 벤치로 직접 닫히지 않음. F-USE-3/4 만 v1.1.0 composite simulator 로 testable (pool/cloud sizing per @D d7 후 micro-exp · sim 은 .hexa only). 나머지는 음에너지원/여분차원 관측 등 out-of-repo 경로.
- **실험 falsifier (EXPERIMENTS §8.5)**: ① <9/12 PASS → 3-stack 통합 가설 폐기 · ② tri-link 상관 ρ<0.167 → cross-scale coupling 폐기 · ③ 총비용 > 576 k$ → τ=4 Pareto-optimum 폐기. (이들은 계층 ① 실험 메타-falsifier · 계층 ② 와 별개.)

---

## 4. hypotheses 요약 — P-H1~P-H6 사전등록 testable predictions

`HYPOTHESES.md §6` 의 n=6 가설 파이프라인 testable predictions (사전등록 — 사후 자가합리화 봉쇄):

| ID | 예측 (요약) | falsify 조건 |
|----|-------------|--------------|
| P-H1 | HEXA 파이프라인 가설 재현성이 무작위 LLM 가설 대비 n=6배 이상 | 재현성 비율 < 6× |
| P-H2 | 우선순위 상위 σ=12건 중 n=6건 이상이 12개월 내 1회 이상 인용 | 인용 < 6/12 |
| P-H3 | τ=4 게이트 도입 시 자기참조 비율이 단조 0으로 감소 | 자기참조 비율 비-단조 / 증가 |
| P-H4 | sopfr=5 평가축 가중치 균일화 시 사람 상관 0.84→0.70 이하 하락 | 상관 ≥ 0.70 유지 |
| P-H5 | 융합 가설(분야≥2) 비율 (σ-φ)=10% 이상 유지 시 BT 승격률 6배 | 승격률 < 6× |
| P-H6 | 반증 시도 평균 n=6 미만 가설군의 1년 폐기율 6배 높음 | 폐기율 비율 < 6× |

- 가설 카탈로그 (HYPOTHESES.md 부록): H-OURO-1 self-referential n=6 (Ouroboros closure) · NEXUS-6 130-lens scan (10/13 EXACT) 등 n=6 메타-수론 가설. 전부 **formal lattice / 메타-수론 가설** — 실 측정/설계 없음 (UFO V1 claim inventory §4 의 ⚪ 분류와 동일 계층).
- 이 가설들은 **연구-과정 가설** (가설 생성 파이프라인 자체에 대한 메타 예측) 이지 UFO 추진 물리 주장이 아니다 — Stage-4~7 13-falsifier 와 혼동 금지.
- 정직 (@D d6): n=6 산술이 가설을 "생성"하는 것은 검증 가능하나, 그 가설이 가리키는 물리는 별도 falsifier 로 닫혀야 한다.

---

## 5. cross-link

- in-tree source — `UFO/EXPERIMENTS.md` (§8 3-STACK×12 · §8.5 실험 falsifier) · `UFO/HYPOTHESES.md` (§6 P-H1~6 · n=6 가설 카탈로그)
- 13-falsifier SSOT — `UFO/verify/stage4-7-falsifier-preregister.md` (§0 표 · §5 monotone · §6 honest stance) · `UFO/verify/stage4-7-falsifier-preregister.tape` (@F ×13)
- lattice 검증 (산술만) — `UFO/verify/lattice_check.hexa` · `stages_falsifier.hexa` · `saturation_check.hexa` · `calc_{warp,wormhole,dimjump,dimuse}.hexa`
- Stage-1~3 verify (🟢 LANDED, 계층 ① substrate) — `UFO/verify/stage{1,2,3}-*.md`
- claim inventory (tier triage) — `UFO/verify/V1_claim_inventory.md` (13 falsifier = ⚪ OPEN UNPROVEN)
- cross-domain reuse — `UFO/meta/cross-domain-mega.md` (RTSC↔FUSION↔ANTIMATTER↔CERN lattice)
- alien_index chain — `UFO/HEXA-UFO.md` (🛸6→🛸ABSOLUTE · 13 falsifier 전부 OPEN ⇒ 🛸6 위 구간 미증명 lock)
- sibling tape — `UFO/meta/experiments-hypotheses.tape` (@F monotone-set 노드 + @X source)
- 거버넌스 — @D d2 (불가능 선언 금지 · 미증명 사전등록) · @D d3 (stdlib SSOT · UFO/meta = manifest only) · @D d4 (single generic dispatch) · @D d9 (worktree index isolation) · @D d10 (icon·name·alias 헤더)
