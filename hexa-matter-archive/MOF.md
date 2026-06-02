# MOF — Phase D candidate stub

> **Authored**: 2026-05-13 (Phase A elevation) · **Status**: STUB — Phase D roadmap marker
> **Author**: 박민우 <nerve011235@gmail.com>
> **Target group**: GROUP_CER ∩ GROUP_POL (hybrid) · **Phase D priority**: MEDIUM
>
> Stub placeholder for the Phase D `mof` verb covering metal-organic frameworks
> + covalent-organic frameworks (COFs).

---

## §1 Scope

A **Metal-Organic Framework (MOF)** is a crystalline coordination polymer with:
- Metal-ion or metal-cluster nodes
- Organic linker ligands
- Highly porous structure (often > 1000 m²/g BET surface area)

MOFs are a **CER ∩ POL hybrid** — they have a covalent organic skeleton (POL-like) bonded to an inorganic metal-ion node (CER-like). The crystalline ordering is closer to CER (ABX-style framework); the synthesis chemistry is closer to POL (solvothermal, ligand exchange).

---

## §2 Workhorse MOF families

| MOF | Metal node | Linker | BET (m²/g) | Use |
|-----|------------|--------|------------|-----|
| HKUST-1 (Cu-BTC, Cu₃(BTC)₂) | Cu²⁺ paddlewheel | benzene-1,3,5-tricarboxylate (BTC) | 1500-1700 | gas separation, H₂ storage |
| MOF-5 (IRMOF-1, Zn₄O(BDC)₃) | Zn₄O cluster | benzene-1,4-dicarboxylate (BDC) | 2900-3800 | H₂ storage research |
| MOF-74 (M₂(dobdc), M = Zn,Mg,Co,Ni) | M²⁺ chain | 2,5-dihydroxyterephthalate | 1300-1900 | CO₂ capture |
| ZIF-8 (Zn(MeIM)₂) | Zn²⁺ tetrahedron | 2-methylimidazole | 1500-1800 | gas sieving (kinetic separation), drug delivery |
| ZIF-67 | Co²⁺ tetrahedron | 2-methylimidazole | 1500-1800 | catalysis |
| UiO-66 (Zr-BDC) | Zr₆O₈ cluster | BDC | 1100-1400 | water-stable MOF, sorbent |
| UiO-67 | Zr₆O₈ cluster | biphenyl-4,4'-dicarboxylate | 2300-2600 | water-stable, larger pore |
| MIL-101 (Cr/Fe-BDC) | Cr₃O / Fe₃O trimer | BDC | 3000-4500 | gas storage, catalysis |
| NU-1101 (Zr-pyrene) | Zr₆O₈ | pyrene-tetracarboxylate | 5500 | record-high N₂ BET |
| MOF-210 (Be₄O cluster) | Be₄O | terphenyl-tetracarboxylate | 6240 | record-high N₂ BET |

NU-1101 + MOF-210 hold the ~ 6000-6500 m²/g BET ceiling — close to the theoretical maximum (~ 7000 m²/g calculated for hypothetical defect-free graphene; ~ 8000 m²/g for hypothetical optimal MOF).

---

## §3 Production routes

- **Solvothermal** — DMF or DEF solvent, 80-150 °C, days; the canonical synthesis
- **Mechanochemical** — ball-milling without solvent; green chemistry route
- **Electrochemical** — anodic dissolution of metal, ligand in solution
- **Microwave** — accelerated solvothermal (minutes vs days)
- **Continuous flow** — industrial scale-up (BASF Basolite series)

BASF (Basolite C 300, F 300, Z 1200) and Mitsubishi (Aspirator series) are the largest industrial MOF producers.

---

## §4 COF (Covalent-Organic Framework) — the all-organic cousin

COFs use **organic-organic covalent bonds** (boronate ester, imine, hydrazone, β-ketoenamine) instead of metal-organic coordination. Higher chemical stability, lower density, slower synthesis.

Examples: COF-1, COF-5, COF-102, COF-300, TpPa-1.

COFs are a separate Phase D candidate or absorbed into MOF.md as a sub-section.

---

## §5 Real-limit anchors (planned)

- Hales 0.7405 FCC/HCP packing — MOF density ceiling (some MOFs ~ 0.13 g/cm³, far below close-pack — porous by design)
- L12 entropy of mixing — MOF as solid sorbent reduces ΔS_mix for gas-separation applications

---

## §6 Cross-links (when expanded)

- `ceramics/ceramics.md` + `CERAMIC-ENGINEERING.md` — MOF metal-node ceramic side
- `POLYMER-CHEMISTRY.md` — organic linker chemistry
- `synthesis/synthesis.md` + `MATERIAL-SYNTHESIS.md` — solvothermal synthesis
- `hexa-bio` — MOF drug-delivery cross-domain
- `hexa-earth` — direct-air-capture (DAC) MOF cross-domain
- `hexa-energy` — H₂ storage MOF cross-link

---

## §7 Honest C3

Phase D candidate. Stub-level. BET surface area values cite primary literature (Yaghi group MOF-210 publication; Hupp NU-1101). Production routes cite BASF Basolite specifications + academic synthesis protocols. No lattice fit. Per `LATTICE_POLICY §1.2`.

---

*Stub authored 2026-05-13 by 박민우 <nerve011235@gmail.com> as Phase D roadmap marker.*
