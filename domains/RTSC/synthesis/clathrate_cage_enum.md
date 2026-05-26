# Clathrate H-cage stoichiometry enumeration

> n=6/666 brainstorm real-fit milestone · clathrate hydride 의 H-cage 화학량론 열거 축.
>
> CaH₆ sodalite cage = H₂₄ 절단팔면체(truncated octahedron) coordination = J₂(6)=24.
> milestone 14 (압력 < 50 GPa AND stable AND Tc > 200K) frontier 연결축.
>
> Stamp: 2026-05-25 · CaH₆ 측정-grade LANDED (Tc 213 K vs measured 215 K · §9.12.A) 기준.
> SSOT: 수치값은 `exports/material_discovery/rtsc_cah6_dft_4x4x4q_textbook_proof_20260524.json`.

---

## ⚠ g25 caveat (먼저 박는다)

**24 = our framing vocabulary, NOT clathrate 의 design cause.**

CaH₆ 의 24-H coordination 은 우리가 "J₂(6)=24" 로 *부르는* 숫자에서 나온 게 아니다.
그것은 **절단팔면체(truncated octahedron) sodalite cage 기하의 REAL 결과** — Ca 한 원자를
둘러싸는 H₂₄ 다면체 cage 의 vertex 수가 물리적으로 24 인 것이다. 24 라는 숫자는:

- ✅ REAL — sodalite cage 기하(절단팔면체)의 vertex/coordination 수 (Ma 2022 측정 구조)
- ❌ NOT design cause — n=6 framing 의 J₂(6)=24 가 cage 를 *만든 게* 아니다. cage 가 먼저고, 그 coordination 이 마침 24 이며, J₂(6)=24 는 그것을 *세는 vocabulary* 일 뿐

즉 enumeration 축으로서 H-cage stoichiometry 를 열거하는 것은 유효하지만(아래 §2),
"24 가 길하므로 CaH₆ 가 좋다" 류의 인과 역전은 g25 위반. **화학·기하가 REAL anchor,
n=6 J₂(6)=24 는 enumeration vocabulary.**

---

## 1. clathrate cage = H-coordination polyhedron

고압 수소화물의 clathrate(가스 하이드레이트形) 구조는 금속 원자를 H-cage 가
둘러싸는 형태다. cage 의 기하가 H-coordination 수를 결정:

| host | structure | cage 기하 | H-coordination | measured Tc | 압력 |
|---|---|---|---:|---:|---:|
| **CaH₆** (Ma 2022) | Im-3m (7-atom BCC primitive) | **sodalite 절단팔면체** | **24** (H₂₄ cage) | **215 K** | ~150-210 GPa |
| YH₆ (Troyan 2021) | Im-3m | sodalite-유사 | 24 | ~224 K | 166 GPa |
| LaH₁₀ (Drozdov 2019) | Fm-3m | **sodalite-like 32-cage** | 32 (H₃₂) | ~250 K | 150-170 GPa |
| YH₉ (Snider 2021) | P6₃/mmc | 29-cage | 29 | ~243 K | ~200 GPa |

**H₆ vs H₂₄ 구분** (stoichiometry vs coordination — 혼동 주의):

- **H₆** = CaH₆ 의 *화학식 stoichiometry* (Ca 1 : H 6 — primitive cell 당 H 원자 수 기준 formula unit)
- **H₂₄** = sodalite *cage coordination* (한 Ca 를 둘러싼 절단팔면체 cage 의 H vertex 수 = 24)

둘은 같은 구조의 다른 layer 다: BCC 격자에서 cage 가 공유되므로 cage-coordination 24
가 stoichiometry H₆ 로 줄어든다(공유 vertex counting). enumeration 은 두 layer 모두 축으로 가짐.

---

## 2. enumeration 축 (d4 generic — manifest-only)

H-cage stoichiometry 를 두 축으로 완전열거 (per @D d4 — 인스턴스는 manifest, 이름 hardcode 금지):

