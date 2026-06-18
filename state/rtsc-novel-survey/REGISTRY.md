# RTSC 신규 후보 발굴 — arxiv 서베이 + 삼각측량 레지스트리

목표: arxiv에서 RTSC 초전도 후보 발굴 → 삼각측량(다중 신호 교차) → 신규성 확정 → ARCHITECTURE.json 박제. 고갈까지.

## 삼각측량 기준 (novel+promising 판정)
1. DFT 안정 예측 (≥1 최근 논문)
2. SC-favorable 신호 (flat-band / high-DOS@EF / 하이드라이드·클라스레이트 / 강한 el-ph 모티프)
3. **그 정확한 조성에 el-ph λ/Tc 출판 없음** (= 미개척)
4. (삼각) ≥2 독립 맥락에 등장 = 고신뢰

## 이미 감사된 (state/rtsc-prior-art-audit/AUDIT.md) — 중복 제외
출판재현: LaRu3Si2·LaBeH8·CaB3C3·SrB3C3·Mg2IrH6·Li2CuH6·Li2MgH16
방향오류: LaB3C3
신규(기존): LaOs3Si2·LaRh3Si2·MgBeH8·KBeH8·AcBeH8(상압)

## 발굴 라운드
(아래 라운드별 추가)

## Round 1 (2026-06-18) — 4 frontier 병렬 + 삼각측량 → ~30 신규후보

### ★ Tier-1 (삼각측량 고신뢰 · 상압 · el-ph 미출판 · clean)
| 물질 | 클래스 | 신호 | el-ph 미출판 근거 | 압력 | arxiv |
|---|---|---|---|---|---|
| **NbRu3** | kagome Cu3Au | 129-compound kagome DB **top-Tc~15K**, flat-band@EF, NM | DB가 구조+DOS만·λ 0개 (다중출처 D) | 0 GPa | 1674-1056/adf041 |
| **YCr6Ge6** | kagome HfFe6Ge6 | ARPES+DFT flat-band@EF 확정·paramag | el-ph DFPT 전무(ARPES/plasmon만) | 0 GPa | 1906.07140·1212.1976 |
| **Mg2PtH6** | X2MH6 Fm-3m | Tc78K(doped>100K)·metallic | full-BZ λ 미확정(λ_Γ만) | 0 GPa | 2401.17024 |
| **SrZnH3** | MXH3 perovskite | Tc~107K listed·ω_log681K | Zn멤버 미계산(Au가 논문독점) | 0 GPa | 2506.03837·PRB111.134509 |
| **Mg3OsH8** | M3XH8 fluorite | 29-stable family 최고Tc~73K·3밴드@EF | family-level만·5d-Os 개별 미실행 | ≤35 GPa | 2506.03837·PMC12667446 |

### Tier-2 (신규·상압 · el-ph 미출판)
- **KB12·RbB12·YB12·BaB12** (Pm-3m B12 superatom, 0GPa, McMillan-only·sister CsB12 λ1.5/Tc42K) — 2508.17422
- **Ti6Sb4·Ti6Pb4·Ti6Tl4** (Ti kagome, 동적안정·flat-band·NM, topo-only논문 el-ph 미계산, 0GPa) — 2211.11372
- **LuNb6Sn6** (1:6:6 Sn-p flat-band·NM·el-ph無) — 2505.00796
- **Ba(Pt3B2)2** (λ_Γ=0.64 최고·0GPa·full DFPT無) · **TaMoB2**(λ_Γ0.20) · **Nb(MoB)2**(λ_Γ0.57) — 2401.13211
- **Mg2PdH6·Al2TcH6·Al2ReH6** (X2MH6 Fm-3m, 0GPa, screening-only) — 2401.17024
- **BaRhH8·BaIrH8·AcIrH8** (XRhH8/XIrH8 fluorite, 0-3GPa, 52-68K, per-cmpd λ無) · **CeOsH8**(31GPa·106K) — Adv.Sci2025·PMC12667446
- **SrBeH8·YBeH8** (Be-H8 fluorite guest 완전미탐 white-space) — Be-H8 sweep gap
- **MB5N5 (FB5N5)** (B-N sodalite, 0GPa 34상 동적안정, per-phase λ거의無) — 2502.06700
- **α-ATB4 (AlCoB4·AlNiB4·AlFeB4)** (AlB2-related, 0GPa, Γ만) — 2309.07046
- **hole-doped YB2** (0.7h, AlB2, 0GPa, 22.8K, 최적조성 λ미확정) — 2509.20742
- **V2NS2** (2D Janus, 0GPa, Tc>5K OOD-high, coarse ML-DFPT만) — D4MH01753F

