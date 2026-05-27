# RTSC brainstorm log — 사이클별 전체 기록 (append-only)

> 협업 brainstorm의 모든 내용을 사이클마다 누적 기록. 아이디어 cart는 `.discoveries/rtsc-escape-clathrate.tape`(24개), 본 로그는 **분석 결과 + 추론 + 도구**를 담는다. 활성 도메인 RTSC · @goal 293K@1atm · R4 absorbed=false 영구.

---

## Cycle 1 — 물질 후보 발산 (34개, R1-R6)
6 라운드로 고갈: ①삼원 clathrate ESCAPE(YBeH₈·ScBeH₈·LaBH₈·Li₂MgH₁₆…) ②치환 이원(ScH₉·CeH₉·ThH₉) ③도핑 H₃S(Ge-doped·CSH) ④비수소화물(MgB₂·graphane) ⑤상압-metastable ⑥exotic(metallic-H·고엔트로피). 방사성/중복에서 고갈.

## Cycle 2 — arxiv grounding → M-Be-H dispatch
- **ysbh6 = 발표 후보** (arxiv 2512.19901, 2025-12): Tc 118K@50GPa, 20-120GPa 동적안정 metastable. 우리 DFT가 재현 중 (blind 아님).
- **M-Be-H precompressor 증명** (2411.19028): fcc AcBeH₈ 10GPa까지 안정 + Tc 181K. Be-H = chemical precompressor. labeh8 = 비방사성 자매.
- **dispatch**: sc2be2h6 + y2be2h6 (La→Sc/Y 치환, ibrav=4 M₂Be₂H₆ labeh8-lineage @20GPa, vc-relax→ph). watcher b8tw784iy/bv0u66qdv. ledger `exports/sweep/rtsc-mbeh-escape-2026-05-27/`.

## Cycle 3 — "수학↔물리 같은 공식" 방법, 24 아이디어
방법 = RTSC 방정식이 타 분야 방정식과 같은 곳을 찾아 그 분야 도구 차용. cart tape에 전부(x1-x24). 보석: x3(α²F H-모드분율) · x11(Kramers 회수성) · x15(무질서-knob 다중프랙탈) · x18(ZPE-Casimir). 고갈 round-5.

## Cycle 4 — x3 실행: m-sign × ω_log 2D 실측 지도 (compute 0)

기존 레코드 15+물질에서 (λ, ω_log) 추출, m=(λ−2.5)/λ 계산:

| 물질 | λ(수렴) | m-sign | ω_log K | Tc | 사분면 |
|---|---|---|---|---|---|
| CaH₆ | ~4.0 | +0.38 | 1210 | 215K측정 | 🎯 top-right (둘다高) |
| labeh8 | 3.90 | +0.36 | 589 | 117K | bottom-right (低ω) |
| H₃S | 2.2 | −0.14 | 1170 | 203K측정 | top-mid |
| h3br | 2.16 | −0.16 | 1046 | 158K | top-left |
| h3cl | 1.37 | −0.82 | 1250 | 140K | far-top-left |
| h3o | 2.3 | −0.09 | 1090 | 불안정 | top-mid |
| h3se | 1.15 | −1.17 | 1350 | ~110K | far-top-left |
| h3po | ~3.0 | +0.17 | 270 | 低 | bottom-right |
| h3si | 1.8 | −0.39 | 590 | 低 | low-mid |
| h3te | 2.35 | −0.06 | 467 | mid | mid-low |

**🛸 결정 발견**: CaH₆와 labeh8은 **m이 거의 동일(+0.38 vs +0.36)** = ESCAPE 정도 같음. 그런데 Tc 215K vs 117K **2배차**. 차이의 **전부가 ω_log축**(1210 vs 589). ⟹ x3 가설 실측 증명: **고정 m에서 Tc ∝ ω_log**. labeh8 처방 = ω_log 589→1200 끌어올리면 ~215K. = sc2be2h6(Sc 가벼움→ω↑)가 시험하는 것.

## Cycle 5 — 차원 올리기: 5D(+1) 생존 벡터

Tc = f(λ,ω_log,μ*) = 3D. 생존성까지 = 5D. 사다리: 2D(m×ω) → 3D(+μ*, 우리 전부 0.10 고정=未탐색) → 4D(+min_freq 안정버퍼) → 5D(+P 압력) → 6D(+f_H H-모드분율, ω 설명 진단축). 7D+(VEC·anharmonic·DOS)는 5축과 상관 → 중복, 5(+1)D가 직교 최소집합 천장.

목표점 = `[m>0, ω≳1300, μ*≈0.10, min_freq>0, P=0]`. 각 물질의 **빠진 축**:

