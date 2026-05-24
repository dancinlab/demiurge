# TTR-ORAL N5 — optical masking: 잉크를 *제거하지 않고* 안 보이게 (조직 광학 변조 · NOVEL escape 시도)

> 🦠 **TTR-ORAL** — "면역세포 택배"
> NOVEL 후보 (@D d11/d2): 잉크를 제거(carbon-floor + ADME 두 벽)하는 대신, **위에 덮인/주변 조직의 광학을 바꿔** 잉크-vs-피부 대비(contrast)를 눈의 분별역(JND) 아래로 떨어뜨려 "안 보이게" 한다. 잉크 접촉 0 · 분해 0 → *원리상* 두 벽을 모두 우회.
> 레버 후보 (경구): ① 표피 멜라닌↑ (controlled tan, afamelanotide-류) ② 진피 콜라겐 산란↓ / 굴절률 매칭 (optical clearing).
> 정직 원칙 (@D d5/d6): "된다" 강제 금지. **핵심 honest check = §3** — 잉크 *위에* 균일하게 덮인 흡수체(표피 멜라닌)는 잉크와 주변을 *똑같은 배율*로 어둡게 하므로 **Weber 대비에서 그 배율이 약분되어 사라진다**(대비 불변). 즉 탠은 화면 전체를 균일하게 어둡게 할 뿐 어두운 패치는 비례적으로 그대로 어둡다.
> sim = `sim/n5_masking.hexa` (verbatim §4). 입력 = `cycle1_grounding_reconcile.md`(W1 relocate ≠ erase) · `oral_adme_wall.md`(f_target·전신성) · `M9_lit_grounded_recovery.md`(site-specificity 벽).

---

## 1. 광학 — 타투가 보이는 이유 & 무엇을 바꿔야 가려지나

타투는 **진피 잉크가 주변 조직 대비 빛을 다르게 흡수/산란**하기 때문에 보인다. 보이는 정도 = 표면 반사율의 대비.

```
   눈 ◐                         빛 경로 (표피→잉크→되돌아옴)
    │  ┌─────────────────────────────────────────────┐
    │  │  표피 (L~100µm)  ← 멜라닌 veil (Beer-Lambert) │  ← 탠 레버 ①: f_mel↑
    ▼  ├─────────────────────────────────────────────┤
       │  진피: 콜라겐 산란(밝은 배경 R0_skin~0.45)    │  ← 클리어링 레버 ②: μs'↓
       │       ███ 잉크 패치 (어두움 R0_ink~0.08) ███   │
       └─────────────────────────────────────────────┘
   빛은 표피 멜라닌을 두 번(down+up) 통과 → T_epi² 로 감쇠 (잉크·주변 둘 다 똑같이)
```

| 광학량 | 식 | 의미 |
|---|---|---|
| 표피 투과율 (1-way) | `T_epi = exp(−μ_a,mel · f_mel · L_epi)` | 멜라닌 부피분율 f_mel 에 지수 의존 |
| 표면 반사율 | `R = R0 · T_epi²` | down+up 두 번 통과 |
| **Weber 대비** | `C = (R_skin − R_ink) / R_skin` | 눈은 ΔL/L 에 반응 |
| 분별역 JND | `C ≲ 0.01–0.02` | Weber fraction ~1–2% (이하면 "안 보임") |

- 앵커 (Jacques 피부광학·OMLC): f_mel = light skin **0.06** → dark skin **0.40**; μ_a,mel(녹색대) ~ **100/cm**; L_epi ~ 0.01 cm.
- **멜라닌은 진피 잉크보다 *위*에 있다** — 표피 멜라닌은 진피 잉크를 *덮는* veil 이지, 잉크와 *나란히* 있는 대비원이 아니다. 이 기하가 §3 의 결정적 함정.

---

## 2. 경구 레버 — 조직 광학을 바꿀 실재 후보 + 크기