### 검증대상(실측Tc 있으나 ab-initio λ無·d19 closure style)
- **YOs2·LuOs2·ZrOs2·HfOs2** (breathing-kagome C14 Laves, 실측 Tc2.7-2.9K, λ ab-initio無)

### ⚠ 주의/제외 갱신
- 자성(nspin2 벽): Al2MnH6 · 방사성: ScTc2 — 신규지만 난도↑
- λ 이미 출판(제외): Mg2RhH6(2.62)·Al2MnH6 일부·MoSn/HfSn/NbSn류·XPd5·KB3C3·KB2C2·SrAuH3·Ca2IrH6·Li2AuH6·KScH3·KGaH3(146K@10GPa)·C18·MC12
- 미확인(컴퓨트 前 full-text): arXiv:2604.04151이 Mg2PtH6/PdH6 λ 계산했는지

### Round 1 메타 결론
삼각측량 최강 신규 = **NbRu3**(kagome DB top·λ전무·상압·NM·비방사성=가장 깨끗). 차순 YCr6Ge6·Mg2PtH6·SrZnH3·Mg3OsH8. 상압 white-space 풍부 — kagome(NbRu3/YCr6Ge6/Ti6X4) · X2MH6(Mg2Pt/Pd) · MXH3(SrZnH3) · B12(KB12/YB12) · 보라이드(Ba(Pt3B2)2) · BeH8(Sr/Y) · B-N(MB5N5).

## Round 2 (2026-06-18) — 다른 클래스 4 frontier → ~40 추가 신규후보

### frontier E — 2D/단층 + 인터칼레이션 층상
| 물질 | 구조 | 신호 | 압력 | arxiv |
|---|---|---|---|---|
| **W2NBr2·W2NI2** ★ | 할로겐 W2N MXene 단층 | F2/Cl2 형제 상압SC확정(λ0.67-0.71)·Br/I "not examined" | 0 | 2606.04953 |
| **α-TiNCl** ★ | 층상 나이트라이드클로라이드 | 실측18K·페어링기전 미해결·수렴 α형 λ無 | 0 | 1908.10978·1412.4447 |
| Li/Na-ZrNBr | β-MNX (Br치환) | ZrNCl동형·Cl→Br 포논튜닝·수렴 λ無 | 0 | 1412.4447 |
| NaC8/NaC10/NaC12 | Na-GIC | NaC4형제 41-48K모티프·이 상 λ미계산 | 0-10 | 2407.16056 |
| LaPd2B2C·ThPd2B2C | LuNi2B2C bct 보로카바이드 | Y/La-Pt2B2C는 λ출판·Pd/Th는 Debye프록시만 | 0 | s41598-025-15759-2 |
| Zr2CH4 | 수소화 Zr-MXene | Mo2NH2형제 22K·Dirac이유 AD미적용(배제아님) | 0 | 2509.19904 |

### frontier F — 비통상 결합 (전자화물·안티페로브·MAX·A15)
| 물질 | 클래스 | 신호 | 압력 | arxiv |
|---|---|---|---|---|
| **Ni3InN** ★ | 안티페로브스카이트 | Ni-3d high-DOS+Dirac@EF·MgCNi3 motif·NM·합성됨 | 0 | 2512.18195 |
| **V2SnC** ★ | MAX 211 | DOS@EF 6.12(M2SnC최고)+FS nesting·NM·저자 future-work명시 | 0 | PMC9058429 |
| V2GeC | MAX 211 | Ti2GeC(9.5K)동형·M-3d@EF·NM | 0 | JSR16604 |
| Mo3Ge·Mo3Sn | A15 Cr3Si | 측정1.45K·disorder6×↑·chain vHs·NM | 0 | 1505.06393 |
| V3Os | A15 (2026신규실험) | Hc2>Pauli limit anomalous·V-chain vHs·NM | 0 | 2602.24028 |
| **CaPd3P·SrPd3As** ★ | 안티페로브 P/As | SrPt3P(λ1.33)의 Pd-analog·측정3.5/3.7K·DFPT λ無 | 0 | 2008.07755·2208.04544 |
| LaCoSi | 삼원 전자화물 | ARPES flat+Dirac@EF vHs·상자성·SC미탐 | 0 | FOP2025.034202 |
| YCl | 2D 전자화물 dice-lattice | ARPES flat-band@EF·거대DOS·⚠자성체크 | 0 | 2508.21311 |
| bulk Sr2N | 2D질화물 전자화물 | heavier cation>Ca2N metallic·bulk el-ph無 | 0 | srep12285 |