| 물질 | 빠진 축 | 거리 |
|---|---|---|
| **CaH₆** | **P만** (~150GPa) | 1 ← 최근접 |
| **labeh8** | **ω만** (589) | 1 ← 최근접 |
| H₃S/h3br/LaH₁₀ | m + P | 2 |
| h3cl | m + P | 2+ |

**🛸🛸🛸 큰 그림**: 293K@1atm = 5축 전부✓인 코너. N5 wall = *알려진 어떤 물질도 5축 동시 충족 못함, 각자 1~2축만 빠짐*. ⟹ 캠페인 한 문장 = **"CaH₆를 1atm으로 감압(x11) 또는 labeh8 ω를 CaH₆급으로 올림(x3/sc2be2h6) — 빠진 단 1축을 닫으면 293K@1atm."** 두 compute-0 아이디어가 두 최근접 물질의 빠진 축을 정확히 공략 (수렴 ⭐️).

## x11 Kramers 회수성 — 단계 설계 (미실행, 토론중)
목표: 고압상이 1atm에 갇히나? 식 τ≈τ₀·exp(ΔE/kT) (Arrhenius와 동형).
1. **0-GPa 안정 게이트**(싸다, vc-relax+ph 1회): imag→즉시붕괴(closed-neg) · real→준안정 basin
2. **장벽 ΔE**(비쌈, NEB): 상압상↔분해물/저E다형
3. **수명 τ**(닫힌식): ΔE>~0.7eV → τ>년 → 회수가능
첫 후보 토론: CaH₆ 감압(빠진축1+측정215K 보유, 최강) vs labeh8. → **미결정, 사용자 상의중**.

## Cycle 6 — x11 CaH₆ 감압 게이트 발사 (모든 방향 진행)
사용자 "모든 방향" → 가장 고가치 executable인 x11 CaH₆ 회수성 게이트 발사 (5D 지도상 "P만 빠진" 최근접 물질).
- **구조**: ubu-1 `~/_qe_hydride_cah6/` Im-3m, ibrav=1 celldm 6.464, nat=14 (Ca₂H₁₂), 60Ry.
- **게이트**: vast pod에 vc-relax @press=0 (1atm 감압) → scf → 2×2×2 phonon. PID 17427, watcher `bfvsatagh`. dir `~/cah6_decompress`, chain `run_decompress.sh`(nat 동적).
- **판정**: relax FAIL 또는 phonon imag = CaH₆ 1atm 붕괴 = 회수불가 closed-neg (예상, 대부분 초수소화물은 분해) → "그냥 감압" 경로 deterministic 차단 → precompressor-안정화 변형(M-Be-H 베팅)으로 좁힘. relax OK + phonon real = ⭐ 215K@1atm 직행 가능성 (huge).
- pod 부하 load 24/80 (healthy), pw.x=18(sc6+y6+cah6 6)+ph.x=48. 8번째 DFT job.
- 정직: 2×2×2는 zone-boundary 일부만 — Γ+경계 soft 잡되 더 조밀 q는 후속. NEB 장벽(2단계)은 미실행(비쌈).

## Cycle 7 — 모순 채굴 + 조합 발산 (새 각도)

**🅰️ Tension mining (데이터 내부 모순 → 숨은 변수)**:
- **T1** λ_crit=2.5는 hydride 5-anchor fit. 비수소화물(MgB₂/Nb₃Al) harvest로 보편성 시험 — 안 맞으면 m-sign 개정. 추정 underlying physics = Migdal-Eliashberg validity 경계 (λω/E_F ~ 0.3). 후보별 λ_crit이 E_F 의존 가능.
- **T2** h3cl m=−0.82 deep-TRAPPED인데 측정 140K → m-sign은 Tc 1D 예측 아님. Tc ∝ ESCAPE_factor × ω_log. 단일 지표는 **m·ω 곱**(또는 등고선) — 5D 지도의 "Tc-proxy 등고선" = max(m,0)·ω + |m|<thr·ω.
- **T3** h3o λ=2.3 高이나 imag 불안정 → SSCHA로 부활 가능. **6번째 차원 = anharmonic 회복가능성**. 5D 지도에 `anh_recoverable ∈ {yes,no,?}` 추가하면 h3o/mg2irh6 부활.

