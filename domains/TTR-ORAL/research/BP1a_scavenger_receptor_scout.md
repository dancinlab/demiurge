# TTR-ORAL — BP1a: 경구 scavenger-receptor 길항제 발굴 scout

> 🦠 **TTR-ORAL** — "면역세포 택배"
> BP1 이 환원한 발굴 타겟 = **무른 잉크 입자 재포획(r↓)의 *올바른* 수용체** = macrophage scavenger receptor.
> 이 task = 그 수용체 동정 + **경구 small-molecule 길항제 존재 여부** 정직 검증. sim = `sim/bp1a_sr_blocker_beta.hexa`.

---

## 1. 어떤 scavenger receptor 가 무른/탄소/색소 입자 재포획을 매개하나

```
   수용체              별칭                   inert/색소 입자 매개 증거
   ─────────────────────────────────────────────────────────────────────
   MARCO         SR-A6 / SCARA2     ★ 비-옵소닌 무른입자(TiO₂·Fe₂O₃·silica·latex
                                       비드) 결합의 *주* 수용체. mAb 차단 → 흡수
                                       극적 감소. 음전하 표면을 양전하 collagenous
                                       domain 으로 인식 (잉크 입자 = 음전하).
   SR-A1/MSR1    SCARA1 / CD204     ★ 탄소나노튜브 흡수 매개 — SR-A1 결손
                                       macrophage 는 carboxyl-MWCNT 흡수 실패.
                                       modLDL·LPS·polyanion 도 인식.
   CD36          SR-B2              산화LDL·지방산 중심. 무른 색소 입자 기여 작음.
   SCARA5        —                  상피/ferritin 중심. 색소 입자 증거 빈약.
   ─────────────────────────────────────────────────────────────────────
   ⇒ 잉크-유사 입자(음전하 탄소/안료) 재포획의 dominant = MARCO + SR-A1(MSR1).
```

- 주의: 문헌 다수가 **alveolar(폐) macrophage** 측정 — *dermal* tattoo-laden 특이 receptor profile 직접측정은 빈약(🟠 gap). 단 입자 화학(음전하 안료) → MARCO/SR-A 인식 기전은 조직 불문 보존.
- 별개 마커 혼동 주의: 2024 문헌의 색소-보유 dermal macrophage 표현형 마커 = **CD64⁺**(FcγRI, *phenotype* 마커). 그러나 무른 입자 *흡수기전* 은 FcγR-매개 아님(BP1 결론과 일치) — **scavenger-receptor / 일반 phagocytosis**.

---

## 2. 길항제 — modality · route · 단계 (정직)

```
   blocker             표적         modality        route      단계         oral?
   ───────────────────────────────────────────────────────────────────────────────
   anti-MARCO mAb      MARCO        항체(IgG)       비경구     전임상~임상  ✗ biologic
    (PY265, Pionyr)                                 (i.v.)     (종양 TAM)
   anti-SR-A/MSR1 mAb  SR-A1        항체            비경구     연구툴       ✗ biologic
   fucoidan            SR-A         sulfated        경구가능   보충제/전임상 △ BA<<낮음
                                    polysaccharide  but 흡수↓                (분자량·음전하)
   poly(I) / dextran   SR-A         polyanion       비경구     연구툴       ✗
    sulfate            ligand-competitor (in-vitro)
   SSO (sulfo-N-       CD36         공유결합 SM      비경구     연구툴       ✗ "poorly
    succinimidyl oleate)                                                      bioavailable"
   rhein               SR-A         small molecule  경구       FDA(diacerein ✓ (BA 89%
    (= diacerein 활성대사체)        (anthraquinone) ✅        2008, OA)      via diacerein)
   berberine 계열      MSR1/SR-A    alkaloid SM     경구       전임상       △ BA 낮음
                       (LPS endocytosis 차단)       (sepsis)               (~<1% 흡수)
   ───────────────────────────────────────────────────────────────────────────────
```

