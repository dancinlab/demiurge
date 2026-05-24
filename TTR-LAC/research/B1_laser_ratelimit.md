# TTR-LAC — B1: 세션당 잉크 지움의 율속단계 (frosting + 재포획)

> ❄️ **TTR-LAC** track B — "세션당 제거율↑ / 총 세션수↓"
> B1 = **무엇이 한 세션의 잉크 제거를 막는가** 를 first-principles + 문헌으로 고정.
> 두 율속단계: **(a) epidermal frosting** (즉시 백탁 → 빔 산란 → 세션당 1패스 한계) ·
> **(b) recapture r** (방출 단편의 macrophage 재포획 · Baranska).
> TTR-ORAL `BP1d` 의 세션 모델 (`N=log(0.1)/log(1-c)`, `c(r)`) 을 **재사용하되 TOPICAL** —
> 경구 r↓ 가 아니라 **국소 PFD frosting-clear → 동일세션 다중패스** 가 1차 lever.
> sim = `sim/b1_laser_ratelimit.hexa`. @D d6 — 베이스라인을 문헌 6-10세션·1.4패스에 캘리브레이션.

---

## 1. 표준 레이저 제거 — 문헌 수치 + 두 병목 (🟡)

| 항목 | 문헌값 | 출처 |
|---|---|---|
| 기전 | Q-switched / picosecond **광음향 단편화** (cavitation) | StatPearls · JCAS PMC4411588 |
| 완전제거 세션 | **6-10 세션** (90%+), 작은 잉크 3-5세션 · 보통 최대 7세션 | MDPI 9712 · Springer 2024 |
| 간격 | **6-8 주** (최소 8주 권장) | Springer 2024 · MDPI |
| pico 클리어런스 | 2세션 후 **평균 61%**, 6-8세션 후 **86.6%**, 평균 6.5세션에 **79%** | PMC11322294 · MDPI |
| 완전제거 비율 | 전문 잉크는 **~30%만** 완전제거 | PMC11322294 |
| 세션당 유효 c (역산) | 90%까지 ~8세션 ⇒ 세션당 **~25%** | (lit 6-10 캘리브레이션) |
| **병목 (a) frosting** | 레이저 펄스 → **steam·vacuolization·gas bubble** → 즉시 백탁(opaque) → 후속 패스 빔 차단. 자연 소실까지 **~20 분** | JCAS PMC4411588 · J Aesthet Nurs |
| **병목 (b) recapture r** | 방출 단편이 인접 macrophage 에 **재포획** → 다음 세션까지 잔류 | **Baranska 2018 (JEM)** |

### 병목 (a) — frosting 이 "세션당 1패스" 를 강제한다
> *"immediate whitening … steam, vacuolisation … this epidermal whitening is opaque, and therefore
> limits subsequent passes … prevents further penetration of laser. The white discoloration will
> typically clear within 20 minutes."* (J Aesthet Nurs · JCAS)
⇒ frosting 미해소 시 한 세션에 **사실상 1패스** (다음 패스는 산란된 빔이 잉크에 못 닿음). 이것이 세션당 c≈0.25 의 물리적 천장.

```
표준 1패스 세션 (frosting 미해소)
  ●●●●●●●●  잉크          PASS 1 ──► 광음향 단편화 + gas bubble
       │ 레이저                       ░░░░  frosting (opaque · 빔 산란)
       ▼                              │
  · · · ·●●●●  일부 단편화           PASS 2 ──► ✗ 빔이 frosting 에 산란 → 잉크 미도달
                                      └─ 20분 대기 후에야 다음 패스 → 1세션=1패스
  ⇒ 세션당 c≈0.25 · 90%까지 ~8세션
```

---

## 2. 다중패스 선례 — 국소 PFD 가 frosting 을 즉시 지워 동일세션 다중패스 (🟡)

frosting 이 율속이면, **그 기포를 녹이는 국소제** 가 세션당 패스를 늘린다. 이미 임상 입증된 두 선례:

