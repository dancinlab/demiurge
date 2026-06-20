# sp2C N-Lieb COF — SC PAIRING-CHANNEL VERIFICATION (honest, d6/c2)

**Question:** Can a bond-Peierls bipolaron SC channel exist in the sp2c carbon-conjugated
COF (our recipe-pure light host, 2D-BKT geometric Tc ≈ 136 K, ⟨g⟩0.672, Ω120meV C-C bond
phonon)? Its remaining gate is the SC pairing channel — none is reported/predicted for it.

**Date:** 2026-06-19 · web + reasoning only · NO pod · NO architecture/commit edit.

---

## VERDICT: 🔴 BLOCKED (wide-gap semiconductor · flat band buried deep in valence band · in-plane el-ph negligible)

The 136 K geometric number is a **paper number for an IDEALIZED Lieb lattice**, not for the
real synthesized sp2c-COF. In the real material the flat band is neither at E_F nor reachable
by feasible doping, the host is a 1.0–1.9 eV semiconductor, the bond-Peierls coupling that
*would* pair carriers is computed to be **negligible in-plane**, and on the Lieb flat band SSH
coupling produces a **bond-disproportionate INSULATOR (CDW), not a superconductor**. Three
independent walls, each sufficient to reject. → **REJECT** as a recipe-pure SC host (or
demote to a conditional/idealized-model entry, not a real-material candidate).

---

## 1. Flat-band filling & position — NOT at E_F, buried, "beyond reach of typical doping"

**Two different objects are being conflated:**

- **IDEAL Lieb-3 lattice** (textbook / arXiv:2311.16858 abstract): "possesses both Dirac cones
  and flat bands which intersect at the Fermi level." This is the model that gives the pretty
  flat-band-at-E_F picture our 136 K assumes.
- **REAL synthesized sp2c-COF** (Py(BCSB)2, Jiang–Huang–Liu, Nat Commun 2019,
  s41467-019-10094-3 / arXiv:1904.12487): the synthesized COF is a **NON-IDEAL** Lieb lattice.
  DFT: **nonmagnetic insulator, gap ≈ 1.0 eV** (experiment ≈ 1.9 eV, Science 2017 aan0202).
  The flat band is the **second valence band**, sitting **between two Dirac bands well below
  E_F**, and is explicitly **"beyond the reach of typical doping level."**

**Real filling:** in the pristine ground state the flat band is **fully occupied** (closed-shell
insulator). It is never partially filled in any condition studied. The Lieb degeneracy is
**lifted/quenched** by electronic inhomogeneity: on-site energy difference ΔE ≈ 0.14 eV
(corner vs edge-center ligand) + dimerization δ ≈ 0.04 eV. So even the "flatness" that feeds
⟨g⟩0.672 is a property of the idealized model, not the as-made framework.

→ The flat band is **deep in the valence manifold, fully filled, and not tunable to E_F by
realistic carrier doping**. The geometric-Tc premise (partially-filled flat band at E_F) is
**not satisfied** by the real material.

## 2. Metal / semiconductor / Mott? — WIDE-GAP SEMICONDUCTOR (insulator in DFT)

- Pristine sp2c-COF conductivity **6.1×10⁻¹⁴ S/m** — an insulator (Science 2017, aan0202).
- Band gap 1.0 eV (DFT) / 1.9 eV (optical). Not a metal; not a Mott insulator — a conventional
  wide-gap band semiconductor with a quenched-Lieb valence structure.
- **Doping route that exists:** chemical oxidation (I₂ vapor) → conductivity rises to
  7.1×10⁻² S/m (12 orders of magnitude). Fermi level drops into the **TOP valence (Dirac)
  band**, ~0–0.7 holes/unit cell. p-type organic dopants (Macromolecules 2023, 3c00396) do the
  same Fermi-level shift into the Dirac band.
- **Crucially the doped holes occupy the DIRAC band, not the flat band.** The flat band stays
  buried below. To reach the flat band you would need to *empty* the entire top Dirac valence
  band first — far beyond achievable doping (would require removing ~1+ e/cell past the Dirac
  band edge). No demonstrated electrochemical-gating or alkali-intercalation route reaches the
  flat band; alkali intercalation in frameworks (e.g. CTF) dopes π* conduction states, again
  not this buried valence flat band.

→ Carriers ARE attainable (I₂ / p-dopant), but they land on the **wrong band** (Dirac), and the
ferromagnetism literature confirms it: the observed FM at 8.1 K arises from the **Dirac band
via Stoner**, explicitly **NOT the flat band** (Nat Commun 2019). The flat band is electronically
inaccessible.

## 3. Bond-Peierls (∂t/∂u, C–C bond phonon) channel — ASSUMED, not computed; and where computed it is NEGLIGIBLE in-plane

- **No el-ph coupling has ever been computed for sp2c-COF.** The Nat Commun 2019 paper and the
  arXiv:2311.16858 Lieb-polymer paper discuss band structure / ferromagnetism only — **no
  electron-phonon, no DFPT, no λ, no superconductivity** in either. Our ⟨g⟩0.672 / Ω120meV is
  therefore an **assumed bond-Peierls value, not a first-principles result for this framework.**
- Where in-plane el-ph **has** been computed for 2D COFs (RSC Chem. Sci. 2026, d5sc08033a, six
  2D COFs): **in-plane momentum exchange is NEGLIGIBLE**; strong EPC is **interlayer** only.
  This directly undercuts the premise that a strong in-plane C=C bond-Peierls vertex pairs
  carriers — the one direct el-ph study on 2D COFs finds the in-plane channel weak.
