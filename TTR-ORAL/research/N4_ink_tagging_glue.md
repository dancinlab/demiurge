# TTR-ORAL N4 — 잉크-태깅 molecular glue (림프 배출용) · NOVEL 기전 deep-dive

> 🦠 **TTR-ORAL** — "면역세포 택배" · NOVEL mechanism candidate (@D d11)
> 핵심 전환: macrophage 를 바꾸지 않고 **색소(pigment) 자체의 운반성(transportability)** 을 바꾼다. 경구 이작용성(bifunctional) 소분자 = **[잉크-결합 warhead] — [림프-배출 tag]**. warhead 가 색소 표면을 잡고(π-stacking→carbon black · catechol/DOPA→melanin·금속산화물 · bisphosphonate→금속산화물), tag 가 태깅된 색소를 **재포획 대신 림프로 배출**되게 만든다(재탐식 r↓ 하전/PEG stealth · 림프-분배 size/charge). 분해(destroy)가 아니라 **태깅-후-배출(tag-and-drain)** → **비분해성 carbon black 에도 작동**.
> 정직 원칙 (@D d5/d6): 낙관 강제 금지. 핵심 honest check 는 **§3 의 이중 벽** — ADME 도달(~1e-4) AND 살아있는 macrophage phagolysosome 내부의 색소에 접근. sim = `sim/n4_glue.hexa` (verbatim §5). 입력 = `oral_adme_wall.md`(f_target~1e-4) · `cycle1_grounding_reconcile.md`(r·k_eff·n90) · `path_CD_lymphatic_nanocarrier.md` D§2(잉크-친화 화학) · `M9_lit_grounded_recovery.md`(release window).

---

## TL;DR

- **warhead (잉크 결합)**: 세 화학 모두 in vitro 결합은 견고히 닫힌다 — π-stacking PAH(pyrene/perylene)→carbon black ~9 kcal/mol(physisorption, 강한 비탈착) · catechol/DOPA bidentate→금속산화물 **29 k_BT(~17 kcal/mol)·600-900 pN** · bisphosphonate→금속산화물 chemisorption(zoledronate-class, 가장 강). **warhead-색소 결합은 가장 *쉬운* 부분.**
- **export tag (배출)**: PEG/하전/크기로 자유 색소의 macrophage 재탐식을 낮춤(dense PEG stealth ~3-10× uptake↓) → 재포획 r0=0.95 → r_tag 0.1-0.5. 림프 우선 흡수 size window **10-100 nm**(태깅 응집체 크기 의존), 음전하가 배출 동역학 유리. 이는 cycle1 의 **r↓ lever 를 색소 측에서 달성**하는 것 — 단 N4 는 *방출(freeing) lever 는 추가 안 함*.
- **★ 이중 벽 (정직 핵심)**: (A) 경구 ADME 진피 도달 **f_target≈8.9×10⁻⁵** · (B) 색소는 *살아있는* macrophage phagolysosome **내부**에 묻혀 있음 — 묻힌 세포내 구획은 항체·소분자에 **largely inaccessible**(VCC 선례). 게다가 §2 의 stealth tag 는 **하전/PEG 를 요구** → 막투과(Wall B)를 죽임 → 직렬 곱 ~10⁻⁶-10⁻⁸.
- **구원 경로 (§4)**: 묻힌 색소가 아니라 **일시 방출(extracellular) 색소** — macrophage 사멸→자유 색소가 재포획 전 진피 간질에 잠깐 노출되는 분율(phi~0.05/cycle) — 만 *막 통과 없이* 태깅 가능. N4 의 진짜 표적 = 이 방출 풀(release-window). **이 풀에 대해선 Wall B 우회.**
- 1차 판정: warhead 화학 🟢 · export tag stealth/size 선례 🟡 · r→timeline 매핑 🟢(verbatim) · **이중 벽 통합 🟠**. 고유 가치 = **비분해성 carbon black 을 태깅-배출**(N1 분해 천장이 못 푸는 분율).

---

## §1 이작용성 분자 — ASCII 도식 + warhead 화학