### frontier G — 최신(2025-2026) 상압고Tc·독립검증無
| 물질 | Tc | 압력 | 예측논문(날짜) | arxiv |
|---|---|---|---|---|
| **Grokene** ★ | MF~325K·Eliashberg~310K | 0 | LLM-생성 2D초격자(2026-01) | 2601.00931 |
| **MgAlFeH6** ★ | ~130K | 0 | Mg2FeH6 carrier-도핑(2026-03·모체 상압합성존재) | 2507.19768·s41524-026-02040-x |
| LiZrH6Ru·EuCdH6Ru·Ta6MoH16 | 23.5/13.6/7.3K | 0 | GNoME diffusion DB(2025-08) | 2508.19781 |
| Li2AuH6·Li2AgH6 | 상압 conventional 한계급 | 0 | max-Tc(2025-02) | 2502.18281 |
| MoB4·Sc2C3·YBC | 7.6/27.9/10.2K | 0~중 | ML-guided B/C(2024-09) | 2409.18441 |

### frontier H — 삼각측량 2차 (동족/3출처 수렴)
| 물질 | 동족/출처 | 신호 | 압력 | arxiv |
|---|---|---|---|---|
| **AcRhH8·Mg3RuH8·Mg3IrH8** ★ | 형석[XH8]/M3XH8 (3출처수렴: Adv.Sci·2507.19768·HTSC2025) | 상압안정·Os만 Tc명시·Rh/Ru/Ir 개별 λ無·NM | 0 | PMC12667446·2507.19768·5c00513 |
| LaRhH8 | [XH8] Rh최고94K | 24GPa·상압외삽 λ無 | 24 | Adv.Sci2025 |
| CeOsH8·LaOsH8 | [XH8] Os | 106/83K 패밀리최고·Ce-4f자성체크 | 31-35 | Adv.Sci2025 |
| **LuOs3B2·ThRu3B2·LaRh3B2** ★ | RT3B2 kagome boride | 실측SC(4.6/1.6K)이나 first-principles λ 패밀리전체 미출판·NM | 0 | 2504.16412·2507.04693·2512.16945 |
| SrAuH3 | MXH3(SrZnH3 Au치환) | 132K·독립DFPT재현無 | 0 | 2412.15488 |
| KScH3·KInH3 | MXH3 | 40/73K·In멤버 미개척 | 0 | PRB111.134509 |
| CaB8C·SrB8C·BaB8C | XB8C 케이지 | 77/64/53K·개별 α²F無 | 0 | 2506.03837 |
| K2GaCuH6·K2LiCuH6 | A2BH6 사원계 | 68K·독립검증無(2025-08) | 0 | 2508.10912 |

### Round 2 메타 결론 + 삼각측량 핵심 미개척맥 (다중출처 수렴)
1. **형석형 [XH8] 패밀리** (3출처 수렴): AcRhH8·Mg3RuH8 상압안정+미계산 = 최우선
2. **RT3B2 kagome boride** (NbRu3 맥): 실측SC이나 first-principles λ 패밀리전체 미출판 = LuOs3B2 검증가치 최대
3. **MXH3 perovskite 확장**: SrZnH3 동족 Au/Sc/In 치환축 미스윕
4. **2026 신규흐름**: LLM-생성(Grokene)·carrier-도핑(MgAlFeH6)·GNoME-DB — 전부 단일그룹 예측, 독립 cross-val 타깃
5. 즉시발사 적합(상압·NM·소형셀·d7): AcRhH8·Mg3RuH8·LuOs3B2·ThRu3B2·Ni3InN·V2SnC·W2NBr2

