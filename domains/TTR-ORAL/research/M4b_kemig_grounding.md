# TTR-ORAL — M4b: 실측-grounded k_emig + S1P 레버 방향 정직 점검 (track B2)

> 🦠 **TTR-ORAL** — "면역세포 택배"
> 목표: M5/M4 가 **가정**한 `k_emig ~0.30/mo` (자연 ~0.02/mo 대비 **~15×**) 이 실측에 의해 지지되는지, 그리고
> B2 의 대표 agent (ozanimod/fingolimod/etrasimod = S1P1 modulator) 이 *실제로* k_emig 를 올리는지(방향) grounding.
> 결론 선공개: **~15× 미지지 · S1P 는 wrong-sign · tattoo RM 은 sessile** → k_emig 노브 자체를 정정한다.
> sim = `sim/m4b_kemig.hexa`.

---

## 1. 문헌 실측값 (🟡 SUPPORTED-BY-CITATION)

| 파라미터 | 실측값 | 출처 |
|---|---|---|
| tattoo-laden 진피 macrophage 의 dLN 이주 | **이주 안 함 — 국소 보유** (pigment 사망 시 release→neighbor recapture; 영구성은 *renewal* 로 유지) | Baranska 2018 (J Exp Med) |
| 자연 capture-release-recapture 사이클 | ~90 일 (느린 림프 drainage 가 자연 fade) | Baranska 2018 · ScienceDaily |
| CCR7-axis 진피 DC egress 천장 | **CCR7-KO skin-explant DC egress = WT 의 3–4×** (24/48h, steady-state) | Ohl 2004 (Immunity) |
| CCR7 = 진피 림프관 진입 필수 매개 | CCR7/CCL21 = 진피·표피 DC 의 afferent lymphatic 진입 게이트 | Ohl 2004 · Russo 2016 (Cell Rep) |
| S1P1 modulator (fingolimod/ozanimod/etrasimod) MoA | **functional S1PR1 ANTAGONIST** (지속 internalization) → 림프구가 LN egress gradient 못 읽음 → LN 에 **trap** (혈중 림프구 50–65%↓) | Chun 2017 (Neurotherapeutics) · etrasimod P369 |
| S1P modulator 의 *skin DC* 효과 | **FTY720·S1P 가 skin DC 의 dLN 이주를 INHIBIT** (auricular dLN weight·DC 수↓; CCR7 downreg) | Reines 2009 (ACD) · Han 2015 (CIA) · Czeloth 2005 |
| S1P gradient 의 작동 방향 | S1P 高=혈/efferent lymph, 低=조직/LN parenchyma → S1P1 은 **세포를 조직 밖→순환**으로 끌어냄 (egress) | Cyster 2012 · Schwab 2005 |

⇒ 핵심 두 가지: (a) **CCR7 천장 = 3–4×** (이것이 emigration 의 문헌 상한). (b) **S1P modulator 는 egress 를 *막는* 약** (functional antagonist) — 게다가 *skin DC→dLN* 이주를 직접 억제 (Reines/Han).

---

## 2. 정직한 방향 점검 — B2(S1P) 선택은 wrong-sign 인가? (핵심)

```
   도메인이 원하는 것:  pigment-load 세포의 진피→dLN 이주 ↑  (k_emig↑)
   ───────────────────────────────────────────────────────────────
   S1P gradient 실체:  S1P1 활성 = 세포를 LN/조직 밖 → 순환(egress)으로
   fingolimod 작동:    functional ANTAGONIST → S1P1 internalize → 세포가
                        gradient 못 읽음 → LN 에 갇힘 (egress 차단)
   skin DC 실측:        FTY720/S1P → skin DC 의 dLN 이주 INHIBIT (Reines2009)
   ⇒ S1P modulator 는 k_emig 를 *내린다* (↓0.3–0.5×).  방향이 반대.
```

추가 결정타 — **tattoo RM 은 애초에 migratory 가 아니다.** Baranska 2018: pigment 든 진피
macrophage 는 "do NOT migrate to LN, retain locally". S1P/CCR7 축은 *migratory DC* 의 게이트지
**sessile resident-macrophage 의 노브가 아님** → S1P modulator 든 CCR7 든 *그 세포에는* k_emig 가 ~0 근처.

| 점검 질문 | 답 | tier |
|---|---|---|
| S1P modulator 가 림프구 egress 를 올리나? | **아니오 — functional antagonist, egress 차단** | 🟡 (Chun2017·etrasimod) |
| S1P modulator 가 skin DC 의 dLN 이주를 올리나? | **아니오 — 직접 INHIBIT** | 🟡 (Reines2009·Han2015) |
| tattoo pigment RM 이 S1P/CCR7 축으로 이주하나? | **아니오 — sessile, 국소보유** | 🟡 (Baranska2018) |
| 그럼 k_emig 의 *실제* 노브는? | **CCR7/CCL21 agonism (migratory 화) · OR k_death(CSF1R-pulse repopulation)** | 🟠 |

