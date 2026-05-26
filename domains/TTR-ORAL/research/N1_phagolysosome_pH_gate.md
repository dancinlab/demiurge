# TTR-ORAL N1 — phagolysosome-pH-gated in-situ 색소 분해 (NOVEL 기전 deep-dive)

> 🦠 **TTR-ORAL** — "면역세포 택배"
> NOVEL 후보 (@D d11): 중성(혈액/진피 pH 7.4)에서 **불활성**, 잉크 탐식 macrophage 의 산성 phagolysosome(pH ~4.5)에서만 **활성화**되어 색소를 *그 자리에서* 분해하는 경구 소분자/nanozyme.
> 두 가지를 동시에 푼다 — (a) 색소를 **파괴**(erase, not relocate → W1 해소) · (b) 외부 device 불요 + 중성 불활성 → 전신 무해(추정).
> 정직 원칙 (@D d5/d6): "된다"를 압력으로 강제 금지. 핵심 honest check 는 **§4 (pH-alone 게이팅이 정말 site-specific 한가)**.
> sim = `sim/n1_ph_gate.hexa` (verbatim §6). 입력 = `cycle1_grounding_reconcile.md`(W1 relocate-not-erase) · `oral_adme_wall.md`(f_target~1e-4) · `TTR/verify/V2_formal_identities.md` §7(CeO₂ ΔE 0.171 V) · `TTR/research/moa_shortlist.md` §1-3 · `TTR/research/ink_classes.md` §6(시장 분율).

---

## 1. pH-게이팅 1차 원리 — 왜 7.4 OFF / 4.5 ON 인가

진피 macrophage 의 phagolysosome 은 V-ATPase 양성자 펌프로 ~15-20분 내 **pH 5.4 → 4.5** 까지 산성화한다(문헌 §Sources). 혈액/진피 간질은 pH 7.4 로 항상성 유지. **ΔpH = 2.9** 가 게이트의 물리적 핸들이다.

게이팅 메커니즘 3종 (모두 first-principles):

| 게이팅 방식 | OFF(7.4) 원리 | ON(4.5) 원리 | 정량 핸들 |
|---|---|---|---|
| **(a) Nernst 산화환원 스위치** (CeO₂) | E(7.4)=+1.28 V → 약산화/항산화 균형 | E(4.5)=+1.45 V → Fenton-ON 강산화 | ΔE = **0.171 V** (V2 §7 정합) |
| **(b) 산촉매 속도 스위치** (acid-labile/specific-acid) | rate ∝ [H⁺]ᵐ → 7.4 에서 [H⁺] 극소 | 4.5 에서 [H⁺] 10²·⁹ 배 ↑ | 속도비 = 10^(2.9·m) |
| **(c) pKa-게이트 prodrug** (pKa ~5.5-6.0 cage) | 7.4 → 탈양성자 caged 형태 = 비활성 | 4.5 → 양성자화 → cage 가수분해 → 활성체 방출 | Henderson-Hasselbalch 분율 |

```
   pH-게이트 ON/OFF 대조 (sim §6 verbatim)
   pH 7.4 (혈액/진피)  ░░░░░░░░░░  OFF  E=+1.28 V · 산촉매율 baseline
   pH 4.5 (phagolyso)  ██████████  ON   E=+1.45 V · 산촉매율 ×794 (m=1) ~ ×6.3e5 (m=2)
                                         ΔE=0.171 V · ΔpH=2.9
```

- **Nernst(a)**: `E(pH) = E° − 0.0591·pH` (n=1, 298 K). pH 4.5↔7.4 사이 ΔE = 0.0591×2.9 = **0.171 V** — CeO₂ 의 Ce³⁺/Ce⁴⁺ 표면비가 산성에서 oxidase/peroxidase(Fenton-유사) 쪽으로, 중성에서 SOD/catalase(항산화) 쪽으로 기운다(문헌: CeO₂ oxidase 활성 최적 ~pH 4). V2 §7 와 동일 closed-form.
- **산촉매(b)**: m=1 (specific-acid) 만으로도 ON/OFF ≈ **794×** (≈3 orders) — 7.4 를 사실상 불활성으로 유지하기에 충분. acid-labile linker + H⁺-촉매가 직렬이면 m=2 → ~6.3×10⁵.
- ⇒ **형식적으로 7.4 OFF / 4.5 ON 대조는 닫힌다 (🔵)**. 게이트 자체는 원리상 견고하다. 문제는 §4 의 *site-specificity*.