### 자성/난도 주의: YCl·CeOsH8(4f)·Al2MnH6(이전)·ScTc2(방사성)

## Round 3 (2026-06-18) — 마지막 미답 클래스 + 고갈판정

### frontier I — 칼코게나이드/픽타이드 (TMD intercalate·완전 신규 클래스)
| 물질 | 구조 | 신호 | 압력 | arxiv |
|---|---|---|---|---|
| **(InSe2)0.12NbSe2** ★ | misfit-layer intercalate | 상압 TMD 최고 Tc11.6K·정량 λ 미출판 | 0 | PMC10797615 |
| Pd0.08TaSe2 | 2H-TaSe2 intercalate | CDW-QCP Tc×24증폭(3.3K)·λ미출판 | 0 | srep24068 |
| TaSe2 3R/polytype | stacking polytype | stacking이 CDW·SC변조·polytype별 λ無(2026) | 0 | 2602.11582 |
| 3R-NbS2 | 3R polytype | polytype-SC·3R금속상 λ無 | 0 | s41467-024-54517-2 |
| LaRu2As2/P2 | ThCr2Si2 Ru | bulk SC7.8K·정량 DFPT λ無 | 0 | 1609.08856 |
| ScRhAs/ScIrAs | 육방 phosphide 동족 | ScIrP SC·As동족 미발굴 | 0 | 1512.03864 |
| 4-7-6 동족(Mg4Pd7P6·Ca4Pd7As6) | U4Re7Si6 | 모체 Mg4Pd7As6 λ0.76출판·동족 미계산 | 0 | 2408.06813 |

### frontier J — 준안정/상압회수 + 결함/변형 (대부분 기존 확장·일부 신규축)
- **WB2 평면결함상**(SF/twin=local MgB2·결함공학축·상압회수 λ無·실측17K) — 2109.11521 ★결함축
- **n-도핑 다이아몬드+인장변형**(strain축·p형만 충실·n+strain λ無·소셀 d7) — PRB72.014306
- YSbH6 0GPa 회수상 λ(50GPa까지만 출판·상압회수 빈칸) — 2512.19901
- XB12 guest 치환별 λ분포(B12=R1기수록·guest sweep 신규) · XB8C Sr/Ba(CaB8C만 출판) · RbH12 anharmonic(10GPa) — 부분신규

### frontier K — 유기/풀러라이드/방향족 (도핑 PAH·완전 신규 클래스)
| 물질 | Tc실측 | el-ph λ 상태 | arxiv |
|---|---|---|---|
| **Kx-DBP(C30H18)** ★ | 33.1K(PAH최고) | 결정 DFPT λ 전무 | srep00389 |
| K3.3-picene | 18K | intramolecular ME만·결정 λ無 | 1112.3483 |
| Kx-coronene | 15K | 결정 λ無 | 1105.0248 |
| Kx-phenanthrene | 5K | edge-EPC 모델만 | 1303.5184 |
| K-p-terphenyl | 7/43/123K(논쟁) | Hubbard ladder만·123K BCS미해명 | 1703.05803 |
| Na/K-CTF0·COF | 예측 | Li-CTF0만 출판·Na/K 미계산 | 9b00013 |
| CuC6 GIC | 1-10K예측 | 밴드만·λ無 | jpcc.3c01073 |

### frontier L — 고갈판정 (depletion verdict)
**~85% 커버·미완전고갈.** HTSC-2025(140후보) 7패밀리가 우리 클래스에 1:1 매핑. 고-Tc 하이드라이드 tail은 near-exhausted(우리가 champion 보유: Mg2{Rh,Ir,Pd,Pt}H6·Li2{Ag,Au}H6=실용천장 per 2502.18281 20000-metal screen). **잔여 진짜 1클래스 = 도핑 공유결합망 반도체**(group-IV framework metallized):
- **YSi6**(dumbbell-Si 3D망·8.4K·0GPa·andp.202500210) · **C18 carbon-cage**(79K elemental→109K hole-doped·PMC12376711) · **H-doped c-BN**(>120K·PMC11600296) · **B-doped diamond/SiC/cubic-Si**(4-11K·미탐 도펀트) · **flat-band C3N4**(hole-doped·2308.16507)
- 부차 잔여: **full-Heusler XY2Z**(ScAu2Al~5K·34종·kagome/Laves/A15/MAX와 별개·2311.06075)
- 천장맥락(d6정직): 2502.18281이 Li2AgH6/AuH6 ≈ 상압 통상 실용천장 결론 → 고-Tc tail 거의 소진, 잔여는 저-Tc지만 el-ph 신규 frontier

