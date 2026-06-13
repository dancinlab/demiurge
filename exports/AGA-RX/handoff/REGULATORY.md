# AGA-RX — Regulatory Pathway Analysis

🧴 **AGA-RX** — non-AR Wnt-restorer topical for androgenetic alopecia · lead/dev candidate WAY-316606 / A2

date: 2026-06-03 · milestone = HANDOFF
scope: US (FDA) + KR (MFDS / 식약처) regulatory-pathway selection, with topical-AGA precedent analysis, timeline and cost class per path. This is a **regulatory strategy memo**, not legal/regulatory advice; pathway picks are reasoned from public precedent.

---

## 1. US — FDA pathway

### 1.1 The two candidate pathways

| | **505(b)(1) NDA** | **505(b)(2) NDA** |
|---|---|---|
| basis | full reports of safety/efficacy from studies **the applicant conducted or owns** | relies in part on data the applicant **does not own** — published literature and/or FDA's prior findings of safety/efficacy for a listed/approved drug |
| fits when | a genuine **new molecular entity (NME)** with no approved reference | bridging to an approved reference drug (same active, or shared safety/efficacy findings) |
| AGA-RX fit | WAY-316606 / A2 is a **new chemical entity** — no approved SFRP1 inhibitor exists; the active has never been approved | possible **literature-reliance** route — leans on the published WAY-316606 pharmacology + the minoxidil/clascoterone topical-AGA precedent for parts of the package |

### 1.2 Analysis — which fits

**Pick = 505(b)(2) NDA** (with a 505(b)(1)-equivalent full data package as the fallback).

Reasoning:
- AGA-RX is **chemically an NME** (no approved SFRP1 inhibitor; the active was never approved). On the active-ingredient axis alone it looks like a 505(b)(1).
- BUT WAY-316606 is a **known, published compound** (CID 16727102, characterized SFRP1 pharmacology + ex-vivo hair-growth literature). 505(b)(2) explicitly permits reliance on **published literature** the applicant did not generate — the published WAY-316606 pharmacology can support parts of the nonclinical/pharmacology package, reducing the studies the sponsor must run de-novo.
- The **topical-AGA route** has strong recent precedent (clascoterone/Breezula, minoxidil) — FDA's prior findings on the topical-scalp class (formulation, local-tolerance expectations, efficacy endpoints = hair-count/anagen) are leverageable under 505(b)(2).
- **A2** (the THP-cap analog) is a *new* molecule (no literature) — for A2 specifically the literature-bridge is thinner, pushing it toward 505(b)(1); the optimal filing may bridge the **WAY-316606 parent** on literature and carry A2 as the manufactured form via a read-across argument. This is a sponsor/FDA pre-IND-meeting decision.

**Net:** file as **505(b)(2)** leaning on published WAY-316606 pharmacology + the topical-AGA class precedent for the reference-supported portions, while generating the sponsor's own GLP tox + clinical efficacy (which both paths require). If FDA rejects the literature-bridge at the pre-IND meeting, the package degrades cleanly to a **full 505(b)(1) NDA** — the difference is the size of the de-novo nonclinical package, not the clinical program.

### 1.3 Topical-AGA precedent

| drug | active | route | approval basis | relevance |
|---|---|---|---|---|
| **minoxidil** (Rogaine, 2% / 5%) | minoxidil | topical solution/foam | approved Rx then OTC; the vehicle template + efficacy-endpoint precedent | AGA-RX's vehicle (EtOH:PG:water 50:20:30) and the hair-count endpoint are minoxidil-anchored |
| **clascoterone** (Winlevi 1% acne; **Breezula** = clascoterone solution in AGA dev, Phase 3) | clascoterone (topical AR-antagonist) | topical | **the closest topical-AGA precedent** — establishes FDA's acceptance of a topical scalp drug for AGA with hair-count endpoints | endpoint design (TAHC, target-area hair count), local-tolerance package, trial duration (≈6–12 mo) read across directly |
| **finasteride** (Propecia, oral 1mg) | finasteride | oral 5αRI | the systemic-AR comparator AGA-RX differentiates *against* | benchmark for the AR-orthogonality safety-differentiation claim |

Clascoterone/Breezula is the **operative precedent**: it shows FDA will register a topical small-molecule for AGA on TAHC endpoints, and (being itself topical-AR) sets the bar that AGA-RX's **AR-orthogonal MoA** is positioned to beat on the side-effect axis.

### 1.4 US timeline + cost class (indicative, sponsor-run wet-lab program)

