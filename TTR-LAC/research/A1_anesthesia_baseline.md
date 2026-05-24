# TTR-LAC A1 — 현 국소마취 baseline + 율속단계 (rate-limiting step)

> ❄️ **TTR-LAC track A** — 레이저 타투제거 세션용 국소 마취 크림. 본 문서는 **현 표준**(EMLA·tetracaine·BLT·LMX)을 정량하고, onset 의 **율속단계 = 각질층(SC) 투과**를 first-principles(Fick lag time)로 보인다. sim = `sim/a1_lagtime.hexa`.

목표: A2-A5 가 부술 **3개 구체 결함**(느린 onset · 얕고 가변적 깊이 · 신뢰도)을 숫자로 못박는다.

---

## 1. 표준 국소마취제 baseline (🟡 SUPPORTED-BY-CITATION)

| 제제 | 조성 | onset | 폐색(occlusion) | 도달 깊이 | 신뢰도/가변성 | 최대 용량·면적 (LAST) |
|---|---|---|---|---|---|---|
| **EMLA** | lidocaine 2.5% + prilocaine 2.5% (eutectic 유상에멀젼) | **~60 min** (무폐색) · ~30 min (폐색) · 최대효과 2-3h | 권장 (속도·흡수↑) | 표피~진피~피하 (도포시간 의존; 1h 폐색 시 진피 도달) | **시간의존·매우 가변** (1h vs 2h vs 3h 깊이 상이) | 성인 ≤1300 cm²·~150 g, 3h까지. prilocaine→methemoglobinemia (o-toluidine; ~8 mg/kg) |
| **tetracaine** (amethocaine) | tetracaine 4% gel | ~30-45 min | 보통 폐색 | 진피 (ester, 고지용성·강력) | lidocaine보다 강·지속↑, 가변성 중간 | ester 가수분해, 접촉피부염↑ |
| **BLT** (compounded) | benzocaine 20% + lidocaine 6% + tetracaine 4% | ~20-30 min (benzo 표면 즉효) | 보통 무폐색 가능 | 표면(benzo)+중간(lido)+지속(tetra) 3단 | clinic마다 조성 가변·미규격 | **benzocaine methemoglobinemia** + lido/tetra LAST 가산 위험 (compounded 고농도) |
| **LMX** (LMX-4/5) | liposomal lidocaine 4-5% | **~30 min, 무폐색** | **불필요** (리포좀 투과↑) | 표피~상부진피 (EMLA 동등 깊이를 절반 시간에) | EMLA보다 편의·재현성↑ | lido 단일(prilocaine無→metHb 위험↓) |

**핵심 수치**: EMLA onset **~60 min(무폐색)**, 최대효과 **2-3 h** — 레이저 세션 워크플로(대기시간)의 병목.
LMX 가 **폐색 없이 ~30 min** 으로 절반 — 리포좀 = "전달 가속 enhancer"의 baseline 선례 (A2 출발점).

```
   onset-vs-time (무폐색, 도포→마취 가능 시점)
   BLT       ████░░░░░░  ~20-30 min  (benzo 표면 즉효 · 진피는 thin)
   LMX-4     █████░░░░░  ~30 min     (리포좀 · 폐색불필요)
   tetracaine ██████░░░░  ~30-45 min
   EMLA(폐색) █████░░░░░  ~30 min
   EMLA(무폐) ██████████  ~60 min    ← 표준 baseline 병목
              0   30   60 min
```

---

## 2. 율속단계 = 각질층(SC) 투과 — first-principles (🔵 closed-form)

피부 흡수의 직렬 저항 중 **각질층(stratum corneum, SC ~10-20 μm, 죽은 각질세포 + 세포간 지질 라멜라)** 이 압도적 병목.
투과는 수동 Fick 확산 → 정상상태 flux 도달 전 **확산 지연시간(lag time)** 이 onset 을 지배:

```
t_lag = h² / (6 D)        (유한 슬래브 transient 해의 lag 항)
  h = SC 확산경로 두께  [cm]   (기하 10 μm; 굴곡 라멜라 경로는 실효 >10 μm)
  D = 약물 SC 확산계수   [cm²/s] (lidocaine in SC ~1e-10; 지용성 1e-9..1e-11)
지각 가능한 차단(block)은 ~1-2 × t_lag (슬래브가 정상상태로 채워지는 시정수).
```

