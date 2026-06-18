# RTSC 후보군 선행연구(prior-art) 전수조사 — 신규성 감사 (2026-06-18)

유저 지시 arxiv 전수조사. 4-family 병렬 리서치 에이전트(WebSearch+arxiv). 대부분 출판된 선행연구.

## 판정표

| 후보 | 판정 | 선행연구 |
|---|---|---|
| LaRu3Si2 | ✅ 출판 | arXiv:2503.22477(2025) · Tc~7K · λ≈0.8 · 진짜 CDW(soft모드=CDW) |
| LaOs3Si2 | 🆕 신규* | exact-string 0건. *arXiv:2503.20867(428 1:3:2 SC 스크리닝) supplement 미확인 |
| LaRh3Si2 | 🆕 신규* | 화합물만 known(non-mag LnRh3Si2)·el-ph/Tc 미계산. SC는 boride LaRh3B2(2.5K)로 별개. supplement caveat |
| AcBeH8 | 🟡 부분신규 | arXiv:2411.19028(2024) 10GPa·181K·λ4.50. 우리 상압0GPa/293K는 신규(고압만 출판). d6 동적안정 사활 |
| LaBeH8 | ✅ 출판 | arXiv:2106.09879=PRL128.047001(2022). 고압 191K@50GPa·실험합성 110K@80GPa. 상압 아님 |
| MgBeH8 | 🆕 신규 | 직접 선행 없음(XBeH8 일반론에 묻힐 수 있음) |
| KBeH8 | 🆕 신규 | 직접 선행 없음(유사물 KB2H8 146K@12GPa) |
| CaBeH8 | 🟡 부분 | 초고압 210GPa·254-300K만 출판 |
| SrB3C3 | ✅ 출판 | arXiv:1708.03483(2017/SciAdv2020) 실험 ~20K@40GPa |
| CaB3C3 | ✅ 출판 | PRB 109.144509(2024) 상압 ~48K 이미 예측 = 직접충돌(재현). hole-dope XYB6C6 77K |
| LaB3C3 | 🔴 방향오류 | La³⁺[B3C3]³⁻ sodalite 반도체(gap~1.3eV·balanced count). e-도핑이 페르미면 죽임. 문헌 고-Tc 경로=hole-doping(반대). CLOSED-negative 가능 |
| Li2CuH6 | ✅ 출판 | arXiv:2401.17024=MatTodayPhys42(2024) 상압 80-86K·λ≈2.30 |
| Mg2IrH6 | ✅ 출판 | arXiv:2310.07562=PRL132.166001(2024) 상압 160K. 우리=재현. 합성시도 arXiv:2406.09538(Mg2IrH5) |
| Li2MgH16 | ✅ 출판 | PRL123.097001(Sun 2019) 473K@250GPa(레퍼런스 앵커) |

## 결론
- **신규성 살아있음**: LaOs3Si2·LaRh3Si2(kagome, supplement 확인 필요) · MgBeH8·KBeH8(BeH8) · AcBeH8 상압(물질known·상압신규·d6 사활)
- **재현(신규성 없음)**: LaRu3Si2·LaBeH8·CaB3C3·Mg2IrH6·Li2CuH6·Li2MgH16
- **방향오류**: LaB3C3(e-도핑 SC 죽임)
- **미결 1건**: arXiv:2503.20867 supplement에 LaOs3Si2/LaRh3Si2 포함 여부(PDF 본문 미수신)

## 메타 결론
demiurge RTSC 캠페인의 후보 대다수가 2022-2025 출판 선행연구. 진짜 신규 기여 여지 = (a) 미스크리닝 kagome 게스트/조성 (b) 상압 안정성(d6 matdyn) 정밀화 (c) MgBeH8/KBeH8 등 미탐색 BeH8 게스트. 단순 "이 물질 고-Tc"는 prior-art 포화.

## 미결 closure (2026-06-18) — arXiv:2503.20867 supplement PDF 본문 직접 확인
PDF(23MB) 다운+pdftotext(10211줄) grep. 후보리스트 포맷 = A·B₂·C₃(C=kagome 3-site). LaRu3Si2=LaSi2Ru3.
- LaSi2Os3(=LaOs3Si2): **0건** → 3063-stable/428-SC 리스트 미포함
- LaSi2Rh3(=LaRh3Si2): **0건** → 미포함
- 리스트의 실리사이드 후보는 전부 **Ni-kagome**(SmSi2Ni3·TbSi2Ni3·DySi2Ni3) — Os/Rh/Ru kagome silicide 0개
**결론**: LaOs3Si2·LaRh3Si2 = 2503.20867 대비 신규 확정. 단 미포함 사유는 안정성 필터 탈락 추정(우리 DFT LaOs3Si2 2×2×2 동적불안정과 일치) → LaOs3Si2는 신규지만 confirmatory-negative(불안정·LaRu3Si2보다 약결합). LaRh3Si2는 미계산 상태 = 진짜 미개척 1:3:2.