핵심:
- **高-β(≥0.8) 차단 = 전부 비경구** — anti-MARCO mAb(PY265) · polyanion ligand-경쟁자(fucoidan/poly(I)/dextran sulfate, in-vitro phagocytosis 48-87% 억제이나 정맥/시험관). device-free 경구 위반.
- **유일한 경구 small molecule with *any* SR-A 활성 = rhein** — sennoside B 분해유사체로 동정된 *최초* SR-A small-molecule inhibitor(2015 lead). 경구 prodrug **diacerein**(FDA 2008, OA)이 전신순환 전 rhein 으로 전환(상대 BA 89%). 단 (a) diacerein 의 SR-A 차단은 *off-target* — 승인 적응증은 IL-1β 억제(OA)이고 dermal 색소 재포획 β 는 *미실측*, (b) rhein 단독은 용해도/BA 열위 → diacerein 경유 필요.
- berberine = MSR1 endocytosis 차단 보고(sepsis 맥락)이나 경구 BA 극저 + 색소 데이터 없음.

---

## 3. hexa recompute — 경구 후보의 현실 β → 타임라인 (verbatim · 🟢)

```
=== TTR-ORAL BP1a: oral SR-A blocker realistic beta -> timeline (T=28d) ===

beta(SR-A차단)  r(recapture)   k_eff    phi      n90     months   credible-oral-modality
  0.20        0.938272  0.0508642  0.0126355  181.077  166.782  fucoidan/berberine (poor BA)
  0.40        0.919355  0.0603226  0.0149675  152.685  140.631  diacerein->rhein (FDA oral)
  0.60        0.883721  0.0781395  0.0193453  117.87  108.565  optimized SM lead (TO DEVELOP)
  0.85        0.74026  0.14987  0.0367743  61.4555  56.6037  anti-MARCO mAb (biologic·non-oral)
```

```
   경구 후보 β            timeline        modality 현실
   0.20  ██████████ 167mo  fucoidan/berberine  △ BA<<낮음 → in-situ β 더 낮을 듯
   0.40  █████████ 141mo   diacerein→rhein     ✓ 경구이나 anti-SR-A off-target·미실측
   0.60  ███████ 109mo     optimized SM lead   ✗ 아직 없음 (BP1a 발굴 타겟)
   0.85  ████ 57mo         anti-MARCO mAb       ✗ biologic (device-free 위반)
```

- 정직: 현존 경구 후보(β≤0.4)는 단독 **여전히 多년(11-14yr 규모, T=28d)**. CSF1R 펄스(k_death)와 합쳐도 sub-year 불가 — BP1/M9 천장과 정합.
- β≥0.85(57mo)는 anti-MARCO **항체** 수준 = 경구 아님. 경구로 그 영역 도달 = 미존재 SM lead 개발 필요.

---

## 4. 정직한 gap verdict (@D d6 · d2)

**경구 small-molecule scavenger-receptor 길항제는 — 임상검증된 형태로 존재하지 않는다.** 가장 근접한 3 후보:

| 순위 | 후보 | 근거 | 결정적 결손 | tier |
|---|---|---|---|---|
| 1 ⭐ | **diacerein → rhein** (repurpose) | FDA 경구(2008) · rhein = *최초* SR-A SM inhibitor · BA 89% | anti-SR-A = off-target · dermal 색소 β *미실측* · BA/용해도 열위 | 🟡 (경구 사실 · 잉크효능 미실측) |
| 2 | **rhein scaffold 최적화 SM** (BP1a 진짜 발굴 타겟) | anthraquinone scaffold SAR 출발점 명확(danthron·tannic acid docking lead 동족) | 합성·SAR·dermal β 전부 미개발 — *de novo* lead opt | 🟠 (발굴 타겟) |
| 3 | **berberine / 低분자 fucoidan** | 경구 가능 · SR-A/MSR1 ligand-경쟁 | BA 극저(<1~2%) → 진피 in-situ β 더욱 낮을 것 | 🟠 |

**단일 최고-신뢰 개발 경로** = **rhein anthraquinone scaffold 의 SR-A(MARCO/MSR1)-선택적 경구 SM lead 최적화** — 이미 경구·SM·SR-A 활성 골격이 손에 있으므로(de novo 아님), 남은 일은 (a) dermal 색소-재포획 차단 β 실측, (b) MARCO/MSR1 선택성 SAR, (c) 진피 분포·BA 개선. 즉 BP1a = "scaffold 有 → 효능·선택성 검증" 문제로 환원 (백지 발굴 아님).

**선택성/안전(필수 경고)**: SR-A/MSR1 결손 마우스는 Listeria·HSV-1 감염 취약 + 내독소쇼크 방어 상실 — **전신·만성 SR-A 차단 = 숙주방어/항-atherosclerosis 손상 위험**. 완화책 = **펄스/한시 투여**(CSF1R 펄스창에 동기 = 노출 최소화) + 가능하면 진피국소 노출. 만성 monotherapy 부적합.