D 가 **세제곱 단위로** onset 을 좌우(t_lag ∝ h²/D): D 가 한 자릿수 변하면 onset 도 한 자릿수 변동 → **EMLA의 큰 환자간 가변성의 물리적 근원**(SC 두께·수화·지질조성 개인차).

### hexa-native recompute (verbatim · 🟢 · per @D g5)

```
=== TTR-LAC A1 — SC permeation lag time + depth falloff (first-principles) ===

model: t_lag = h^2/(6 D) ;  onset ~ 1..2 x t_lag (perceptible block)

[1] t_lag = h^2/(6D) in MINUTES (h in um, D in cm^2/s):
  D=1.0e-9  : h=10um 2.77778 h=15um 6.25 h=20um 11.1111
  D=1.0e-10 : h=10um 27.7778 h=15um 62.5 h=20um 111.111
  D=1.0e-11 : h=10um 277.778 h=15um 625.0 h=20um 1111.11

[2] central estimate (lidocaine in SC, D=1e-10 cm^2/s, h=10um):
  t_lag       = 27.7778 min
  onset 1*tlag= 27.7778 min
  onset 2*tlag= 55.5556 min  <- matches clinical ~60min (EMLA no-occlusion)

[3] onset (=2*t_lag, h=10um) vs effective D (occlusion/enhancer raise D):
  D=0.5e-10 (dry)      : 111.111 min
  D=1.0e-10 (baseline) : 55.5556 min
  D=3.0e-10 (occluded) : 18.5185 min
  D=1.0e-9  (enhancer) : 5.55556 min

[4] depth falloff C(z)/C_surf = exp(-z/lambda), lambda=40um (epidermal-weighted):
  z=15um  (SC exit)              : 0.687289
  z=50um  (mid viable epidermis) : 0.286505
  z=100um (dermo-epidermal jx)   : 0.082085
  z=150um (upper dermis plexus)  : 0.0235177
  z=200um (dermal free endings)  : 0.00673795

[5] dermal reach: C at 150-200um (laser-pain free endings) as % of surface:
  150um: 2.35177 %
  200um: 0.673795 %  <- <1%: anesthesia is epidermal-weighted, dermal-thin

=== onset ~56min (2*t_lag, D=1e-10, h=10um); dermal free-ending reach <1% of surface ===
=== rate-limiting parameter = SC diffusivity D (t_lag ~ 1/D); occlusion/enhancer raise D ===
```

**해석**: 중심 추정(lidocaine D=1e-10, SC h=10 μm)에서 t_lag=**27.8 min**, onset≈2×t_lag=**55.6 min** — 임상 EMLA 무폐색 **~60 min 과 정합**. 즉 onset 은 SC 확산 지연시간이 *완전히 설명*한다(약물 친화도·신경 약리 아님).
[3]: D 를 occlusion(수화→지질 fluidization, ~3×)으로 올리면 onset **56→19 min**, 강한 enhancer(D~1e-9, 10×)면 **~6 min** → **A2 의 정량 표적 = D 를 올려라**.

---

## 3. 깊이: 진피 자유신경말단에 실제로 닿는가? (🟡 + 🔵 모델)

레이저 타투제거 통증을 나르는 nociceptor:
- **자유신경말단(free nerve endings)** = 무수초 C섬유 + 얇은수초 Aδ섬유 종말. 표피 깊은층~표피전층까지 침투(일부는 stratum granulosum 까지), 그러나 본체 신경총(plexus)은 **유두진피~상부진피(~100-200 μm+)** 에 위치.
- 레이저 열펄스는 표재 nociceptor(Aδ·C)를 선택 자극 — 통증 발생 깊이는 **표피 심부 + 진피-표피 경계(DEJ, ~100 μm) 및 상부진피**에 걸침.

```
   skin layers (깊이 μm)        약물 C(z)/C_surf  [sim §4]
   0    ─ vehicle 표면 ─         1.00
   10-20  stratum corneum(SC) ▓  0.69  (SC 출구; 율속 장벽)
   50   viable epidermis     ░  0.29
   100  dermo-epidermal jx   ·  0.082  ← Aδ 표재 nociceptor 다수
   150  upper dermis plexus  ·  0.024  ← 진피 자유신경말단 (2.4%)
   200  dermal free endings  ·  0.0067 ← (<1%, 0.67%)
```