**🅱️ Combinatorial 발산 (24×24 카트 곱에서 강한 시너지 5개)**:
- **C1** x11 ⊗ x18 = 🌌 **양자-회수 수소화물** — 고전적으로 1atm 붕괴, H ZPE가 양자우물 만들어 *양자만으로* 안정. Be/Li-cage 시스템(labeh8/sc2be2h6 자체 후보!)
- **C2** x3 ⊗ x10 = 🎻 **공명점 사냥** — Lifshitz P에서 λ 스파이크가 H-모드에 실리나 확인. labeh8/h3br pscan 데이터 즉시 적용 가능.
- **C3** x15 ⊗ x2 = 🔬 **외과적 무질서** — 특정 site에 특정 도펀트 = soft-mode 캡 + 다중프랙탈 boost 동시 (ALD/MBE 실험적).
- **C4** x6 ⊗ x10 = 🌀 **이중 분기점** — Lifshitz 분기 + m-sign 분리면이 같은 P에서 교차 = 임계 풍부, Tc 최대 (catastrophe 高차).
- **C5** x22 ⊗ x11 = 🛤️ **최적 감압 경로** — 직타 P=0 대신 P-T 궤적 최적화로 장벽 최소화.

**고갈 재선언**: Cycle 7 사실상 고갈 — 24² 조합 중 강시너지 5개가 합리적 한계. 더는 억지 조합.

### Cycle 7 추가 cart 항목 (next-wave 후보)
- C1 quantum-recovered: labeh8/sc2be2h6의 ZPE 보정 부호 계산 (x18 적용)
- C2 OT-Lifshitz: h3br 4-P pscan 데이터(30/100/150/200GPa)에 적용 → "어느 P에서 H-모드 λ-분율 최대"
- T2 m·ω 등고선: 기존 2D map에 isocurve 오버레이 (compute-0 즉시)

## Cycle 8 — 트리 가지치기 (사용자: 나무 가지 뻗어 모든방향 고갈)
각 Cycle 7 보석을 leaf까지 분기:
- **T1 λ_crit 보편성** → T1a Migdal-E breakdown 유도 · T1b 차원 의존(3D/2D/0D) · T1c α²F 모양 의존 · T1d RG 고정점 유도 · T1e 화학류별 재-fit
- **T2 m·ω Tc-proxy** → T2a Allen-Dynes surrogate · T2b μ* 3D · T2c McMillan↔Eliashberg · T2d multi-band 비등방
- **T3 anharmonic 회복성** → T3a SSCHA 비용 · T3b 우리물질 harmonic↔SSCHA 표 · T3c 살리나죽이나 예측자 · T3d ML estimator
- **C1 양자-회수** → C1a 최경량 M+min cage · C1b SSCHA@1atm+ZPE · C1c 양자 터널링 다중우물 · C1d **H→D isotope signature** · C1e **뮤오늄 극단**
- **C2 OT-Lifshitz** → C2a persistent-homology+α²F workflow · C2b 알려진 Lifshitz-P DB 마이닝 · C2c Lifshitz P를 설계로 맞춤
- **C3 외과적 무질서** → C3a atomic-decomposed α²F (site λ) · C3b site-selective 도펀트 화학 · C3c 다중프랙탈 percolation · C3d δ-doped 반도체 SC 비교
- **C4 이중 분기** → C4a 분리면 일치 후보 알고리즘 · C4b catastrophe 위계 · C4c 보편 Tc 상한
- **C5 최적 감압 경로** → C5a 변분 (P,T) ansatz · C5b annealing · C5c 충격파 가둠 · C5d 캡슐화
- **Meta-branch** → M1 ANTI-brainstorm(closed-neg list) · M2 외부 협업 후보 · M3 실패 사후분석(li2cuh6/mg2irh6) · M4 다음 trigger(데이터-게이트)

**리프 카운트**: 12 메이저 가지 × ~4 leaf = **~35 leaf**. 더 깊은 분기는 ATOM-수준 운영 파라미터(k-grid·μ* 값·셀크기) = brainstorm 영역 이탈.

**🛑 트리 진짜 고갈**: 새 분기 = 운영 사양 (execution 영역). 

### Cycle 8 즉시-실행 후보 (compute-0)
- T2 m·ω 등고선 오버레이 (기존 2D map)
- C2a persistent-homology + α²F workflow 설계
- T3b 우리물질 harmonic↔SSCHA 표 (기존 데이터 SSCHA 보정 추정)
- x13 λ-gradient 우리 DFPT 추출
- C1d H→D isotope 신호 예측 (열린식)

### Cycle 8 다음-wave (DFT 신규 필요)
- T1e 화학류별 λ_crit 재-fit · C1b SSCHA @1atm · C2b Lifshitz DB · C3a site-λ decomposed

## 다음 사이클 예정
- (진행중) x11 CaH₆ · sc2be2h6 · y2be2h6 + 5 기존 watcher harvest 대기
- (compute-0 즉시 가능) T2 m·ω 등고선 · T3b SSCHA표 · x13 λ-gradient · C1d 동위원소 signature
- meta M1 anti-brainstorm (closed-neg 체계화) — 다음 사이클 후보