| 방법 | 핵심 수치 | 출처 |
|---|---|---|
| **R20 (Kossida 2012)** | 4패스 / 패스간 20분 대기 · split-tattoo (12환자·18잉크). 3개월 후 **R20 완전제거 61% vs 단일패스 0%** · 흉터·이상반응 없음 | PubMed 22036610 · astanza |
| **R0 / DESCRIBE PFD patch** | perfluorodecalin 함침 실리콘 패치 → frosting **3-5초** 내 광학적 clearing (optical clearing) → 대기 불필요 → 다중패스. **치료시간 80분 → 5분** | JCAS PMC4411588 · describepatch |
| **PFD pivotal trial (Biesman 2017)** | split-tattoo (30명·진청/흑). **PFD 3.7패스 vs laser-alone 1.4패스** · 17잉크 중 **11개가 PFD측 더 빠른 clearance** · edema/erythema↓ · 30/30 PFD 선호 | PubMed 28319270 |
| **PFD 광학 기전 (Reddel 2020)** | PFD 가 표면 광산란↓ → 심부 잉크에 도달 fluence↑ (**~10% 더 높은 내성 fluence**) · 피부온도 **~40%↓** · 입자방출 ~2배↓(trend) | PubMed 32516063 · JAAD pig model |

```
PFD frosting-clear 세션 (R0/DESCRIBE)
  ●●●●●●●●  잉크   PASS1 ──►░░░ frosting ──[PFD 3-5초]──► clear ──► PASS2 ──► clear ──► PASS3..
       │                                                  │              │
       ▼                                                  ▼              ▼
  같은 세션에 3-4 RAPID 패스 (대기 없음) · 각 패스가 잔류 잉크에 추가 타격
  ⇒ pivotal trial 평균 3.7패스 (laser-alone 1.4) · 세션당 c 급상승
```

**핵심**: PFD = **국소제가 세션당 제거율을 올린 기존 증거** (track B 의 존재 증명). 잉크 화학을 바꾸지 않고 **패스 수** 만으로 c_session 을 끌어올린다.

---

## 3. hexa-native recompute (verbatim · 🟢 · per @D g5)

모델 (BP1d 재사용 · TOPICAL 다중패스 항 추가):
```
c_pass    = phi_rel * (1 - r)              패스 1회 클리어런스 (단일패스 = 표준 단위)
c_session = 1 - (1 - c_pass)^n_passes      n패스 누적 (각 패스가 잔류에 기하급수 타격)
N         = log(0.1) / log(1 - c_session)  90% 클리어까지 세션 수
calib: phi_rel=0.83, r0=0.70, n=1 -> ~8 세션 (lit 6-10 · 1.4패스 정합)
```

```
=== TTR-LAC B1: frosting-limited multipass + recapture -> sessions-to-90% ===

c_pass = phi_rel*(1-r) ; c_session = 1-(1-c_pass)^n ; N = log(0.1)/log(1-c_session)
calibration: phi_rel=0.83, r0=0.70, n=1 pass -> ~8 sessions (lit standard 6-10)

[1] PFD multipass lever (frosting cleared 3-5s -> n passes/session · r=0.70 fixed):
  c_pass (single, calibrated) = 0.249

  n_passes  c_session              N_sessions            note
    1       0.249  8.04117  STANDARD-of-care (frosting forces stop)
    2       0.435999  4.02058  PFD 2-pass
    3       0.576435  2.68039  PFD ~3-pass (trial mean 3.7)
    4       0.681903  2.01029  PFD/R20 4-pass (Kossida)

[2] PFD pivotal-trial mean: laser-alone 1.4 passes vs PFD 3.7 passes/session
  laser-alone (1.4 pass): c_session=0.330276 N=5.74369
  PFD patch  (3.7 pass) : c_session=0.653369 N=2.17329
  absolute cut = 3.5704 sessions
  fold speedup = 2.64286x fewer sessions

[3] recapture r-down lever (B3 · n=1 pass fixed · isolate r):
  r       c_pass=c_session       N_sessions            note
  0.70    0.249  8.04117  baseline recapture
  0.60    0.332  5.707  weak topical drainage
  0.50    0.415  4.29472  moderate (Baranska transient-ablation)
  0.40    0.498  3.34117  strong topical r-down

[4] B4 co-formulation (PFD 3.7 passes + topical r-down to 0.50):
  c_pass(r=0.50)=0.415 c_session(3.7pass)=0.862445 N=1.16073
  vs standard-of-care N=5.74369 => fold = 4.94832x fewer sessions

[5] timeline @ 7-week spacing (months = N * 1.6):
  standard-of-care (1.4 pass, r0.70): 9.1899 months
  PFD (3.7 pass, r0.70)             : 3.47726 months
  B4 co-form (3.7 pass, r0.50)      : 1.85718 months

=== dominant lever: which moves N more — frosting(passes) or recapture(r)? see [1] vs [3] ===
=== honest floor: passes/r change RATE only; carbon ink chemistry floor unchanged (inherited TTR-ORAL) ===
```