> **B2(S1P) 는 k_emig 레버로서 wrong-sign.** M4 의 B2 행이 인용한 "S1P egress 3-5×(Cyster)" 는
> *S1P 자체* 의 egress 촉진치이지 **modulator(=antagonist) 의 효과가 아님** — modulator 는 그 gradient 를 *끈다*.
> M4 tier ledger #6 ("3-5× egress boost 🟢") 은 **방향 혼동**이며, agent 를 modulator 로 쓰면 부호가 뒤집힌다.

---

## 3. 모델 (M5 위에 grounding)

```
k_eff = k_emig + (1-r)*k_death     [1/mo]   (M5; r=0.5, k_death=0.35/mo 고정)
phi   = 1 - exp(-k_eff*tau_win)              (tau_win=0.25 mo on-time)
n90   = log(0.1)/log(1-phi)                  (90% skin clearance 펄스 수)
```

k_emig 시나리오: 자연 0.02 · CCR7 3–4× (0.06–0.08, **문헌 천장**) · 가정 15× (0.30) · S1P 0.3–0.5× (wrong-sign) · sessile(0).

## 4. hexa-native recompute (verbatim · 🟢 SUPPORTED-NUMERICAL · per @D d5)

```
=== TTR-ORAL M4b k_emig grounding (track B2) ===

model: k_eff=k_emig+(1-r)*k_death ; phi=1-exp(-k_eff*0.25) ; n90=log(0.1)/log(1-phi)

[1] k_emig scenarios (1/mo) -> k_eff -> per-pulse phi -> n90:
  natural k_emig=0.02 (1x)      k_eff=0.195 phi=0.0475808 n90=47.2325
  CCR7 3x  k_emig=0.06          k_eff=0.235 phi=0.0570575 n90=39.1929
  CCR7 4x  k_emig=0.08          k_eff=0.255 phi=0.0617605 n90=36.119
  ASSUMED 15x k_emig=0.30       k_eff=0.475 phi=0.11197 n90=19.3902

[2] S1P modulator on MIGRATORY (DC/leukocyte) k_emig — egress INHIBITOR:
  S1P 0.3x k_emig=0.006         k_eff=0.181 phi=0.0442415 n90=50.8859
  S1P 0.5x k_emig=0.010         k_eff=0.185 phi=0.0451968 n90=49.7856

[3] sessile pigment-RM scenario (Baranska): k_emig ~ 0 — lever drives k_death/r only:
  k_emig=0 (only turnover/r)    k_eff=0.175 phi=0.0428068 n90=52.6305

[4] k_eff fold vs natural (what the 15x k_emig CLAIM buys after other knobs):
  natural        k_eff=0.195 fold=1.00
  CCR7 3-4x      k_eff=0.235-0.255 fold=1.20513-1.30769
  ASSUMED 15x    k_eff=0.475 fold=2.4359
  S1P (0.3-0.5x) k_eff=0.181-0.185 fold=0.928205-0.948718

[5] fade t90 = n90 * T  (monthly pulse, T=1 mo):
  CCR7 4x  : 36.119 months
  15x      : 19.3902 months
  S1P 0.5x : 49.7856 months (SLOWER than natural-ish — wrong lever)

=== verdict: 15x k_emig is UNSUPPORTED (lit ceiling 3-4x via CCR7); ===
=== S1P modulator is WRONG-SIGN for migratory egress; tattoo RM are sessile. ===
=== real k_emig knob = CCR7/CCL21 agonism OR k_death (CSF1R-pulse repopulation). ===
```

## 5. 정직한 발견 (@D d6 — 낙관 강제 금지)

```
   k_emig 가정 vs 문헌 실측 (k_eff fold, 자연=1.00 기준)
   S1P 0.5x   ▏        0.95×   ✗ 역행 (k_emig↓ — wrong sign)
   sessile    ▏        0.90×   ✗ tattoo RM 은 이주 안 함 (lever 무력)
   natural    █        1.00×
   CCR7 3-4x  █▏       1.21-1.31× ✓ 문헌-bounded 상한
   가정 15x   ██▌      2.44×    ⚠ 미지지 (k_emig 단독으론 비현실)
```