| 레버 | 기전 | 경구 가능? (정직) | 광학 효과 크기 |
|---|---|---|---|
| **afamelanotide (Scenesse)** | MC1R agonist → eumelanin 합성 (UV 없이도 darkening) | ✗ **경구 불가** — 13-mer 펩타이드, 장 단백분해 → **피하 임플란트만** (α-MSH 반감기 분 단위) | f_mel↑ 검증 (EPP에서 무통 일광노출 +69%) · 절대 ITA Δ 비공개 |
| **melanotan I/II** | 동 MC1R/MC4R agonist | ✗ 경구 불가 — 펩타이드, **피하주사 의존** (gut proteolysis) | tan↑ 명확하나 device-free 경구 아님 |
| **bivamelagon / 경구 MC4R** | 최초 경구 MC4R agonist | ◐ MC**4**R (식욕) 표적 — 피부 MC1R tan 효과 아님 | tan 레버로 부적합 |
| **PL-8177 (경구 cyclic peptide)** | 경구 투여되나 **전신 비흡수**(장관 MC1R local) | ✗ 전신 도달 0 → 피부 tan 불가 | 피부 효과 없음 |
| **경구 콜라겐 펩타이드** | 진피 콜라겐 밀도/echo density↑ (RCT 다수) | ✓ 경구 검증 | μs'·R0_skin 을 **올릴** 가능성 (반대 방향) — 클리어링 아님 |
| **optical clearing (글리세롤/HA RI-match)** | μs'↓ (굴절률 매칭) | ✗ **국소·일시적만** — 경구 전신 진피 RI-match 약물 부재 | μs' ~30–50%↓ 가능하나 topical |

- **정직한 1차 벽 (레버 자체)**: tan 의 *가장 검증된* 레버(afamelanotide/melanotan)는 **전부 펩타이드 = 경구 불가**(장 단백분해 — `oral_adme_wall.md` 의 펩타이드 ADME 벽과 동일). 경구 MC1R small-molecule tan agent 는 임상 부재. ⇒ N5 의 ① 레버는 **현 시점 경구 device-free 로는 도달 약물조차 없음**.
- ② optical clearing 은 효과는 실재하나 **국소·일시적**(글리세롤 도포) — 경구 전신 진피 RI-match 기전 없음.

---

## 3. ★ 정직 핵심 check — 위에 덮인 veil 은 *대비*를 줄이지 못한다 (T² 약분)

타투 위 멜라닌을 늘리면 어두워져서 가려질 것 같다. **그러나 멜라닌은 잉크와 주변을 *똑같이* 덮으므로 Weber 대비에서 그 배율이 약분된다:**

```
   R_skin = R0_skin · T_epi²        R_ink = R0_ink · T_epi²
                  ┌──────────────────────────────────────────┐
   Weber C  =  (R_skin − R_ink)        (R0_skin − R0_ink)·T²    R0_skin − R0_ink
            =  ─────────────────  =  ───────────────────────  =  ───────────────
                    R_skin                  R0_skin·T²              R0_skin
                  └──────────────────────────────────────────┘
                         ⇒  T_epi²  가  약 분 됨  ⇒  C  는  f_mel 에  불 변
```

`hexa` sim §4 [2] 가 직접 확인: f_mel 을 0.06 → 0.40 (light→dark 천장)까지 올려도 **Weber 대비 C = 0.822 로 변하지 않음** (JND 0.02 보다 한참 위 = 여전히 잘 보임). 탠은 *화면 전체*를 균일하게 어둡게 할 뿐, 어두운 잉크 패치는 *비례적으로 그대로 어둡다*.

```
   "균일 veil 은 대비를 옮기지 않는다"
   f_mel↑  →  R_skin↓  &  R_ink↓  (같은 T² 배율)  →  비율(C) 그대로
   진짜 masking 은 잉크와 주변 *사이*(in-plane)에 흡수체가 필요한데,
   표피 멜라닌은 둘 다의 *위*에 있다 → 기하적으로 대비 상쇄 불가.
```