```
        bifunctional ink-tagging glue (oral small molecule)
   ┌──────────────────────────┐        ┌──────────────────────────┐
   │   [INK-BINDING WARHEAD]   │──link──│    [LYMPHATIC EXPORT TAG] │
   │  π-stack PAH (pyrene)     │        │  PEG / charged / hydrophilic│
   │  catechol/DOPA (bidentate)│        │  (lowers macrophage re-uptake│
   │  bisphosphonate (chemisorb)│        │   + lymph size/charge window)│
   └─────────────┬────────────┘        └────────────┬─────────────┘
                 │ grips pigment surface             │ presents drain-cue
                 ▼                                    ▼
            tattoo pigment  ───────────────▶  tagged pigment drains to LYMPH
            (carbon black /                   instead of being RECAPTURED
             metal oxide / azo)               (r ↓  →  k_eff ↑  →  fade)
```

warhead = 색소 표면 화학별 anchor (path_CD D§2 정합 · 친화 실측):

| 색소 표면 | warhead | 결합 기전 | 친화 (실측) | tier |
|---|---|---|---|---|
| **carbon black** (sp² graphitic) | pyrene·perylene·다환방향족 | **π-π physisorption** | ~9 kcal/mol/대형 PAH · 흡착 후 탈착 어려움(carbon black 실측) | 🟢 |
| (eu)melanin·금속산화물(TiO₂·Fe₂O₃) | **catechol / DOPA** | bidentate H-bond + 금속 배위 | **29 k_BT(~17 kcal/mol)** bidentate · AFM **600-900 pN/결합** | 🟡 (홍합접착 단일분자 실측) |
| 금속산화물(TiO₂·Fe oxide·ZnO) | **bisphosphonate** | 표면 -OH chemisorption | N-BP(zoledronate)가 BP 중 최강 K_L · γFe₂O₃-NP 강흡착 실증 | 🟢 |

> Boltzmann 결합 선호 exp(ΔG/RT) (RT=0.593 kcal/mol): pyrene ~3.9×10⁶ · catechol ~3.9×10¹² · BP ~1.3×10¹⁶ (sim §5 [1]). **warhead-색소 결합은 모두 thermal escape ≫ → 가장 쉬운 부분.** carbon black 까지 잡는다는 게 N4 의 핵심(분해 불가지만 *잡을* 수는 있음).

---

## §2 export tag — 무엇이 재포획을 낮추고 림프 배출을 높이나

자유 색소(또는 태깅 응집체)의 운명은 **재탐식(recapture) vs 림프 배출(drain)** 의 경쟁이다. tag 가 이 경쟁을 배출 쪽으로 기울인다.

| tag 전략 | 작용 | 정량 (실측) | r 에의 매핑 |
|---|---|---|---|
| **PEG corona (stealth)** | opsonin·complement 결합↓ → MPS 탐식↓ | PEG 화 = 모든 macrophage 집단 uptake↓ · dense PEG ~3-10× | rho 0.1-0.33 |
| **음전하 / 친수 표면** | macrophage scavenger 인지↓ · 배출 동역학↑ | 20 nm·최대 음전하가 림프 배출 최적 | rho 보조 |
| **크기 window (림프 분배)** | <10 nm 혈관 재흡수 · >100 nm depot · **10-100 nm = 림프 우선** | 20-30 nm = LN trafficking 최적·paracortex 침투 | 응집체 size 의존 |

```
   재포획 r0=0.95 (cycle1 자연치)  →  tag 가 재탐식을 rho 배 낮춤  →  r_tag = r0·rho
   weak  (charge only)  rho=0.50  →  r=0.475
   mid   (~3× PEG)      rho=0.30  →  r=0.285
   strong(~10× PEG)     rho=0.10  →  r=0.095
```

- 핵심: 이는 cycle1 의 **make-or-break lever 인 r↓ 를 *색소 측*에서 달성**하는 메커니즘이다(BP1 은 *macrophage 측*에서 = anti-CD64/CD47). N4 는 "재포획자를 바꾸는" 대신 "재포획당하는 대상을 stealth 화"한다.
- **정직 한계**: tag 는 r↓(재포획 차단) lever 만 공급한다. cycle1 이 보였듯 device-free solo 의 timeline 은 **방출(freeing) lever(k_death)** 가 없으면 다년이다. N4 는 freeing 을 가속하지 않는다(§3 [3] NOTE).

---

## §3 ★ 정직 핵심 — 이중 벽 (the double wall)

N4 는 **두 독립 벽의 직렬 곱**으로 in-situ 태깅 효율이 결정된다.