---

## 2. 후보 화학 — 잉크 클래스별 분해 가능성

| 후보 | 게이팅 방식 | 표적 잉크 클래스 | 분해 화학 | 정직 비고 |
|---|---|---|---|---|
| **CeO₂ nanozyme** (pH-switchable Fenton) | (a) Nernst | azo · carbon 표면 · Fe oxide(보조) | pH4.5 → •OH 생성 → azo N=N 산화절단 | 가장 검증된 pH-switch nanozyme; 산성 oxidase ON |
| **acid-activated azoreductase-mimic** | (b)/(c) | azo (N=N) | 환원절단 N=N → 2× 아민 | azo 60-70% 의 직접 핸들; 단 방향족 아민 산물 독성 (moa §9-1) |
| **pH-labile prodrug → oxidant/chelator** | (c) pKa-cage | Fe oxide(→DFO/deferiprone) · azo(→ascorbate) | 4.5 에서 cage 가수분해 → 유리 chelator/환원체 | deferiprone 경구 BA 이미 검증; cage 만 추가 |
| **pH-responsive metal-organic 촉매** (MOF/Fe-포피린) | (a)+(b) | azo · phenol · QA | 산성에서 Fe(IV)=O 유사 산화 | 합성 복잡도 ↑; r_dark 평가 필요 |

**잉크 클래스별 first-principles 분해성** (`moa_shortlist.md` §1-3 · `ink_classes.md` §6):

```
              ┌─────────────┬──────────────────────────────────────┐
   azo 유기   │ N=N BDE 167 │ ●●● 절단 OK (•OH 산화 or 환원, ~70% dye)│
   Fe oxide   │ log K(DFO)30│ ●● chelation 추출 (산성 pH 무관 작동)   │
   quinacridon│ H-bond 25   │ ●● 표면 ROS 산화 (불완전 발색단 회복)   │
   carbon blk │ C-C 518 kJ  │ ✗ bulk 분해 불가 (•OH +2.80V → 표면식각만)│
   Cu-Pc/Cr2O3│ Cu-N 30·d³  │ ✗ wall (thermodynamic/kinetic 차폐)    │
              └─────────────┴──────────────────────────────────────┘
```

- **azo (●●●)**: 가장 약한 cleavable 결합. •OH 의 N=N 공격 또는 환원절단 모두 thermodynamic OK (E°(azo/hydrazo)≈−0.3 V). 산업 dye Fenton 분해의 ~70% chromophore 가 azo (문헌 §Sources).
- **Fe oxide (●●)**: chelation 은 pH 무관 작동 — phagolysosome 산성이 오히려 Fe³⁺ 용해도↑ → DFO/deferiprone 추출 가속.
- **carbon black (✗ — 정직)**: sp² 방향족 C-C BDE 518 kJ/mol = **5.37 eV** ≫ •OH 산화전위 +2.80 V 가 줄 수 있는 에너지. ROS 는 **표면 -COOH/-OH 식각만** 가능, bulk graphitic core 는 분해 불가. 입자 크기만 천천히 줄 뿐 *net erase ≈ 0*. **이 분율(20-30%)은 pH-게이트로도 안 지워진다.**
- **Cu-Pc/Cr₂O₃ (✗ — wall)**: Cu-N 배위 log K ~30 (DFO-Fe 와 동등) · Cr³⁺ d³ 치환 10⁶× 느림 → moa §7 의 wall 그대로.

---

## 3. 경구 전달 — 촉매가 진피 macrophage phagolysosome 까지 가는가

`oral_adme_wall.md` 의 **f_target ≈ 8.9×10⁻⁵ (~1/11,000)** ADME 벽은 N1 에도 그대로 적용된다. 단 결정적 차이: **활성이 게이팅되므로 전신 노출 자체는 (중성에서) 무해** → 벽이 "전신 독성"이 아니라 **"충분량이 도달 + *올바른* macrophage 가 흡수하는가"** 라는 *전달 효율* 문제로 바뀐다.