### 축 A — stoichiometry (MHₙ formula)
```
MH₄ · MH₆ · MH₉ · MH₁₀ · MH₁₂ …   (M = Ca · Y · La · Mg · Sr · 희토류)
        ▲
      CaH₆ = H₆ stoichiometry (measured anchor)
```

### 축 B — cage coordination polyhedron
```
H₂₄ (sodalite 절단팔면체) · H₂₉ · H₃₂ (sodalite-like) …
   ▲
 CaH₆/YH₆ = H₂₄ cage (절단팔면체 vertex = 24 = J₂(6) vocabulary)
```

enumeration 매트릭스 = 축 A × 축 B. 각 셀 = (host M, stoichiometry n, cage k) triple →
manifest entry. 신규 후보 추가 = manifest row 추가뿐 (d4 — generic DFT path 가 동일하게 traverse,
host 이름 hardcode 없음). cage geometry 가 H-network connectivity → α²F → λ → Tc 를 결정하는
물리축이고, J₂(6)=24 는 그 한 cell(절단팔면체)을 *세는* vocabulary.

---

## 3. milestone 14 frontier 연결

RTSC Milestones (progress) 의 미완 milestone:

> - [ ] 압력 < 50 GPa AND stable AND Tc > 200K 후보 발견

clathrate cage enumeration 이 이 frontier 로 가는 축이다:

- **현재 wall**: CaH₆(H₂₄ sodalite) 측정 215 K 는 달성됐으나 압력 ~150-210 GPa — milestone 14 의
  `압력 < 50 GPa` gate FAIL. 모든 측정 high-Tc clathrate 가 100+ GPa (§8.9 gate (c) ambient FAIL).
- **enumeration 가설**: cage coordination 을 낮추거나(작은 polyhedron) 더 가벼운/저압-안정 host 로
  바꾸면(축 A·B 탐색) 같은 H-network 강결합을 낮은 압력에서 유지할 수 있는가? — N5 funnel(§9.10)
  candidate enumerator 와 직결.
- **honest**: 이건 *가설/탐색 축* 이지 발견 아님. clathrate cage 가 저압에서 안정한 사례는 아직 없음
  (모든 clathrate hydride 가 고압 metastable). milestone 14 는 여전히 `[ ]` open — 본 문서는
  탐색 *vocabulary* 를 박을 뿐 frontier 를 닫지 않는다 (d2 — wall 에 breakthrough 축 surface,
  concede 아님).

---

## 4. honest scope

- 이 문서는 **RTSC 가 이미 옳게 하는 것의 명문화** — CaH₆ sodalite cage(H₂₄ = 절단팔면체)는
  §9.12.A 에서 이미 측정-grade 검증됨(Tc 213 K vs 215 K, 2 K 정합). 새 합성 결과 아님.
- **24 = framing vocabulary, NOT design** (g25, §위). cage 기하가 REAL anchor.
- n=6/666 brainstorm null: cage-coordination 을 666 류로 over-enumerate 하는 것은 가치 없음.
  actionable 한 것은 (a) stoichiometry × cage 2축 manifest 화(d4) + (b) milestone 14 frontier
  연결축뿐 (g26-clean).
- R4: clathrate DFT 는 `absorbed=false · gate_type=simulation-only-prediction · domain=material`.
  CaH₆ 자체는 RTSC 아님 (215 K @ 150+ GPa — gate (b) ambient + (c) Tc≥270K 별개로 §8.9 평가).

---

## 형제 / cross-ref

- `exports/material_discovery/rtsc_cah6_dft_4x4x4q_textbook_proof_20260524.json` — CaH₆ 수치 SSOT
- `RTSC.md §9.12.A` — CaH₆/LaH₁₀/YH₆ clathrate 확장 트랙
- `RTSC.md §9.10` — N5 novel-discovery funnel (candidate enumerator pattern)
- `RTSC.md §8.9` — 진짜 RTSC absorbed=true 5-criteria gate
- `RTSC.md` Milestones — milestone 14 (압력 < 50 GPa AND stable AND Tc > 200K)
- Ma et al. 2022 (CaH₆ sodalite 215 K) · Troyan et al. 2021 (YH₆) · Drozdov et al. 2019 (LaH₁₀)