```
   경구 dose
       │  Wall A: 경구 ADME 진피 도달  (oral_adme_wall §2e)
       ▼
   진피 간질 도달 분율  f_adme ≈ 8.9×10⁻⁵  (~1/11,000)
       │  Wall B: 세포내 접근 — 색소는 *살아있는* macrophage
       ▼          phagolysosome 내부에 묻혀 있다
   색소 표면 도달 + 태깅  f_intra
       ├─ 중성 소분자 (막투과 가능): f_intra ~ 0.10 → reach ~ 8.9×10⁻⁶
       └─ 하전/친수 stealth glue   : f_intra ~ 0.001 → reach ~ 8.9×10⁻⁸
```

**Wall B 의 물리 (정직 핵심):**
- 색소는 macrophage *내부* phagolysosome 에 거주 — 묻힌 세포내 구획은 항체·dextran·소분자에 **largely inaccessible**(원발 인간 macrophage VCC 연구; Koppensteiner 2012 analog). 세포외 glue 가 닿아도 (i) 형질막 통과 → (ii) phagolysosome 막 통과 → (iii) 색소 표면 도달, 3중 관문.
- **설계 모순 (fatal tension)**: §2 의 export tag 는 **stealth 를 위해 하전/PEG 를 요구** → 바로 그 하전/친수성이 **막투과(Wall B)를 붕괴**시킨다. tag 가 강할수록(r↓ 효과↑) Wall B 통과율↓. 두 요구가 한 분자에서 **정면 충돌**.
- ⇒ 살아있는 macrophage 안에 *묻힌* 색소의 **in-situ 태깅은 경구로 물리적으로 거의 불가**(reach ~10⁻⁶-10⁻⁸). 이것이 N4 의 가장 정직한 벽이다.

> 비교: path_CD D 의 곱(f_oral×f_home~10⁻⁴-10⁻⁶)은 *세포외* NP 도달이었다. N4 는 거기에 **세포내 phagolysosome 접근(Wall B)을 추가 직렬** → 더 깊은 벽.

---

## §4 구원 경로 — 묻힌 색소가 아니라 *방출* 색소를 태깅 (release-window)

Wall B 를 정면으로 못 뚫으면, **막을 안 건너도 되는 분율**만 노린다. cycle1/M9 의 capture-release-recapture 에서, macrophage 사멸→자유 색소가 진피 간질에 **잠깐 세포외로 노출**되는 분율(phi_release~0.05/cycle, M5b 중앙)이 있다. **이 풀은 막 통과 없이 태깅 가능 → Wall B 우회.**

```
   capture ──▶ [macrophage 내부 phagolysosome] ──사멸──▶ FREED pigment
                  ▲  Wall B (막투과 필요 · 태깅 거의 불가)    │ (세포외, 일시)
                  │                                          ▼  ← N4 가 여기서 태깅
                  └────────── recapture (r0=0.95) ◀── tag 가 r↓ → 림프 배출
```

- N4 의 진짜 표적 = **transiently-freed (extracellular) 색소 풀**(phi~0.05/cycle). 이 풀에 대해 tag 가 재포획을 낮춰 림프 배출로 전환 → cycle1 의 r↓ lever 와 정확히 합치.
- **고유 advantage**: 이 메커니즘은 색소를 *파괴하지 않으므로* **carbon black(시장 20-30%, 비분해성)에도 작동**. N1(분해)은 carbon black BDE 5.37 eV 벽으로 net erase≈0 이지만, N4 는 carbon black 을 *잡아서 끌어낸다*(tag-and-drain). 단 freeing lever 가 없어 timeline 은 다년(§3 [3] NOTE).

---

## §5 hexa-native recompute (verbatim · 🟢 · `hexa run TTR-ORAL/sim/n4_glue.hexa`)

