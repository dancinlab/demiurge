# BIODEGRADABLE-PLASTICS — Phase D candidate stub

> **Authored**: 2026-05-13 (Phase A elevation) · **Status**: STUB — Phase D roadmap marker
> **Author**: 박민우 <nerve011235@gmail.com>
> **Target group**: GROUP_POL · **Phase D priority**: LOW (cross-domain overlap)
>
> Stub placeholder for the Phase D `biodegradable-plastics` verb. Most depth
> content (PLA / PHA / PBS chemistry) already lives in `POLYMER-CHEMISTRY.md §5`.

---

## §1 Scope

Biodegradable polymers are polymers that decompose under defined conditions (composting, marine, soil microbial) into CO₂ + H₂O + biomass within a defined timeframe (months to a few years).

Distinguish from:
- **Bio-based** (made from renewable feedstock; not necessarily biodegradable; e.g., bio-PE from sugarcane is bio-based but NOT biodegradable)
- **Compostable** (subset of biodegradable; industrial compost only, ASTM D6400)
- **Marine-biodegradable** (subset; ASTM D7081)

---

## §2 Content already in POLYMER-CHEMISTRY.md §5

Per `POLYMER-CHEMISTRY.md §5`:
- §5.1 — PLA (polylactic acid) — corn starch fermentation, NatureWorks/Total Corbion
- §5.2 — PHA (polyhydroxyalkanoate) — bacterial intracellular polymer, Danimer Scientific
- §5.3 — PBS (polybutylene succinate) — succinic acid + 1,4-butanediol step-growth, Showa Denko / Mitsubishi

When the `biodegradable-plastics/` verb chapter is authored (Phase D), it should:
1. Cross-link to `POLYMER-CHEMISTRY.md §5` rather than duplicate
2. Add depth on **PCL (polycaprolactone)** — slow degradation, biomedical sutures, FDA-approved
3. Add depth on **PHB (poly-3-hydroxybutyrate)** — single-monomer PHA grade
4. Add depth on **starch-based bioplastic** (Mater-Bi, Cardia BioHybrid) — starch + plasticizer blend
5. Add depth on **cellulose-derived bioplastic** — cellulose acetate (CA), regenerated cellulose film (cellophane)
6. Add **biodegradation standards** map: ASTM D6400 (industrial compost), ASTM D7081 (marine), EN 13432 (EU compost), DIN CERTCO label, ISO 14855

---

## §3 Cross-domain sister-repo discipline

Per `AGENTS.md` "Sister repositories — live dependencies" + `USER_ACTION_REQUIRED.md §6`:
- **CLI integration over Python wrappers** — biodegradable-plastics verb should call `hexa-bio fermentation` for microbial-production side (PHA, PLA, PHB, PBS feedstock via bacterial / fungal fermentation)
- Do NOT reimplement bio-fermentation in-tree
- Materials side (Tg, Tm, σ_f, crystallinity, biodegradation kinetics) stays here

This is the same pattern as `silicon/silicon.md` → `hexa-chip materials` for the device side.

---

## §4 Real-limit anchors (planned)

- L12 entropy of mixing — biodegradation = enzymatic + microbial depolymerization is enzyme-rate-limited, not Gibbs-floor-limited (because the chemical bond energy is provided by enzyme catalysis, not free-energy descent)
- T_g, T_m, crystallinity values cited from CRC + manufacturer datasheets

---

## §5 Industrial scale (vendor-published, no lattice fit)

| Polymer | Global production 2024 (kt/yr) | Top producers |
|---------|--------------------------------|----------------|
| PLA | ~ 300 | NatureWorks (Cargill), Total Corbion |
| PHA | < 50 | Danimer Scientific, RWDC, Mango Materials |
| PBS | ~ 50 | Showa Denko, Mitsubishi Chemical, PTT MCC |
| Starch-based (Mater-Bi etc.) | ~ 300 | Novamont |
| Cellulose acetate | ~ 800 | Eastman Chemical, Celanese, Daicel |

(Cellulose acetate is the largest by volume but is typically not labeled "bioplastic" because it has been around since 1865.)

Source: European Bioplastics 2024 market data + Plastics Europe.

---

## §6 Cross-links

- `POLYMER-CHEMISTRY.md` §5 — depth content
- `pet_film/pet_film.md` — non-biodegradable comparison
- `nylon/nylon.md` — slow-degradation comparison
- `microplastics/microplastics.md` — environmental fate of non-biodegradable
- `hexa-bio` — fermentation production side
- `hexa-farm` — bioplastic feedstock (corn, sugarcane)
- `hexa-earth` — marine biodegradation testing

---

## §7 Honest C3

Phase D candidate. Stub-level — most depth in `POLYMER-CHEMISTRY.md §5`. Cross-domain to hexa-bio (fermentation) + hexa-farm (feedstock) + hexa-earth (marine fate). Vendor production figures cite European Bioplastics market data. No lattice fit. Per `LATTICE_POLICY §1.2`.

---

*Stub authored 2026-05-13 by 박민우 <nerve011235@gmail.com> as Phase D roadmap marker.*