- **가정 15× 는 미지지.** k_emig 의 문헌 천장은 CCR7-KO egress 비교가 보여주는 **3–4×** (Ohl 2004) — 15× 는 이 천장을 ~4–5배 초과. (참고로 k_emig 가 15× 여도 k_death=0.35 항이 dilute 해서 k_eff 는 2.44× 에 그침 → n90 47→19; M5 가 인용한 n90~30(emig only) 보다 *낙관*이며 절대 시한도 ~19개월로 길다.)
- **S1P modulator 는 k_eff 를 *낮춘다*** (0.95×, n90 47→50). fingolimod/ozanimod/etrasimod 는 egress *억제*제 → skin DC 이주를 막아 k_emig 가 0.3–0.5× → fade 가 오히려 **느려진다**. B2 의 agent 선택이 목표와 부호 반대.
- **tattoo RM 은 sessile** (Baranska): pigment 든 세포는 dLN 으로 *안 간다*. 따라서 "k_emig↑ via S1P/CCR7" 라는 명제 자체가 *그 세포 클래스* 에는 적용 안 됨. fade 는 capture-release-**recapture** 중 *recapture 차단(r↓)* + *renewal turnover(k_death)* 로 free pigment 의 림프 drainage 확률을 높이는 경로로 일어난다.
- **정정된 k_emig 노브** (정직한 상향-가치 발견):
  1. **CCR7/CCL21 agonism** = 진짜 emigration 노브 (천장 3–4×) — 단 임상약 부재(M4 gap #11) → 🟠.
  2. **k_death (CSF1R-pulse repopulation)** = M9 에서 grounding 된 실제 작동 경로 — pigment RM 사망→free pigment→recapture 전에 림프 drainage (Baranska 의 "macrophage ablation + laser → drainage↑" 정합). **이쪽이 B-track 의 실효 노브.**
  3. **r↓ (recapture 억제)** = clodronate/CSF1R pulse 의 window 효과 (M9 의 τ_rec 경로와 동일).

## 6. tier + verdict 갱신

| claim | tier |
|---|---|
| k_eff=k_emig+(1-r)k_death · phi · n90 식 | 🔵 closed-form |
| §4 recompute (모든 시나리오) | 🟢 verbatim hexa run |
| CCR7 egress 천장 3–4× · S1P modulator=egress 억제 · tattoo RM sessile | 🟡 문헌 (Ohl2004·Reines2009·Han2015·Baranska2018) |
| 가정 k_emig 15× | 🟠→🔴 **미지지/방향오류** — 문헌 천장 3–4× 의 ~4–5배 초과 + S1P 면 부호 역전 |
| CCR7 agonist 실재 dose · dermal-특이 k_emig 절대값 · per-pulse φ | 🟠 (M8/M9 wet-lab) |
| grounded thesis | ⚪ fence (verbatim 별도) |

> **k_emig verdict**: "🟢 3-5× egress boost (가정 15×)" → **"🟡 CCR7-bounded 3–4× 천장 · S1P modulator 는 wrong-sign · tattoo RM 은 sessile"**.
> M4 의 **B2(S1P) LEAD 지정은 정정 필요** — S1P1 modulator 는 emigration 가속이 아니라 *억제*제다.
> B-track 의 실효 k_eff 노브는 **B1(CSF1R-pulse, k_death) · r↓(recapture 차단)** 이며, k_emig 의 유일한 *순방향* 약리 노브는
> CCR7/CCL21 agonism (임상약 부재 🟠). absorbed=false 유지 (정정된 노브의 dose·dermal-특이 효과 미실측).

## 7. M8/M9 가 좁혀야 할 측정 (정정판)

1. **CCR7 agonism 의 dermal pigment-cell egress 효과** (또는 그런 agonist 실재성) — k_emig 순방향 노브 검증.
2. **CSF1R-pulse 후 free-pigment 의 림프 drainage 분율** (Baranska ablation+laser 정합) — B1 의 k_death 경로가 B-track 실효 노브임을 정량.
3. (불변) **per-pulse φ** 절대값 — 펄스 1회당 잉크 release 분율.

⇒ 비-wet-lab grounding 으로 B-track 의 노브를 "S1P 로 k_emig 15×↑(낙관·방향오류)" → **"CCR7 천장 3–4× + 실효는 k_death/r 경로, S1P 는 빼라"** 로 정직하게 정정.

---

## Sources
- Baranska et al. 2018, *J Exp Med* 215(4):1115 — tattoo pigment macrophage capture-release-recapture; pigment RM 은 LN 이주 안 함·국소보유·renewal 로 영속 (rupress.org/jem/article/215/4/1115)
- Ohl et al. 2004, *Immunity* 21(2):279 — "CCR7 Governs Skin DC Migration"; CCR7-KO skin-explant DC egress = WT 3–4× (steady-state) (cell.com/immunity/fulltext/S1074-7613(04)00201-8)
- Reines et al. 2009 — topical S1P/FTY720 가 ACD 에서 skin DC→dLN 이주 INHIBIT (pubmed 19194476)
- Han et al. 2015 — FTY720 가 CIA 에서 DC 의 local dLN 이주 차단 (CCR7 downreg) (pubmed 26416269)
- Chun et al. 2017, *Neurotherapeutics* — S1PR modulator = functional S1PR1 antagonist → 림프구 LN sequestration (PMC5722770)
- etrasimod P369 / IBD reviews — ozanimod 65%·etrasimod ~50% 혈중 림프구 lowering (functional antagonist) (PMC9666818)
- Cyster & Schwab 2012, *Annu Rev Immunol* — S1P gradient (혈/lymph 高, LN parenchyma 低) = egress 방향 (PMC5985508 관련)
- Russo et al. 2016, *Cell Rep* — intralymphatic CCL21 가 진피 DC 의 afferent lymphatic egress 촉진 (cell.com/cell-reports/S2211-1247(16)30026-2)
- Inserm/JEM 해설 2018 — macrophage ablation + laser → 즉시 recapture 차단 → 림프 drainage 확률↑ (presse.inserm.fr/en/tattoos-are-they-really-indelible)