| phase | duration (typical) | cost class |
|---|---|---|
| IND-enabling (GLP tox, CMC/GMP, Franz/PK, pre-IND meeting) | 12–24 mo | $$ (single-digit $M) |
| Phase 1 (topical — often SAD/MAD + dermal PK; small) | 6–12 mo | $$ |
| Phase 2 (dose-finding, TAHC, ~6 mo treatment) | 18–24 mo | $$$ |
| Phase 3 (pivotal, 6–12 mo treatment + safety) | 24–36 mo | $$$$ (tens-to-hundreds $M) |
| NDA review (505(b)(2) standard; topical dermatology) | 10–12 mo | $$ (PDUFA fee) |

505(b)(2)'s saving is **time + nonclinical cost** (literature-supported portions), not the clinical program — AGA efficacy is sponsor-run regardless. **All of §1.4 is the wet-lab/clinical trailer — out-of-software-scope.**

---

## 2. KR — MFDS (식품의약품안전처 / 식약처) pathway

### 2.1 The two candidate categories

| | **신약 (New Drug)** | **자료제출의약품 (Data-Submission / less-than-new drug)** |
|---|---|---|
| KR-Pharm-Affairs basis | a **new active ingredient never approved in Korea** — full safety/efficacy dossier | an item that is **not a wholly new drug** but differs from an approved drug (new salt/ester, new combination, new route/dosage form, new indication) → reduced data-submission set; can reference existing data |
| AGA-RX fit | WAY-316606 / A2 = new active never approved in KR → **신약** on the active axis | possible if bridging to minoxidil-class topical or relying on the foreign (FDA) approval package + published data |

### 2.2 Analysis — which fits

**Pick = 신약 (New Drug)** for the active, executed efficiently via the **자료제출의약품-style data-bridge + foreign-data reliance** provisions.

Reasoning:
- The active ingredient is genuinely new to Korea → it is classified **신약**. MFDS does not have a 505(b)(2) literal equivalent; the **자료제출의약품** category is the nearest analogue (reduced dossier for a not-wholly-new product), but it generally does **not** cover a brand-new active.
- KR's practical lever is **foreign-data acceptance**: MFDS accepts ICH-compliant foreign (FDA/EMA) GLP and clinical data, and bridging studies (often a KR/ethnic-bridge PK or a small local trial) rather than a fully independent domestic program. So the strategy is **신약 classification + maximal foreign-data reliance + a KR bridging study**.
- A KR **IND-equivalent (임상시험계획승인, IND/CTA)** is filed with MFDS to run the bridging clinical work, then the **품목허가 (marketing-authorization)** dossier follows.

**Net:** **신약** is the honest KR classification; cost/time is contained by riding the FDA package + a KR ethnic-bridge, not by a lighter category.

### 2.3 KR timeline + cost class (indicative)

| phase | duration | cost class |
|---|---|---|
| MFDS pre-submission consultation (사전상담) + CTA (임상시험계획승인) | 6–12 mo | $ |
| KR bridging clinical (PK/efficacy bridge to the FDA program) | 12–24 mo | $$$ |
| 품목허가 (NDA-equivalent) review (신약) | 12 mo | $$ |

KR cost is **lower than the US standalone** because the program rides the FDA/foreign data + a bridge. Still entirely **wet-lab/clinical = out-of-software-scope**.

---

## 3. Regulatory-path verdict

| jurisdiction | path pick | rationale (one line) |
|---|---|---|
| **US** | **505(b)(2) NDA** (505(b)(1) fallback) | NME chemically, but WAY-316606 is published → literature-bridge + clascoterone/minoxidil topical-AGA precedent; degrades cleanly to 505(b)(1) if FDA rejects the bridge |
| **KR** | **신약 (New Drug)** via foreign-data reliance + KR bridge | new active → 신약 classification; 자료제출의약품 does not cover a new active; contain cost by riding the FDA package + an ethnic-bridge study |
| **operative precedent** | **clascoterone / Breezula** (topical AGA, TAHC endpoint) | proves FDA registers a topical small-molecule for AGA; AGA-RX's AR-orthogonality is positioned to beat clascoterone (itself topical-AR) on the side-effect axis |

**Honest scope note (d5/d19):** the entire regulatory program (every row of §1.4 and §2.3) is **clinical/wet-lab and out-of-software-scope** — this document is the pathway *strategy* the in-silico campaign hands off, not a regulatory milestone the campaign can close in-silico. The non-AR differentiation thesis that *motivates* the favorable regulatory positioning (avoiding the finasteride sexual-side-effect class liability) **is** in-silico-closed (AR off-target gate G3 PASS).

artifacts: this file · `IND_DRAFT.md` · `IP_PORTFOLIO.md`.