```
  경구 dose ──Fa·Fg·Fh──▶ 혈류 ──Kp──▶ 진피 간질 ──탐식──▶ 잉크 phagolysosome
   nanozyme: GI 흡수율 매우 낮음(문헌)        ↑ 여기서 산성→ON
   소분자  : F~0.5 (deferiprone 경구 검증)    ↑ 이 흡수(uptake)가 두 번째 벽
```

이중 제약 (정직):
1. **ADME 도달** — nanozyme(CeO₂)의 경구 GI 흡수는 문헌상 **매우 낮음**(대부분 분변 배출, 전신 <4%). → nanozyme 경로는 경구 BA 가 1차 병목. *소분자 pKa-cage prodrug* (deferiprone-class, 경구 BA 검증) 가 ADME 측면에서 유리.
2. **올바른 uptake** — 도달한 촉매가 *잉크 탐식* macrophage 에 흡수돼야 함. nanozyme 은 macrophage 탐식 친화성이 높다(장점)지만, *어느* macrophage 인지 무차별 → §4 와 직결.

⇒ ADME 벽은 게이팅으로 "독성 항"이 제거되어 **부분 완화**되나, *전달 효율(도달량×올바른 uptake)* 은 여전히 🟠 미해소. nanozyme 은 BA 가, 소분자는 uptake 선택성이 각각 약점.

---

## 4. ★ 정직 핵심 check — pH-alone 게이팅은 정말 site-specific 한가?

**아니다 (핵심 발견).** 리소좀은 **모든 세포에 편재**하는 산성(pH ~4.5) 소기관이다. pH 만으로 게이팅하면 잉크 phagolysosome 뿐 아니라 *온몸 모든 세포의 리소좀*에서 촉매가 켜진다.

부피 예산 (sim §6 [3] verbatim):

```
  전신 리소좀 총부피  = 3.7e13 세포 × 300 lyso × 0.5 µm³ ≈ 5.55 mL
  잉크 phagolysosome  = 1e6 laden mac × 100 µm³        ≈ 1e-7 mL
  ───────────────────────────────────────────────────────────
  산성 표적 중 잉크-laden 분율 = 1.8e-8   (1억 분의 2!)
```

```
   compartment map (산성 pH 4.5 = ON 영역)
   ┌──────────────────────────────────────────────────┐
   │ 온몸 모든 세포 리소좀  ███████████████████  5.55 mL │ ← pH-alone 으로 전부 ON
   │ 잉크 phagolysosome     ·(1e-7 mL, 보이지 않음)     │ ← 우리가 원하는 곳
   └──────────────────────────────────────────────────┘
   pH-게이트는 5.55 mL 를 켜고, 그 중 1.8e-8 만 잉크와 겹친다.
```

이게 무해한가? **세 가지 구원 요인이 부분적으로만 작동** (정직):
1. **촉매적 ≠ 소모적**: 촉매는 *기질(색소)* 이 있어야 net 손상을 만든다. 색소 없는 리소좀에선 촉매가 있어도 분해할 표적이 없음.
2. **숙주 항산화 완충**: 모든 리소좀은 catalase/SOD/GSH 로 내인성 ROS flux 를 완충. 단 sim §6 [4]: Fenton-ON nanozyme 이 몰 수 있는 [•OH] ~5×10⁻⁵ M / 숙주 완충 ~10⁻⁵ M = **5× 과부하** → 완충 초과 시 모든 산성 리소좀이 산화 스트레스. **즉 무해 보장 안 됨.**
3. **농도 prior**: f_target~1e-4 로 도달량 자체가 극소 → 절대 ROS flux 가 낮을 수 있음(완화).

```
   "중성 불활성" 이 푸는 것 vs 못 푸는 것
   pH 7.4 혈액/진피  ✅ OFF — 전신 순환 무해 (게이팅의 진짜 성과)
   pH 4.5 off-target ❌ ON  — 온몸 리소좀 동시 활성 (pH-alone 의 미해결 구멍)
```

