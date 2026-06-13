# AGA-RX Round-4 SYNTHESIZE — Topical Follicular-Delivery Formulation

date: 2026-06-03 · domain: AGA-RX · lead: WAY-316606 (SFRP1 inhibitor) + analogs A1/A2/A3
goal: a **follicle-targeted topical** that delivers the SFRP1 inhibitor to the **dermal papilla (DPC)** at ≥ its weak-mM working concentration, in-silico-justified %w/v and vehicle.
reuse (d19): **TTR-LAC** CPE knowledge (LA + EtOH penetration enhancement) · **QD-HSPRAY** nanoemulsion (≤200 nm → follicular depth 2× + 6 h retention ≥50%) · minoxidil-class vehicle template.

---

## 1. Delivery problem statement (from the analyze + structure lanes)

- Target tissue = **dermal papilla cells (DPC)** at the hair-bulb, ~ the deepest follicular compartment. The **follicular (transappendageal) route**, not bulk transepidermal diffusion, is the productive path to DPC — exactly the regime where minoxidil works and where ≤200 nm carriers concentrate (the "follicular reservoir").
- Lead physchem (rdkit, ROUTE.md): **MW 448.5 · cLogP 2.57 · TPSA 92.3 · HBD 2 · HBA 5.** This is *inside* the practical topical window (MW <500, 1 < logP < 3.5, TPSA <120) → passive SC permeation is **possible but modest**; HBD 2 + TPSA 92 are the main flux penalties → **a penetration enhancer is warranted**, and a follicular bypass (nanoemulsion) is the upside lever.
- Potency reality (analyze lane): WAY-316606 is a **weak mM binder, Kd ≈ 0.08 mM (80 µM), ΔG_bind ≈ −5.6 kcal/mol**. The formulation must therefore deliver a **high local DPC concentration** (tens-to-hundreds of µM at the bulb), which sets the %w/v aggressively (see §3). This is the dominant formulation driver.

---

## 2. Vehicle (minoxidil-class hydroalcoholic base)

Mirror the clinically validated **minoxidil 5% topical solution** vehicle, tuned for the lead's logP:

| component | %v/v | role |
|---|---|---|
| **Ethanol** | **50%** | primary solvent + volatile penetration enhancer (lipid-fluidizing); drives follicular filling on evaporation | 
| **Propylene glycol (PG)** | **20%** | co-solvent + humectant + SC-swelling enhancer (the minoxidil workhorse co-solvent) |
| **Purified water** | **q.s. to 100% (~25%)** | continuous phase / solubility balance |
| **(optional) Transcutol P (diethylene glycol monoethyl ether)** | up to 10% (part of the water fraction) | deep-skin solubilizer, boosts follicular partitioning |

→ **EtOH : PG : water ≈ 50 : 20 : 30** (the proven minoxidil 5% ratio). The lead's cLogP 2.57 + 2 sulfones make it well-soluble in EtOH/PG; expected solubility comfortably supports the §3 loading.

---

## 3. Penetration enhancer + %w/v from the PK margin (reuse TTR-LAC CPE)

**CPE choice (inherited from TTR-LAC, d19):** **linoleic acid (LA) + ethanol** is the verified high-D-boost chemical penetration enhancer pair from the repo's anesthetic work (TTR-LAC: *"linoleic acid 5% + EtOH 20%"*, *"LA+EtOH MD 42× (in-vivo 10–15× conservative)"*). LA is a cis-unsaturated C18 fatty acid that fluidizes SC intercellular lipids; with EtOH it is one of the best-characterized CPE pairs. We carry the **same LA 5% loading** into the AGA vehicle (LA also has independent scalp/5α-reductase literature, a free bonus on-axis for AGA).