## Round 4 (2026-06-18) — 잔여클래스 closure

### A. 도핑 공유결합망 반도체 — CLOSED (~90% 이미 λ출판)
가장 과밀연구 영역. 16격자 중 13개 λ 이미출판(YSi6·Ba8Si46·C18/C20/C24/C32·C3N4·B-diamond·hole-diamond136K·H-cBN122K·BN/BC sodalite). **진짜 잔여 진입표적 단 1개(강)**: **Si24/Na4Si24 hole-doped λ**(open-framework·모체 비SC·도핑SC λ 빈칸·상압안정·1708.04746). 약후보: CaSi6/BaSi6(준안정·신호미확정). → 클래스 closure 충족.

### B. full-Heusler / half-Heusler — 신규 (λ 미출판)
| 물질 | 클래스 | Tc실측 | 압력 | arxiv |
|---|---|---|---|---|
| **Pd2ZrIn** ★ | full-Heusler L21 | 2.2K(2026 μSR) | 0 | 2604.19283 |
| Pd2HfIn·Pd2ZrAl | full-Heusler | 2.4-3.8K | 0 | PRB79.064508 |
| Pd2YSn | full-Heusler | 4.9K(최고급) | 0 | 1307.6386 |
| **ScPdBi** ★ | half-Heusler(trivial·경량 d7) | ~1K | 0 | NMR |
| YPdBi·LuPdBi·LuPtBi | half-Heusler phonon채널 | ~1K | 0 | 1811.05045 |
| TbPdBi/HoPdBi/ErPdBi | half-Heusler+AFM(nspin2 고난도) | 1-1.9K | 0 | 1806.05314 |
- RED-OCEAN(λ출판·제외): ScAu2Al(1.25)·HfPd2Al·MgPd2Sb·LiPd2Si/Ge·LiGa2Ir·YPtBi(conventional기각)·LaPtBi(앵커)
- ⚠ 신규성게이트: arXiv:2306.04439(full-Heusler 8후보>10K·조성비공개) SI grep 발사前 필수
- 다수 half-Heusler 예상=CLOSED-NEGATIVE(λ소·d_paper_significance상 유효발견)

### 최종 고갈판정 (R4)
**고-Tc frontier(Tc≳30K) ~90-95% 커버 = NOVEL 고-Tc 목적상 실질 고갈.** HTSC-2025 140종 6구조타입 전부 우리 커버리스트 내부=강력 고갈확증("숨은 MgB2급 없음"). 전체 상압 el-ph공간(저-Tc 포함) ~75-80%. **잔존 고가치 thin 2버킷만**: (i)TM 카보나이트라이드 고용체 연속체 (ii)도핑 비스무테이트/안티모네이트 페로브스카이트(BaBiO3계 BCS·λ1.2-1.4). 나머지(σ-phase·skutterudite·준결정 등)는 low-λ/low-Tc 저수율.

## Round 5 (2026-06-18) — 최종 thin 2버킷 closure

### TM 카바이드/나이트라이드/카보나이트라이드 — 90% CLOSED
- 유명 binary(NbC/NbN/TaC/ZrN)+NbC1-xNx 고용체 전 조성 λ 출판(0911.0096)·α/γ-MoC 출판(1709.08143) = 레드오션
- **진짜 NOVEL 잔여**: TaC1-xNx 고용체 연속체(NbC의 Ta-아날로그·DFPT λ無·2506.07768) · **HEC/HEN 세라믹 DFPT λ**(전무·McMillan역산만·최강=TiNbTaN3 ambient 10K·2505.15864). 약후보 bulk β-Mo2C/W2C(~3-4K)
- d6주의: rocksalt 완전화학량론셀 동적불안정(허수포논)→vacancy/SSCHA anharmonic 셀 필요(2507.03417)