- **절대(휘도) gap dR = R_skin − R_ink** 는 줄긴 한다(§4 [4]: 0.29 → 0.075). 단 gap→0 은 **전체 반사율→0**(= 온몸을 칠흑같이 태움)일 때만 — 미용상 부조리(JND는 절대휘도가 아니라 *대비*에 반응하므로 어두워진 배경에서 패치는 여전히 식별됨).
- ② 클리어링(μs'↓ → R0_skin 0.45→0.25, §4 [5])은 *주변을 잉크 쪽으로 끌어내려* 절대 gap 을 줄이지만 C 는 여전히 0.68 — 그리고 경구 전신 기전이 없다.

⇒ **물리 자체가 N5 의 천장을 설정한다**: 오버레이 흡수체로는 Weber 대비를 못 줄인다 (T² 약분). 이것이 어떤 약물 한계보다 먼저 오는 *closed-form* 벽.

---

## 4. hexa-native recompute (verbatim · 🟢 · `hexa run TTR-ORAL/sim/n5_masking.hexa`)

```
=== TTR-ORAL N5 optical masking (tissue optics, NOT ink removal) ===

[1] baseline contrast through LIGHT-skin epidermis (f_mel=0.06):
  T_epi(1-way)=0.88692  R_skin=0.353983  R_ink=0.0629302
  Weber contrast C=0.822222  (JND=0.02) visible? true

[2] after ORAL TAN raises f_mel (afamelanotide-like darkening):
  f_mel : T_epi   R_skin    R_ink     C(Weber)   <JND(invisible)?
  0.06  : 0.88692  0.353983  0.0629302  0.822222   false
  0.12  : 0.786628  0.278453  0.0495027  0.822222   false
  0.25  : 0.606531  0.165546  0.0294304  0.822222   false
  0.40  : 0.449329  0.0908534  0.0161517  0.822222   false

[3] ** WHY masking by an OVERLYING absorber largely FAILS on contrast **
  Both R_skin and R_ink scale by the SAME factor T_epi^2 (Beer-Lambert).
  Weber C = (R0_skin - R0_ink)/R0_skin  -> T_epi^2 CANCELS in the ratio.
  => contrast is INVARIANT to a uniform overlying veil: C=0.822222 (independent of f_mel)
  Tanning dims the WHOLE field uniformly; the dark patch stays proportionally dark.
  (Real masking needs absorber sitting BETWEEN ink & surround in-plane, not above both.)

[4] absolute (luminance) gap shrinks, but stays >> JND until field is near-black:
  f_mel : abs gap dR = R_skin - R_ink
  0.06  : 0.291052
  0.25  : 0.136115
  0.40  : 0.0747017
  (gap only ->0 as TOTAL reflectance ->0, i.e. tan everyone jet-black; cosmetically absurd)

[5] dermal-collagen / refractive-index-match lever (optical clearing):
  reduced scattering mu_s' drop lowers R0_skin (bright surround) TOWARD R0_ink.
  glycerol/RI-match can cut mu_s' ~30-50%; model R0_skin 0.45 -> ~0.25:
  R0_skin->0.25: C=0.68 (vs 0.822) -- contrast WORSENS toward ink? no, surround->ink so |gap| shrinks
  but optical clearing is TRANSIENT/topical; no oral agent achieves dermal RI-match systemically.

[6] specificity wall (the same one the whole program has):
  an ORAL tan/clearing agent acts WHOLE-BODY. ink-bearing skin fraction of total skin:
  tattoo/body skin area = 0.00555556
  -> to mask ~100 cm^2 you must tan ~1.8 m^2 of skin (and face/eyes) -> trades carbon/ADME
     wall for the SITE-SPECIFICITY wall. and masking != removal: ink persists, contrast returns.

=== honest: overlying veil cancels in Weber contrast (T^2 ratio); ===
=== oral = whole-body tan (site-specificity wall) ; masking != removal (reversible). ===
```

**해석**: [2] 의 C=0.822 *불변* 이 핵심 — 멜라닌 천장(0.40)까지 태워도 대비가 안 떨어진다. [4] 절대 gap 은 줄지만 0 이 되려면 온몸 칠흑(미용 부조리). [6] 경구 = 전신 → 100cm² 가리려 1.8m²(+얼굴) 태움 = **site-specificity 벽 재현**.

---

## 5. 정직 한계 요약 + tier

| # | claim | tier | 근거 |
|---|---|---|---|
| 1 | Weber 대비에서 균일 오버레이 veil(T²)이 약분 → C 불변 | 🔵 SUPPORTED-FORMAL | closed-form (§3 약분) |
| 2 | §4 recompute (T_epi·R·C·gap·area) | 🟢 SUPPORTED-NUMERICAL | verbatim |
| 3 | f_mel light 0.06 → dark 0.40 · μ_a,mel ~100/cm · L_epi 100µm | 🟡 SUPPORTED-BY-CITATION | Jacques 피부광학 · OMLC |
| 4 | 표피 멜라닌이 진피 잉크 *위*에 위치 (veil 기하) | 🟡 SUPPORTED-BY-CITATION | 잉크 진피 국재 · 멜라닌 표피 (FLIM·laser 문헌) |
| 5 | afamelanotide/melanotan = 펩타이드 · **경구 불가**(피하만) | 🟡 SUPPORTED-BY-CITATION | Scenesse 라벨 · melanotan 약리 |
| 6 | optical clearing μs'↓ = 국소·일시적 · 경구 전신 기전 부재 | 🟡 SUPPORTED-BY-CITATION | 글리세롤/HA clearing 문헌 |
| 7 | JND Weber fraction ~1–2% | 🟡 SUPPORTED-BY-CITATION | 시지각 contrast threshold |
| 8 | 경구 = 전신 → tattoo/body skin = 5.6e-3 (site-specificity 벽) | 🔵 SUPPORTED-FORMAL | 면적비 (§4 [6]) |
| 9 | in-vivo 실제 dR·색채 대비·미용 endpoint | 🟠 INSUFFICIENT | wet-lab (불필요 — 위 벽이 먼저) |

---

## 6. 정직 top-line 판정 (@D d2/d5/d6) — 두 벽을 탈출하나, site-specificity 벽에 걸리나?

- **물리 벽이 먼저 온다 (가장 정직한 발견)**: 오버레이 멜라닌 veil 은 잉크·주변을 *똑같은* T_epi² 로 어둡게 → **Weber 대비에서 T² 가 약분되어 C 불변** (sim [2]: f_mel 0.06→0.40 내내 C=0.822 ≫ JND 0.02). 탠은 화면을 균일하게 어둡게 할 뿐 어두운 패치는 비례적으로 그대로 보인다. ⇒ N5 의 ① 레버는 carbon/ADME 와 무관하게 **closed-form 으로 천장**.
- **레버 자체가 ADME 벽 재현**: 가장 강력한 tan 레버(afamelanotide·melanotan)는 *전부 펩타이드 = 경구 불가*(장 단백분해 — 프로그램의 ADME 펩타이드 벽 그대로). 경구 small-molecule tan 임상 부재. ② optical clearing 은 국소·일시 only.
- **site-specificity 벽 재현 (질문의 핵심)**: 설령 경구 tan 이 가능해도 **전신작용** → 100cm² 타투 가리려 ~1.8m² 전신(+얼굴/노출부) 을 태워야 함 (sim [6]: tattoo/body = 5.6×10⁻³). 즉 N5 는 **carbon-floor·ADME 벽을 site-specificity 벽으로 *맞바꿀* 뿐**이며, 사실 §3 의 물리 약분 때문에 그 전에 이미 막힌다.
- **masking ≠ removal**: 잉크는 그대로 남는다 → 탠이 빠지면(또는 클리어링이 사라지면) **대비가 돌아온다**(가역). W1(영구 cosmetic erase) 미충족.

⇒ **종합: N5 는 carbon-floor + ADME 두 벽을 *우회*하려 했으나, (a) 균일 오버레이 veil 의 Weber-대비 T² 약분(🔵 closed-form), (b) tan 레버의 펩타이드 경구-불가(= ADME 벽 재현), (c) 경구 전신성으로 인한 site-specificity 벽 재현, (d) masking≠removal(가역) — 네 겹으로 막힌다.** 정직 판정: **"두 벽을 탈출하지 못하고, *물리 약분*에 먼저 걸린 뒤 site-specificity·ADME 벽으로 회귀."** N5 의 유일한 잔존 가치는 *국소·일시* optical clearing 을 레이저 시술 *보조*(투과 깊이↑)로 쓰는 정도이며, device-free 경구 단독 masking 으로서는 🟠→사실상 NO-GO. (cf. N3 autophagy 가 "erase, not relocate" 를 노렸으나 기질 화학에 막힌 것과 같은 계열의 정직한 wall — N5 는 *기하/지각 물리* 에 막힌다.)**

---

## Sources
- 표피 멜라닌 광학·f_mel(light 0.06 / dark 0.40)·μ_a,mel·반사율 모델 — Jacques "Optics of Human Skin" (sciencedirect.com/science/article/pii/S0022202X15461251) · OMLC Skin Optics Summary (omlc.org/news/jan98/skinoptics.html) · OMLC Optical Absorption of Melanin (omlc.org/spectra/melanin/) · Jacques 2015 *J Biophotonics* quick melanin/blood analysis (onlinelibrary.wiley.com/doi/10.1002/jbio.201400103)
- 멜라닌 부피분율 skin-type 별(light 1.3–6.3% / moderate 11–16% / dark 18–43%) · 660nm 거동 — *What do we know about the epidermis' optical properties* (PMC13052491) · skin-color optical-property review (PMC10807857)
- 타투 잉크 진피 국재 · 멜라닌은 잉크를 *덮는* 표피층 · 파장별 멜라닌 흡수(532nm peak) — Tattoo pigment FLIM 국재 (researchgate 368529931) · OMLC Optical Depth of Pigmented Dermis (omlc.org/spectra/melanin/opticaldepth.html) · laser wavelength/melanin (mikemurphyblog.com/2023/11/04)
- Kubelka-Munk 피부 2-flux 모델 · 표피(멜라닌)/진피(콜라겐 산란) 층 파라미터 — KM skin reflectance (hal.science/hal-01080593) · Spectral KM human skin color (researchgate 247613094) · multispectral dermatology KM (PMC3789448)
- afamelanotide(Scenesse) MC1R agonist · **피하 임플란트(경구 불가)** · EPP 무통노출 +69% — Afamelanotide Wikipedia (en.wikipedia.org/wiki/Afamelanotide) · SCENESSE FDA label (accessdata.fda.gov/drugsatfda_docs/label/2024/210797s007lbl.pdf) · FDA NDA 210797 review · ScienceDirect Afamelanotide overview
- melanotan I/II 펩타이드 · α-MSH 분-단위 반감기 · 장 단백분해 → 피하주사 의존 · 경구 MC4R(bivamelagon)/PL-8177(전신 비흡수) — PeptideFox Melanotan (peptidefox.com/content/melanotan) · Melanotan-1 dosing (peptides.org/melanotan-1)
- 경구 콜라겐 펩타이드 → 진피 콜라겐/echo density↑ (RCT) — Asserin 2015 *J Cosmet Dermatol* (onlinelibrary.wiley.com/doi/10.1111/jocd.12174) · collagen density RCT (PMC6835901)
- optical clearing(굴절률 매칭·μs'↓·콜라겐 용해도) · 국소·일시성 · 콜라겐 RI 1.55 vs water 1.32 — Collagen solubility ↔ optical clearing (spiedigitallibrary.org/journals/.../10.1117/1.2220527) · HA-enhanced skin optical clearing (researchgate 303593454)