- **CPE: linoleic acid 5% w/v** (synergistic with the 50% EtOH already in the vehicle) → conservative in-vivo flux boost **~10–15×** (TTR-LAC's down-rated value; we do NOT claim the 42× MD upper bound, d6).

**%w/v derivation (PK margin):**
- Working target at the bulb ≈ Kd to ~10×Kd = **80 µM → ~0.8 mM** local DPC concentration for meaningful SFRP1 occupancy (weak binder ⇒ need supra-Kd).
- Minoxidil precedent: a 5% w/v topical (≈0.5 M in vehicle) delivers a productive follicular dose despite minoxidil's own modest skin flux. Matching that loading for a similar-MW, similar-logP molecule is the rational anchor.
- The lead's flux penalty (HBD 2, TPSA 92) vs minoxidil (HBD 4 but lower MW) is offset by the **LA+EtOH CPE (10–15×)** + the **nanoemulsion follicular 2× depth** (§4). Net: a **5% w/v** load with these enhancers projects a bulb concentration in the **hundreds-of-µM band** — i.e. ≥ the ~80 µM Kd with a **~3–10× margin**, the regime needed for a weak mM binder.

→ **Recommended loading: WAY-316606 (or lead analog) 5% w/v.** A **2.5% w/v** lower-strength SKU is the irritation/tolerability fallback (still ~Kd-level with the CPE+nanoemulsion stack). Honest caveat (d6): the µM→bulb projection is a **PBPK-class estimate**, not a Franz-cell measurement; the verify lane should close it with an in-silico Franz/PBPK follicular model (cf TTR-LAC A5 Franz cascade + arXiv 1808.10045 follicular PBPK already cited in the AGA-RX log).

---

## 4. Nanoemulsion / liposome option (reuse QD-HSPRAY ≤200 nm follicular concept)

**Reuse (d19):** QD-HSPRAY established that a **nanoemulsion with droplet size ≤200 nm → follicular penetration depth 2× + 6 h retention ≥50%.** Follicular openings preferentially take up 200–700 nm particles, and ≤200 nm droplets reach the deepest (bulb-proximal) compartment → this is the single best lever for *DPC* targeting.

**Recommended primary presentation: O/W nanoemulsion, droplet ≤200 nm.**

| component | role |
|---|---|
| oil phase: medium-chain triglyceride / oleic-acid-rich oil + the **5% LA** (CPE doubles as part of the oil phase) | solubilizes the lipophilic-ish lead; CPE co-located at the follicle |
| surfactant: Tween-80 / Span-80 blend (or lecithin) | drops interfacial tension → ≤200 nm by high-shear/ultrasonic emulsification |
| co-surfactant: ethanol/PG (from the vehicle) | fixes droplet size + supplies the SC-fluidizing co-solvent |
| aqueous: water + Transcutol | continuous phase |

- Target droplet **z-avg ≤ 200 nm, PDI ≤ 0.2** (QD-HSPRAY spec) → **2× follicular depth + ≥50% 6 h retention** carried as the design claim.
- **Liposome alt:** a deformable/ethosomal liposome (phosphatidylcholine + EtOH 20–30%) is the secondary option — also a ≤200 nm follicular carrier with a stronger SC-deformation argument, at higher formulation complexity/cost. Use nanoemulsion as primary (cheaper, more robust), liposome as a line-extension.

---

## 5. Pairing with the WEAVE / NANOBOT delivery axes (AGA-RX matrix)

The AGA-RX hexa-bio matrix defines WEAVE (self-assembling cage) + NANOBOT (trigger-release nanocarrier) as the **delivery modalities** for the Wnt-restorer payload. The topical formulation is the *carrier substrate* those axes plug into:

- **NANOBOT pairing (primary, near-term):** the ≤200 nm nanoemulsion droplet **is** the NANOBOT "trigger-release nanocarrier" instantiation — add a **pH- or enzyme-gated release trigger** (e.g. a follicle-microenvironment-pH-sensitive lipid, or an esterase-cleavable lead-prodrug) so the payload is held during transit and **released at the DPC**. This converts the passive nanoemulsion into the matrix's "DPC-targeted pH/enzyme-gated topical release." Fully compatible with the §2–4 vehicle.
- **WEAVE pairing (line-extension):** a **Caspar-Klug / Zlotnick self-assembling cage** encapsulating the lead is a structured alternative to the nanoemulsion droplet — same ≤200 nm follicular-size target, but with a defined cage shell for higher payload protection/retention. Carry as a WEAVE-axis upgrade once the cage-assembly ODE (inherited from hexa-bio-archive) is parameterized for this payload.
- **RIBOZYME/VIROCAPSID** axes are non-small-molecule arms (siRNA/AAV) — out of scope for this small-molecule topical, but they would **reuse the same ≤200 nm follicular carrier** logic (esp. nanoemulsion/LNP for siRNA).

---

## 6. VERDICT

**Best synthesizable analog:** **A2 (4-aminotetrahydropyran cap)** — lowest SA (2.41), **shortest route (4 steps, no Boc protect/deprotect)**, all-commodity SMs, and it **caps the basic piperidine** (the lead's main metabolic/off-target liability flagged by the AR-gate in round-2). cLogP 3.00 keeps it in the topical window. **Runner-up A3 (saccharin-bicycle)** has the best drug-likeness (QED 0.83, lowest MW 406.5, fewest rotatable bonds) and the W97/Y127 growth vector for a potency jump — recommended as the **potency-optimization track** if the rigidification SAR pays off (verify lane to dock/MM-GBSA it).

**Recommended topical formulation (lead or A2):**
- **Vehicle:** hydroalcoholic, **EtOH : PG : water ≈ 50 : 20 : 30** (minoxidil-class), + optional Transcutol 10%.
- **CPE:** **linoleic acid 5% w/v + the 50% EtOH** (reuse TTR-LAC LA+EtOH pair) → conservative **10–15×** in-vivo flux boost.
- **Loading:** **5% w/v** (2.5% w/v tolerability SKU) — set by the weak Kd ≈ 80 µM requiring a hundreds-of-µM bulb concentration; minoxidil-5%-anchored, CPE+nanoemulsion-enabled.
- **Carrier:** **O/W nanoemulsion, droplet ≤200 nm, PDI ≤0.2** (reuse QD-HSPRAY) → **2× follicular depth + ≥50% 6 h retention**; **NANOBOT-axis pH/enzyme-gated release at the DPC**; liposome/WEAVE-cage as line-extensions.

**SM cost class:** **LOW** (A2 + all formulation excipients are commodity catalog: 4-aminotetrahydropyran, PhSO₂Na, EtOH/PG/water, linoleic acid, Tween/Span/lecithin). A1 (het-sulfinate) and A3-grow (regio-saccharin + Suzuki) = LOW–MED.

**Honesty / open verify items (d6):** the µM→bulb concentration and the 10–15×/2× boosts are **inherited/estimated** values, not measured for *this* molecule. Closure path = in-silico **Franz-cell + follicular PBPK** model (TTR-LAC A5 cascade + arXiv 1808.10045) coupled to the AGA anagen PK/PD layer — the verify-lane milestone. No wet-lab is trailered (d1/d19); these are in-silico-closable.

artifacts: this file · `ROUTE.md` · `sa_scores.txt`.