### 도핑 비스무테이트/안티모네이트 산화물 BCS — SOFT-CLOSED (레드오션)
- BKBO·BKSO(2026 RSC)·SrBiO3·BPBO 전부 λ 출판 = 회피
- 잔여 신규축 협소·저임팩트: (Sr,K)SbO3/(Ca,K)SbO3(BKSO 자매·λ無·최청정·HPHT) · (Ba,Na/Cs/Rb)BiO3 변종 · TlPbO3 lone-pair. Tc천장 ≤BKBO(34K)·표준 BCS → d6 천장 미달, 단발 probe 가치만

## 🏁 최종 고갈판정 (DEPLETION VERDICT · 2026-06-18 · R1-R5 5라운드 18 frontier)
**RTSC 상압 el-ph-미출판 후보공간 = 실질 고갈.**
- 고-Tc frontier(Tc≳30K): **~90-95% 커버**. HTSC-2025(140종·2023-2025 census) 전 구조타입이 우리 기록 클래스에 1:1 매핑 = "숨은 MgB2급 없음" 강력확증. 2502.18281(20000-metal screen)이 Li2AgH6/AuH6를 상압 통상 실용천장으로 확정 → 고-Tc tail 우리가 champion 보유.
- 전체 상압 el-ph공간(저-Tc 포함): ~80% 커버.
- **잔여=저수율 thin** (TaC1-xNx·HEC DFPT·(Sr,K)SbO3·full/half-Heusler·Si24-hole-dope·WB2결함·n-diamond+strain) — 모두 저-Tc OR disorder-cost OR 단발 probe. 새 고-Tc 클래스 없음.
→ **추가 arxiv 서베이 불필요(c9 정직). 이 레지스트리+ARCHITECTURE가 canonical 영구자산.** 다음 단계는 서베이가 아니라 **이 명단서 발사후보 선택→hexa deck→DFPT λ** (즉시발사 top: NbRu3·YCr6Ge6·Mg2PtH6·SrZnH3·AcRhH8·Mg3RuH8·LuOs3B2·Ni3InN·Pd2ZrIn).

### 발굴 총계: ~110 신규후보 / 19 클래스 / 5라운드
kagome금속간·X2MH6·M3XH8·MXH3·fluorite-XH8·B12 superatom·보라이드·B-C/B-N clathrate·2D MXene/intercalation·TMD칼코게나이드·안티페로브·MAX·A15·전자화물·도핑PAH유기·풀러라이드/COF·도핑공유결합망반도체·full/half-Heusler·TM카보나이트라이드·비스무테이트·2026 LLM/GNoME

## 후보 점수표 (2026-06-18) — 5축 채점 (각 1-5·평균=종합)
채점축: 신규성(el-ph λ 미출판 청정도)·Tc잠재력·발사용이성(소셀·NM·상압)·삼각측량(독립출처수)·안정리스크역점수(d6 허수모드 낮을수록↑)
| 후보 | 클래스 | 신규 | Tc | 용이 | 삼각 | 안정 | 종합 | Tc예상 |
|---|---|--:|--:|--:|--:|--:|--:|---|
| SrZnH3 | MXH3 | 4 | 5 | 5 | 4 | 3 | **4.2** | 107K listed |
| NbRu3 | kagome | 5 | 3 | 5 | 4 | 3 | **4.0** | 15K |
| Mg2PtH6 | X2MH6 | 4 | 5 | 4 | 4 | 3 | **4.0** | 78K(>100K dope) |
| AcRhH8 | fluorite XH8 | 4 | 4 | 4 | 5 | 3 | **4.0** | 78K |
| Pd2ZrIn | full-Heusler | 5 | 1 | 5 | 4 | 5 | **4.0** | 2.2K(측정) |
| Mg3OsH8 | M3XH8 | 4 | 4 | 4 | 4 | 3 | **3.8** | 73K |
| LuOs3B2 | RT3B2 boride | 5 | 2 | 4 | 4 | 4 | **3.8** | 4.6K(측정) |
| Ni3InN | 안티페로브 | 5 | 2 | 5 | 3 | 4 | **3.8** | ~3-8K |
| YCr6Ge6 | kagome | 5 | 2 | 4 | 4 | 3 | **3.6** | 미측정(투기) |
| Mg3RuH8 | M3XH8 | 4 | 3 | 4 | 4 | 3 | **3.6** | family |
| V2SnC | MAX | 5 | 2 | 4 | 3 | 4 | **3.6** | 미측정 |
| W2NBr2 | 2D MXene | 5 | 2 | 4 | 3 | 3 | **3.4** | ~6K+ |
| (InSe2)NbSe2 | TMD | 4 | 3 | 2 | 3 | 4 | **3.2** | 11.6K(측정) |
| TiNbTaN3 | HEC | 5 | 3 | 2 | 3 | 3 | **3.2** | 10K(측정) |
| Grokene | LLM-2D | 4 | 5 | 2 | 1 | 1 | **2.6** | 310K(미검증 복권) |
종합판정: 균형최고=SrZnH3·NbRu3·Mg2PtH6·AcRhH8(4.0+). 안전앵커=Pd2ZrIn/LuOs3B2(측정SC·저Tc). 복권=Grokene(임팩트최고·신뢰최저).