```
=== TTR-ORAL N4: ink-tagging molecular glue for lymphatic export ===

[1] warhead grip vs thermal escape (Boltzmann exp(dG/RT), RT=0.593 kcal/mol):
  pi-stack pyrene  -> carbon black : dG=9.0 kcal/mol  pref=3.90226e+06
  catechol/DOPA    -> metal oxide  : dG=17.197 kcal/mol  pref=3.93133e+12
  bisphosphonate   -> metal oxide  : dG=22.0 kcal/mol  pref=1.29451e+16
  -> all three grip >> thermal; warhead-pigment binding is the EASY part.

[2] export tag lowers macrophage re-uptake (r0=0.95 -> r_tag = r0*rho):
  weak tag   rho=0.50 -> r=0.475
  mid tag    rho=0.30 -> r=0.285
  strong tag rho=0.10 -> r=0.095

[3] r_tag -> k_eff -> fade timeline (device-free oral, cycle1 mapping):
  weak   r=0.475 k_eff=0.2825 n90=8.15074 -> 7.44163 months
  mid    r=0.285 k_eff=0.3775 n90=6.09956 -> 5.5689 months
  strong r=0.095 k_eff=0.4725 n90=4.8732 -> 4.44923 months
  NOTE: these months assume k_death=0.50 (freed-pigment ENVELOPE, cycle1 §2).
  device-free SOLO with natural k_death~0.02 -> multi-year (cycle1 baseline).
  N4 only supplies the r-down lever; it does NOT add a freeing lever.

[4] double wall: ADME reach (Wall A) x intracellular access (Wall B):
  Wall A  f_adme (oral->dermis)        = 8.9e-05
  Wall B  f_intra neutral small-mol    = 0.1
  Wall B  f_intra charged stealth glue = 0.001
  reach (neutral)  = f_adme*f_intra = 8.9e-06
  reach (charged)  = f_adme*f_intra = 8.9e-08
  -> design tension: stealth tag ([2]) DEMANDS charge/PEG, which KILLS Wall B.

[5] taggable pool = transiently-FREED (extracellular) pigment, NOT buried:
  per-cycle freed fraction phi_release = 0.05
  -> N4 retags freed pigment during the release window (no Wall B for that pool)
  carbon black fraction = 0.25 <- N4 works here (tag-and-drain, NOT destroy)
  -> advantage over N1/degrade levers: carbon black is undegradable but IS draggable.

=== N4 done ===
```

---

## §6 정직 한계 요약 + tier

| # | claim | tier | 근거 |
|---|---|---|---|
| 1 | warhead 결합 (π-stack ~9 kcal/mol · catechol 29 k_BT · BP chemisorb) | 🟢 SUPPORTED-NUMERICAL | 흡착/단일분자 실측 (Sources) |
| 2 | export tag stealth ~3-10× uptake↓ · 림프 size 10-100 nm | 🟡 SUPPORTED-BY-CITATION | PEG stealth · 림프 분배 문헌 |
| 3 | r_tag→k_eff→n90 매핑 (cycle1 모델 위) | 🟢 SUPPORTED-NUMERICAL | sim §5 [2-3] verbatim |
| 4 | Wall A f_adme≈8.9e-5 (경구→진피) | 🔵 SUPPORTED-FORMAL | oral_adme_wall §2e closed-form |
| 5 | **Wall B 세포내 접근 — 묻힌 색소에 소분자 inaccessible** | 🔵/🟡 | VCC 선례 + 막투과 물리 (하전 tag 모순) |
| 6 | 이중 곱 reach ~10⁻⁶-10⁻⁸ (in-situ 태깅 거의 불가) | 🔵 SUPPORTED-FORMAL | 직렬 분율 곱 |
| 7 | release-window 풀(phi~0.05)만 Wall B 우회 가능 | 🟠 INSUFFICIENT | cycle1 phi 위 · in-vivo 미실측 |
| 8 | carbon black tag-and-drain (비분해성에도 작동) | 🟡/🟠 | π-stack 결합 🟢 · in-vivo 배출 효율 🟠 |
| 9 | tag→r↓ 의 *달성 가능 수준* + solo timeline | 🟠 INSUFFICIENT | wet-lab (freeing lever 부재 → 다년) |

---

## §7 정직 top-line 판정 (@D d2/d5/d6)

