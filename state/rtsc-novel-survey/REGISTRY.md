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