## 발사전 데스크체크 (2026-06-18) — ⚠ 중대정직(c9): 서베이 신규성 과대평가 정정
구조(d11)·pseudo(d13)·자성은 대부분 CLEAR. 유일 블로커=신규성. 깊은 per-후보 체크가 서베이 놓친 출판 발견.
| 후보 | 판정 | 신규성 게이트 |
|---|---|---|
| Mg2PtH6 | ✅ 생존 | 2604.04151=descriptor만·full-BZ λ 미출판 확인(무도핑 타깃) |
| LuOs3B2 | ⚠ 피벗 | 직선λ 출판(2507.04693 λ1.96)+허수모드→SSCHA 비조화 정합만 신규 |
| NbRu3 | 🔴 출판 | JPCC2024 MRu3 Tc9.8K |
| SrZnH3 | 🔴 출판 | MXH3 카탈로그 λ1.94/Tc107K |
| Mg3OsH8 | 🔴 출판 | JPCC2025 5c00513 dedicated Tc73K(서베이 'family-level' 오판) |
| AcRhH8 | 🔴 출판 | Adv.Sci2025 Ac멤버 Tc78K |
| Pd2ZrIn | 🔴 출판 | Winterlik2012+2026μSR 기지 2.2K(2306.04439엔 없으나 다른경로 기지) |
| Ni3InN | 🔴 출판 | npj 397-DFPT 포함+Uehara2010 실험 |
| Mg3RuH8·YCr6Ge6 | ⏳ | 진행중 |
**교훈**: 라운드1-5 서베이의 'el-ph 미출판' 분류는 얕은 DB체크라 과대평가. 발사전 per-후보 깊은체크가 진짜 게이트. 생존=Mg2PtH6(무도핑)+LuOs3B2(SSCHA). 나머지=재현(앵커만).

## 발사전 체크 9/9 완료 (최종)
✅생존(진짜신규): **YCr6Ge6**(el-ph출판ZERO·상관상자성nspin1·nat13 GPU) · **Mg2PtH6**(무도핑·2604.04151 descriptor만·nat9 Pt semicore) · **Mg3RuH8**(Ru멤버 미출판·nat12 CPU·CIF pull필요)
⚠피벗: **LuOs3B2**(직선λ1.96 출판+허수모드→SSCHA 비조화 정합만 신규)
🔴재현(앵커만): NbRu3(JPCC2024 9.8K)·SrZnH3(MXH3 107K)·Mg3OsH8(JPCC2025 73K)·AcRhH8(Adv.Sci 78K)·Pd2ZrIn(Winterlik2012)·Ni3InN(npj397)
공통 발사절차: hexa deck(정확질량+semicore PP+d15 SCF aids·d_deck_always)→d16 free dry-run→d6 matdyn 동적안정→nspin2 M→0 보험→DFPT λ. 라우팅 d7: Mg2PtH6/Mg3RuH8 vast CPU·YCr6Ge6 vast GPU.