⇒ **결론: pH-alone 은 site-specific 하지 않다.** 진짜 site-specificity 는 **pH AND 색소-근접** 두 조건의 *논리곱(AND)* 을 요구한다. 후보 보강:
- **BP-N1a**: 촉매를 색소 친화 ligand(catechol/DOPA = TiO₂·Fe oxide 표면 결합 §moa 3.1)에 conjugate → 색소 표면에 *국소 농축* 된 곳에서만 유효 농도 도달 → 부피 예산을 색소 표면적으로 한정.
- **BP-N1b**: macrophage-targeting(만노스/SR 리간드)로 *탐식* 세포에 우선 흡수 → 리소좀 편재 분모를 macrophage 로 축소(여전히 잉크 무관 macrophage 포함).
- **BP-N1c**: 촉매적·무소모 + 색소 기질-의존 net 손상 + 극저 도달농도 → off-target 산화를 *완충 이하*로 억제하는 dose 설계(sim §6 [4] 의 5× 를 <1 로). dose-ceiling 문제로 환원.

---

## 5. 정직 한계 요약 + tier

| # | claim | tier | 근거 |
|---|---|---|---|
| 1 | Nernst pH-스위치 ΔE=0.171 V (7.4 OFF/4.5 ON) | 🔵 SUPPORTED-FORMAL | closed-form (V2 §7 정합) |
| 2 | 산촉매 ON/OFF = 10^(2.9·m), m=1 → ~794× | 🔵 SUPPORTED-FORMAL | sim §6 [2] · [H⁺] 멱승 |
| 3 | phagolysosome pH 4.5-5.0 vs 혈액 7.4 | 🟡 SUPPORTED-BY-CITATION | 문헌 §Sources |
| 4 | CeO₂ 산성 oxidase-ON / 중성 항산화 nanozyme | 🟡 SUPPORTED-BY-CITATION | 문헌 §Sources |
| 5 | azo •OH/환원 절단 (~70% dye chromophore) | 🟡 SUPPORTED-BY-CITATION | Fenton dye 분해 문헌 |
| 6 | carbon black bulk 분해 불가 (BDE 5.37 eV ≫ •OH) | 🔵 SUPPORTED-FORMAL | unit-conv (V2 §4) |
| 7 | **pH-alone NOT site-specific** (리소좀 편재, 산성분율 중 잉크 1.8e-8) | 🔵 SUPPORTED-FORMAL | 부피 예산 sim §6 [3] (입력값 🟡) |
| 8 | off-target ROS 과부하 5× → 무해 미보장 | 🟠 INSUFFICIENT | 완충 vs flux 정밀 PBPK 필요 |
| 9 | nanozyme 경구 BA 매우 낮음 / 소분자 prodrug uptake 선택성 | 🟠 INSUFFICIENT | 문헌 GI<4% · in-vivo 도달 미실측 |
| 10 | BP-N1a/b/c (색소-근접 AND-게이팅) 정량 효율 | 🟠 INSUFFICIENT | conjugate 설계 + reaction-diffusion (후속) |

---

## 6. hexa-native recompute (verbatim · 🟢 · `hexa run TTR-ORAL/sim/n1_ph_gate.hexa`)

```
=== TTR-ORAL N1 phagolysosome pH-gate ===

[1] CeO2 Nernst pH-switch (E0=1.72 V, slope 0.0591 V/pH):
  pH 4.5 phagolysosome  E = 1.45405 V  (Fenton-ON / oxidizing)
  pH 7.4 blood/dermis   E = 1.28266 V  (antioxidant balance)
  delta E (4.5 vs 7.4)  = 0.17139 V  (pH-driven switch, V2 §7 = 0.171)

[2] acid-catalyzed ON/OFF rate ratio = 10^(dpH*m), dpH = 2.9:
  m=1 (general/specific acid): 794.328 x  (~800x)
  m=2 (acid-labile + H+ cat.): 630957 x  (~6.3e5)
  -> even m=1 gives ~3 orders OFF->ON; ample to keep 7.4 inert.

[3] pH-ALONE site-specificity (acidic-compartment volume budget):
  total body lysosome volume   = 5.55 mL
  tattoo ink-phagolysosome vol = 1e-07 mL
  fraction of acidic volume that is ink-laden = 1.8018e-08
  -> pH-alone is NOT site-specific: ~1.8018e-08 of acidic targets.

[4] off-target ROS overload at pH4.5 lysosomes (no pigment sink):
  catalyst-driven [.OH] / host buffer = 5.0 x
  -> >1 means EVERY acidic lysosome is oxidatively stressed = NOT harmless.
  (neutral-pH inertness solves 7.4 blood; it does NOT solve 4.5 off-target)

[5] addressable pigment fraction (acid-gated ROS + chelation):
  azo + Fe-oxide + QA (cleavable) : 0.6 - 0.7
  carbon black (surface etch only): 0.25 -> net erase ~0 (BDE 5.37 eV)
  Cu-Pc + Cr2O3 (wall)           : 0.125
  => realistic ADDRESSABLE ~ 60-70% IF catalyst reaches + activates in situ

=== N1 done ===
```