---

## 5. tier

| claim | tier |
|---|---|
| MARCO(SR-A6) + SR-A1/MSR1 = inert/탄소/색소 입자 재포획 dominant 수용체 | 🟡 (Arredouani PMC2193067 · Kanno PMC7761752 · MARCO mAb 차단실험) |
| 경구 SM SR-A 길항제 임상검증 부재 · 高-β 전부 비경구 | 🟡 (mAb/polyanion 문헌 · 음성결과 = 부재 plain) |
| rhein = 최초 SR-A SM inhibitor · diacerein 경구 FDA(BA 89%) | 🟡 (Bioorg Med Chem Lett 2015 PMC4494979 · Clin PK diacerein) |
| dermal tattoo-laden 특이 receptor profile · diacerein/rhein 의 잉크-색소 β | 🟠 (직접 미실측 — 발굴 타겟) |
| β→r→timeline recompute | 🟢 verbatim (§3) |
| 전신 SR-A 차단 숙주방어/atherosclerosis 위험 · 펄스 완화 | 🟡 (MSR1 KO Nature 386:292 · Front Immunol 2022) |

> **BP1a 결론**: 잉크 재포획의 올바른 수용체 = **MARCO/MSR1** 확정. 그러나 **임상검증된 경구 SR-A 길항제는 부재** — 高-β 차단제는 전부 항체/polyanion(비경구). 닫힌 부정 아님: **diacerein→rhein(이미 경구 FDA·SR-A 활성)** 가 repurpose 출발점, 진짜 device-free lever 는 **rhein scaffold 기반 MARCO/MSR1-선택 경구 SM lead 최적화 + dermal β 실측**(펄스 투여로 숙주방어 위험 완화). absorbed=false 유지.

---

## Sources
- Arredouani et al. — MARCO = 폐 macrophage 비-옵소닌 무른입자(TiO₂/Fe₂O₃/silica/latex) 주 수용체, mAb 차단 — *J Exp Med* (PMC2193067) · *J Immunol* 2005 (PubMed 15263032)
- Kanno et al. — carboxyl-MWCNT 흡수는 class-A SR(SR-A1) 의존, SR-A1 결손 시 흡수 실패 — PMC7761752
- 잉크/탄소 입자 SR 인식 일반 — *Toxicol Appl Pharmacol* MARCO/CNT (S0041008X11004698) · polystyrene NP MARCO 인식 (PubMed 17361018)
- 색소-보유 dermal macrophage = CD64⁺ phenotype · capture-release-recapture — Lin et al. *Immunology* 2024 (onlinelibrary.wiley.com/10.1111/imm.13714)
- rhein = 최초 SR-A SM inhibitor (sennoside B 분해유사체, poly(I:C)/IRF3·STAT1 억제) — *Bioorg Med Chem Lett* 2015 (PMC4494979) · docking(rhein/tannic acid/danthron) (PMC5696021)
- diacerein 경구 PK / rhein 활성대사체 · 상대 BA 89% / FDA 2008 OA — *Clin Pharmacokinet* 1998 (link.springer.com/article/10.2165/00003088-199835050-00002) · rhein review (mdpi 1424-8247/17/12/1665)
- anti-MARCO mAb PY265 (Pionyr, 비경구 종양 TAM) — Businesswire SITC 2022 · *Cell Rep* 2016 (S2211-1247(16)30529-0) · PNAS 2020 (10.1073/pnas.2015343117)
- polyanion SR-A blocker (fucoidan/poly(I)/dextran sulfate, in-vitro 48-87% phagocytosis 억제) — *J Immunol* decidual (journals.aai.org/.../83111) · SR-A overview (ScienceDirect)
- fucoidan 경구 BA 낮음(음전하·고분자량) · 低-MW 개선 — *Int J Pharm* (S0378517321001757) · *Mar Drugs* (PMC4584361)
- CD36 SSO 공유결합·"poorly bioavailable" — *J Biol Chem* 2013 (PMC3668716)
- berberine MSR1 LPS-endocytosis 차단 (sepsis) — MSR1 review *Front Immunol* 2022 (10.3389/fimmu.2022.1012002)
- SR-A/MSR1 KO 감염취약(Listeria·HSV-1)·내독소쇼크 — Suzuki et al. *Nature* 1997 (386:292) · *J Exp Med* (PMC2199123)