---

## 4. 정직한 발견 — 세션 수 단축곡선 + 어느 병목이 dominant?

```
  세션 수 N (90% 클리어)         lever                     포지션
  ████████ 8.0  n=1패스 · r0.70  (둘 다 미해결)          표준-of-care 천장
  ── frosting lever (패스↑, r=0.70 고정) ───────────────────────────────
  ████ 4.0      n=2패스                                  PFD 2-pass
  ██▋ 2.7       n=3패스 (trial 3.7 근방)                 PFD/R0 ~3-pass
  ██ 2.0        n=4패스                                  R20/PFD 4-pass
  ── recapture lever (r↓, n=1패스 고정) ────────────────────────────────
  ████▋ 5.7     r0.60                                    약한 국소 drainage
  ████▎ 4.3     r0.50 (Baranska 천장)                    중간 r↓
  ███▍ 3.3      r0.40                                    강한 국소 r↓
  ── 둘 다 (B4 co-form) ────────────────────────────────────────────────
  █▏ 1.16       n=3.7패스 + r0.50                        통합 제형 (~4.9× vs 1.4패스 base)
```

**어느 병목이 dominant?** — frosting(패스) lever 가 더 가파르다:
- **frosting**: 1패스 8.0 → 3패스 **2.7세션** (−5.3세션). 같은 *한 세션 안* 의 개입으로 즉시.
- **recapture**: r0.70 → 0.50 = **4.3세션** (−3.7세션). 세션*간* 생물학(drainage)을 바꿔야 함.
- ⇒ **frosting-clear(다중패스)가 1차·즉효 lever**, recapture-r↓ 는 보완 lever. 둘은 **곱셈으로 쌓인다** (B4: pivotal-trial 1.4패스 base 대비 ~4.9× → ~1.2세션 · 타임라인 ~9.2개월 → ~1.9개월).

⚠ **정직한 floor (TTR-ORAL 상속 · @D d5/d6)**: 레이저는 carbon black 을 **단편화**할 뿐 **화학적으로 파괴하지 않는다** — 잉크는 단편의 림프 **배출(drainage)** 로만 사라진다. 따라서 track B 가 바꾸는 것은 **세션당 RATE / 패스 수 / 재포획률** 이지 **잉크 화학(carbon 비분해성 floor)** 이 아니다. "더 잘 지워짐" = *더 적은 세션·기간·비용*, 결코 *새 제거 메커니즘* 이 아님. 과장 금지.

⚠ **모델 한계**: phi_rel·r 은 캘리브레이션값(절대 미실측) · c_session 기하급수는 패스가 *독립적으로 잔류에 작용* 가정(후속 패스 효율 체감·깊이 비균질성 미반영 → 다중패스 이득은 *상한치 경향*) · 단축 *비율* 은 phi_rel 에 둔감(견고). 절대 N 보다 **fold-speedup** 을 신뢰.

---

## 5. tier + verdict