---

## 7. 정직 top-line 판정 (@D d2/d5/d6)

- **게이트 자체는 닫힌다 (🔵)** — 7.4 OFF / 4.5 ON 대조는 Nernst ΔE 0.171 V + 산촉매 ~794× 로 형식적으로 견고. 색소를 *파괴*하므로 W1(relocate-not-erase)을 원리상 해소.
- **그러나 pH-alone 은 site-specific 하지 않다 (🔵 핵심 honest check)** — 리소좀은 온몸 모든 세포에 편재(산성 총부피 5.55 mL), 그 중 잉크-laden 은 **1.8×10⁻⁸**. "중성 불활성" 은 pH 7.4 혈액만 해결할 뿐, **pH 4.5 off-target 리소좀은 전부 켜진다**. off-target ROS 5× 과부하(🟠)로 무해 미보장.
- **진짜 게이팅은 "pH AND 색소-근접" 의 논리곱** — 단일 pH 게이트로는 부족하고, 색소-친화 conjugate(BP-N1a) 또는 dose-ceiling(BP-N1c) 으로 두 번째 조건을 부여해야 함 (🟠 후속).
- **addressable 색소 분율 = ~60-70%** (azo + Fe oxide + QA), 단 *촉매가 도달 + in-situ 활성화* 전제. **carbon black 20-30% 는 BDE 5.37 eV 로 bulk 분해 불가(net erase ≈0)**, Cu-Pc/Cr₂O₃ 10-15% 는 wall. **device-free 단독으로 절대 ≥90% 도달 불가** — carbon black + wall 분율이 천장을 ~70% 로 제한.

⇒ **종합: N1 은 "color erase" 와 "중성 불활성" 두 가지를 진짜로 푸나, 'pH-alone = 자동 site-specific' 라는 매력적 전제가 *틀렸음*을 1차 원리로 확인했다.** 진정한 device-free 게이팅은 *pH × 색소-근접* 이중 조건을 요구하며(🟠 후속 conjugate 설계), 도달 가능 색소는 carbon black/wall 을 빼면 ~60-70% 가 천장이다. honest 판정: **"게이트 견고 · site-specificity 는 pH-alone 으로 미달 · addressable ~60-70% · ≥90% 불가."**

---

## Sources
- Phagolysosome 산성화 pH 4.5-5.0 (V-ATPase, 15-20분) — *JCI* 2020 (jci.org/articles/view/133938) · Phagolysosome (en.wikipedia.org/wiki/Phagolysosome) · 리소좀 산성 ROS homeostasis (PMC12139194)
- CeO₂ nanozyme pH-tunable oxidase/peroxidase (산성 ON · 최적 ~pH 4) — *Anal. Chem.* (pubs.acs.org/doi/10.1021/ac102826k) · *Molecules* 2023 peroxidase-like (PMC10180353) · *J. Phys. Chem. C* heteroaggregate antioxidant (pubs.acs.org/doi/10.1021/acs.jpcc.3c03964)
- CeO₂ 경구 BA 매우 낮음 (분변 배출, 전신 <4%, phagolysosomal simulant uptake) — *Environ. Sci. Nano* 2014 (pubs.rsc.org/.../c4en00034j) · oral 안전성/GI 잔류 (PMC10920649) · 반복 경구 biodistribution (S1382668922001326)
- azo dye Fenton/•OH N=N 절단 (~70% chromophore azo) — *J. Hazard. Mater.* photo-Fenton RB5 (S0143720805002378) · Fenton-like textile dye (mdpi.com/2673-7248/5/3/37)
- CeO₂ ΔE 0.171 V pH-switch closed-form — `TTR/verify/V2_formal_identities.md` §7 (arxiv:2104.10994 정합)
- 시장 색소 분율 (azo+Fe+QA 60-70% · carbon 20-30% · Cu-Pc/Cr₂O₃ 10-15%) — `TTR/research/ink_classes.md` §6 · `moa_shortlist.md` §6-7
