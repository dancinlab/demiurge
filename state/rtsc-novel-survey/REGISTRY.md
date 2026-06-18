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