**정량 결론**: 표피층(≤50 μm)은 surface 의 ~30-70% 농도로 충분히 차단 → **표피성 마취는 신뢰**.
그러나 진피 자유신경말단(150-200 μm)에는 surface 의 **2.4% → 0.67%** 만 도달(지수 감쇠, λ~40 μm) → **진피 차단은 thin·확률적**. 레이저 통증의 진피 성분은 baseline 크림이 *부분적으로만* 막음. (λ 절대값은 partition·실효 D 의존 → 🟡 정성, 감쇠 *형태*는 🔵.)

---

## 4. 정직한 baseline verdict + tier (per @D d5/d6)

| claim | tier |
|---|---|
| t_lag = h²/(6D) · onset~1-2 t_lag · 지수 depth 감쇠 형태 | 🔵 closed-form |
| §2-§3 hexa recompute (verbatim) | 🟢 numerical |
| EMLA ~60min·≤1300cm²·metHb · LMX 30min 무폐색 · BLT 20%/6%/4% · tetra 4% · D~1e-10 · nociceptor 깊이 | 🟡 문헌 (FDA label · 리뷰 · 신경해부) |
| λ(depth decay length) 절대값 · BLT compounded 정확 onset · 진피 nerve-block 확률 | 🟠 (A3/A5 PK 실측) |

> **baseline verdict**: 현 표준은 **표피성·느림·가변** — EMLA onset **~60 min**(무폐색), 진피 자유신경말단 도달 **<1%**, 율속 = **SC 확산계수 D**(onset ∝ 1/D, 개인차의 물리적 근원). LMX 가 폐색없이 ~30 min 으로 절반을 이미 보여줌 = D 를 올리면 onset 이 떨어진다는 baseline 증거. absorbed=false 유지.

### A2-A5 가 부술 3개 구체 결함

1. **느린 onset (~60 min)** — 율속 = SC 확산계수 D. sim §3: D 를 3×(occlusion)→19 min, 10×(enhancer)→6 min. ⇒ **A2** = enhancer·liposomal·eutectic·supersaturation 로 D↑ → onset ≤20 min 목표.
2. **얕고 가변적 깊이** — 진피 자유신경말단에 surface 의 0.67-2.4% 만 도달(λ~40 μm 지수감쇠). ⇒ **A3** = 진피 도달 농도↑ + vasoconstrictor(epi) trade-off 로 진피 nerve-block 확실성↑.
3. **신뢰도/가변성** — onset ∝ 1/D 인데 SC 두께·수화·지질조성이 개인차 → 깊이·시간 편차 큼(EMLA 1h/2h/3h). ⇒ **A4/A5** = 제형(마취제∩enhancer∩vehicle) 최적화 + LAST 안전한계 내 PK 시뮬(SC 투과+신경농도)로 재현성 정량.

---

## Sources
- EMLA (lidocaine 2.5%/prilocaine 2.5%) FDA label — onset 1h, 최대 2-3h, ≤1300 cm²/150 g, metHb (accessdata.fda.gov/drugsatfda_docs/label/2018/019941s021lbl.pdf · drugs.com/pro/emla.html)
- EMLA-induced methemoglobinemia & systemic toxicity — *J Emerg Med* (sciencedirect.com/science/article/abs/pii/S0736467903002944)
- Review of lidocaine/tetracaine cream for dermatologic laser procedures — *PubMed* 25135033 (pubmed.ncbi.nlm.nih.gov/25135033)
- BLT (benzocaine 20%/lidocaine 6%/tetracaine 4%) compounded topical anesthetic — Empower Pharmacy · Fagron Academy · LMX4-vs-BLT fractional resurfacing trial NCT01842373 (clinicaltrials.gov/study/NCT01842373)
- LMX-4 liposomal lidocaine 30 min 무폐색 vs EMLA 60 min — PEMCincinnati · USPharmacist topical anesthesia in children
- Lidocaine SC diffusivity ~1e-10 cm²/s; iontophoresis 가속 — UCSD BENG221 diffusion model · *Int J Dermatol* 2018 (onlinelibrary.wiley.com/doi/10.1111/ijd.14107) · *Sci Data* 2024 skin permeability review (nature.com/articles/s41597-024-03026-4)
- Free nerve endings / Aδ·C nociceptor 깊이 (표피 심부~상부진피), 레이저 열펄스 표재 nociceptor 선택 자극 — en.wikipedia.org/wiki/Free_nerve_ending · NCBI Bookshelf NBK11162 · *PubMed* 16086989 (papillary dermis nerve density)
- (재현) `TTR-LAC/sim/a1_lagtime.hexa` — `hexa run TTR-LAC/sim/a1_lagtime.hexa`