- **warhead-색소 결합은 닫힌다 (🟢)** — π-stacking/catechol/bisphosphonate 모두 강한 실측 친화. carbon black 까지 *잡을* 수 있다는 게 N4 의 출발점(분해는 못 해도 결합은 됨).
- **export tag → r↓ → timeline 매핑은 닫힌다 (🟢 verbatim)** — cycle1 의 make-or-break r↓ lever 를 *색소 측*에서 공급. 단 **freeing lever 가 없어 device-free solo 는 다년**(cycle1 baseline).
- **그러나 in-situ 태깅의 이중 벽이 심각하다 (🟠 핵심)** — 경구 ADME(Wall A, f~8.9e-5) AND 살아있는 macrophage phagolysosome 내부 색소 접근(Wall B, 소분자 inaccessible). 게다가 **stealth tag(하전/PEG)가 막투과를 죽이는 설계 모순** → 묻힌 색소 in-situ 태깅 reach ~10⁻⁶-10⁻⁸ = 사실상 불가.
- **구원은 release-window 풀(phi~0.05)** — 막을 안 건너도 되는 *일시 방출* 색소만 태깅(Wall B 우회). 여기에 N4 의 **고유 가치 = 비분해성 carbon black 을 tag-and-drain**(N1 분해 천장 미해결 분율). 단 freeing 가속이 없어 timeline 은 다년.

⇒ **종합: warhead·tag·매핑은 닫히나(🟢), in-situ 묻힌-색소 태깅의 ADME×세포내-접근 이중 벽(+ stealth↔투과 모순)이 경로를 🟠 로 묶는다.** 정직 판정: **🟠 INSUFFICIENT/DEFERRED.**

**"경구 in-situ 잉크 태깅은 물리적으로 feasible 한가?"** — *묻힌 색소*(macrophage 내부)에 대해서는 **No**(이중 벽 + 하전 tag 막투과 모순, reach ~10⁻⁶-10⁻⁸). *방출 색소*(release-window, 세포외)에 대해서만 **부분 feasible**(Wall B 우회). **"carbon black 에서 분해-기반 lever 를 이기는가?"** — *부분적으로 Yes*: N1 분해는 carbon black BDE 벽으로 net erase≈0 이지만, N4 는 carbon black 을 *결합해 끌어낸다* — **device-free 로 carbon black 을 다룰 수 있는 유일한 lever 군에 속함**. 그러나 freeing lever 가 없어 solo timeline 은 다년이고, 분해 levers 와 *병용*(freeing↑ + N4 tag-and-drain) 이 가장 정직한 포지션. 단독으로는 분해 levers 를 결정적으로 이기지 못함.

---

## Sources
- 경구 ADME 진피 도달 f_target≈8.9×10⁻⁵ · 5600× amplification — `TTR-ORAL/research/oral_adme_wall.md` §2
- 재포획 r0·k_eff·n90·release window — `TTR-ORAL/research/cycle1_grounding_reconcile.md` · `M9_lit_grounded_recovery.md`(Baranska 2018 capture-release-recapture)
- 잉크-친화 warhead 화학 (π-stack·catechol·BP) — `TTR-ORAL/research/path_CD_lymphatic_nanocarrier.md` D§2
- PAH/pyrene π-stacking 흡착 (graphene·carbon black, physisorption, 비탈착) — *Environ. Sci. Technol.* (pubs.acs.org/doi/10.1021/es405227u) · carbon black pyrene 흡착 (PMC11053581) · graphene PAH DFT/AIMD (PMC5978103)
- catechol/DOPA 금속산화물 결합 29 k_BT bidentate · 600-900 pN (단일분자 force spec) — Utzig 2016 *Angew. Chem.* (onlinelibrary.wiley.com/doi/10.1002/anie.201601881 · PMC5113705) · DOPA-TiO₂ 배위 (Nat. Commun. s41467-020-17597-4)
- bisphosphonate-금속산화물/HAP 친화 (zoledronate-class 최강 · γFe₂O₃-NP) — *Bone* 2006 (pubmed 16046206) · 초상자성 BP-NP (PMC2957199) · BP-HAP K_L (PMC2743543)
- PEGylation macrophage uptake↓ (stealth, opsonization↓, ~3-10×) — *Sci. Rep.* (nature.com/articles/srep26269) · partial PEGylation uptake (PMC6397647) · *Pharm. Res.* (link.springer.com/article/10.1007/s11095-011-0510-x)
- 림프 분배 size window 10-100 nm (20-30 nm LN trafficking 최적 · 음전하 유리) — *Pharmaceutics* (PMC9960358) · critical size limit (PMC7747954) · dense PEG lymphatic transport (biorxiv 2020.08.01.232249)
- 세포내 묻힌 색소/구획 소분자 inaccessibility (Wall B) — 인간 macrophage VCC 항체·소분자 접근 불가 (PMC3342280) · tattoo 색소 phagolysosome 내 비분해 잔류 (UCSF Synapse 2024 · ResearchGate 399078225)