- The C=C/aromatic bond phonon (~120–200 meV) is real and high-frequency (good prefactor), and
  SSH/bond-Peierls bipolarons *are* the right mechanism class for light bipolarons (Bipolaronic
  HT-SC perspective arXiv:2605.16625; bond SSH gives light bipolarons vs heavy Holstein). BUT:
  the **bond-SSH model ON A LIEB FLAT BAND at relevant filling produces a bond-disproportionate
  (CDW) INSULATING bipolaron phase at half-filling**, i.e. the flat band's quenched kinetic
  energy drives the system to a **localized insulator, not a superconductor** (three-orbital SSH
  Lieb; bismuthate-class bond-disproportionate bipolaron insulators, PRB 103.115129). Flat-band
  + strong bond coupling = CDW competitor wins over SC unless detuned off the flat band — the
  same Holstein/SSH CDW-vs-SC competition seen generically.

→ The pairing vertex is **(a) never computed for this material, (b) negligible in-plane where
measured on sibling 2D COFs, and (c) prone to a CDW-insulator endpoint on the flat band even if
present.** All three are adverse.

## 4. NET VERDICT + single deciding calculation

**SC-channel = 🔴 BLOCKED.** Compounded, independent walls:

| Wall | Status | Evidence |
|------|--------|----------|
| Flat band at E_F? | NO — buried 2nd valence band, fully filled, "beyond typical doping" | Nat Commun 2019 |
| Carriers at flat band? | NO — I₂/p-dope lands on Dirac band; FM is Dirac-Stoner not flat | Nat Commun 2019, Science 2017 |
| Host metallic? | NO — 1.0–1.9 eV semiconductor (10⁻¹⁴ S/m pristine) | Science 2017 |
| In-plane bond-Peierls vertex strong? | NO — negligible in-plane EPC in 2D COFs | RSC Chem Sci 2026 |
| Flat-band SSH → SC? | NO — bond-disproportionate CDW insulator at half-filling | 3-orbital SSH Lieb / bismuthate |
| el-ph ever computed for sp2c-COF? | NO — ⟨g⟩0.672 is assumed | (absent in all literature) |

The 136 K geometric Tc is an **idealized-Lieb-model number**; the real sp2c-COF does not present
a partially-filled flat band at E_F, has no demonstrated route to put one there, and the only
in-plane el-ph evidence on its material class is unfavorable. This is a **paper number requiring
heavy (unreachable) doping → REJECT** as a recipe-pure real-material SC host. It may survive only
as an **idealized-model entry** (ideal Lieb-3 flat band, hypothetical filling), clearly labeled
as not-yet-a-material.

**Single deciding calculation (if one wished to attempt rescue, in priority order):**
1. **DFPT/finite-difference el-ph (λ, α²F) of the real Py(BCSB)2 sp2c-COF at the doping that the
   I₂ experiment achieves** (Fermi level in the Dirac band, ~0.5 holes/cell). This is THE missing
   number — replaces the assumed ⟨g⟩0.672 with a computed in-plane λ at the *attainable* filling.
   Prediction from the above evidence: small in-plane λ → no phonon SC. If λ comes back large at
   the Dirac-band filling, the candidate revives **at the Dirac band, not the flat band** (a
   different, non-geometric story).
2. Only if (1) is favorable: a frozen-phonon SSH-vs-Holstein bipolaron stability check at that
   filling to rule out the CDW-insulator endpoint.

The flat-band-at-E_F premise itself is **falsified for the real material** by Nat Commun 2019, so
the geometric 136 K cannot be claimed without first solving an as-yet-unsolved doping problem
(empty the entire Dirac valence band to expose the flat band) for which no route is demonstrated.

---

### Sources
- Jiang, Huang, Liu, *A Lieb-like lattice in a covalent-organic framework and its Stoner
  ferromagnetism*, Nat. Commun. 10, 2207 (2019) — s41467-019-10094-3 / arXiv:1904.12487.
  https://www.nature.com/articles/s41467-019-10094-3 · https://pmc.ncbi.nlm.nih.gov/articles/PMC6525167/
- *Electronic Lieb lattice signatures embedded in 2D polymers with square lattice*,
  arXiv:2311.16858. https://arxiv.org/abs/2311.16858
- Jin et al., *Two-dimensional sp2 carbon–conjugated covalent organic frameworks*, Science 357,
  673 (2017) — aan0202. https://www.science.org/doi/10.1126/science.aan0202
- *Effective Fermi-Level Modulation of 2D Conjugated COFs … p-Type Organic Dopants*,
  Macromolecules (2023), 10.1021/acs.macromol.3c00396.
- *Unveiling the electron–phonon coupling anisotropy in 2D covalent organic frameworks*,
  RSC Chem. Sci. (2026), d5sc08033a. https://pubs.rsc.org/en/content/articlelanding/2026/sc/d5sc08033a
- *Bipolaronic High-Temperature Superconductivity from Phonon-Modulated Hopping: A Perspective*,
  arXiv:2605.16625. https://arxiv.org/abs/2605.16625
- Three-orbital SSH / bond-disproportionate bipolaron insulator (bismuthate class), PRB
  103.115129; SSH-vs-Holstein CDW/SC competition, arXiv:2403.15386, 2005.09673.