| claim | tier |
|---|---|
| c_pass·c_session·N recompute (§3) | 🟢 verbatim |
| 표준 6-10세션 · 6-8주 · pico 61%/2세션·86.6%/6-8세션 | 🟡 문헌 (MDPI · PMC11322294) |
| frosting = vacuolization/gas → 세션당 1패스 한계 · 20분 소실 | 🟡 문헌 (JCAS PMC4411588 · J Aesthet Nurs) |
| R20 4패스 61% vs 0% · PFD 3.7 vs 1.4패스 · frosting 3-5초 clear | 🟡 문헌 (PubMed 22036610 · 28319270 · 32516063) |
| frosting(패스) lever 가 recapture(r) 보다 가파름 · 곱셈 누적 | 🔵/🟢 (모델 · lit-캘리브레이션) |
| 잉크 carbon 비분해성 floor (track B 는 RATE만 변경) | 🟡 (TTR-ORAL 상속 · 물리 floor) |

> **B1 verdict**: 세션당 제거의 율속은 **frosting(즉시·1차 lever) + recapture(세션간·보완 lever)** 두 단계로 분리되며, **둘 다 국소제로 공략 가능**하고 곱셈으로 쌓인다. PFD(R0/DESCRIBE) 가 **국소제가 세션당 제거율을 올린 임상 입증 선례**(3.7 vs 1.4패스) — track B 의 존재 증명. 모델상 frosting-clear 만으로 ~8 → ~2.7세션, recapture-r↓ 보완으로 ~1.2세션까지(~4.9×). 단 이는 **RATE 단축이지 잉크 화학 floor 돌파가 아님**(상속). absorbed=false 유지.

### B2-B4 가 전달해야 할 3가지 (이 모델의 파라미터를 실물로)
1. **B2 — frosting clearing 토픽**: PFD(또는 대체 광학 clearing agent) 국소 제형 → 세션당 패스 n=3-4 실현 (모델의 frosting lever 구현).
2. **B3 — recapture 억제/배출 토픽**: post-laser 방출 잉크 국소 drainage↑ / r 0.70→0.50 (Baranska 천장 · receptor-무관 drainage 우선 · TTR-ORAL imiquimod 음성 전례 유의).
3. **B4 — 통합 co-formulation**: frosting-clear + r↓ (+ track A 마취) 양립성·안정성·도포순서 → 곱셈 lever 동시 실현.

---

## Sources
- Q-switched / picosecond 기전 + 세션 수 — *StatPearls* NBK442007 (ncbi.nlm.nih.gov/books/NBK442007) · *J Cutan Aesthet Surg* "Newer Trends" PMC4411588 (pmc.ncbi.nlm.nih.gov/articles/PMC4411588)
- frosting = steam/vacuolization/gas bubble → opaque · 후속패스 제한 · 20분 소실 — *J Cutan Aesthet Surg* PMC4411588 · *J Aesthet Nurs* Skin&Laser Suppl Mar21 (jan.mydigitalpublication.co.uk)
- pico 세션 수·클리어런스 (61%/2세션, 86.6%/6-8세션, 79%/6.5세션, ~30% 완전제거) — *Lasers Med Sci* 2024 (link.springer.com/article/10.1007/s10103-024-04140-w · PMC11322294) · *MDPI Appl Sci* 11(20):9712 (mdpi.com/2076-3417/11/20/9712)
- R20 (Kossida 2012) 4패스·61% vs 0%·split-tattoo — *Arch Dermatol/JAAD* PubMed 22036610 (pubmed.ncbi.nlm.nih.gov/22036610) · astanzalaser.com
- PFD pivotal trial (Biesman 2017) 3.7 vs 1.4 패스·split·30명 — *Lasers Surg Med* PubMed 28319270 (pubmed.ncbi.nlm.nih.gov/28319270)
- PFD particle emission·skin temp·~10% fluence·40% 온도↓ (Reddel 2020) — *J Cosmet Laser Ther* 22(3) PubMed 32516063 (pubmed.ncbi.nlm.nih.gov/32516063) · JAAD pig model S0190-9622(19)31760-8
- DESCRIBE PFD patch (frosting 3-5초 optical clearing · 80분→5분) — describepatch.com · *J Cutan Aesthet Surg* PMC4411588
- Baranska et al. 2018, *J Exp Med* — capture-release-recapture · "laser + transient macrophage ablation" 제안 (rupress.org/jem/article/215/4/1115)
