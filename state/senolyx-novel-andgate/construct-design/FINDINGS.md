# construct-design lane r1 — VERDICT 🟢 design-ready
## WINNER: Gal-uPAR-DT2216/PZ — galacto-caged BCL-xL(+MCL-1) PROTAC in uPAR-targeted local nanoparticle
AND-gate (2 locks in series): KILL ⟺ [surface uPAR ⇒ particle internalized] AND [lysosomal SA-β-gal ⇒ warhead uncaged] AND local-delivery.
- warhead: BCL-xL→CRBN degrader (PZ15227) + optional galacto-caged MCL-1i (S63845) co-payload (p_dep→0.85); catalytic/event-driven decouples dose↔tox; CRBN low in platelets = built-in sparing.
- cage(gate1): β(1,4)-gal on BCL-xL ligand → SA-β-gal/GLB1 cleaved (Nav-Gal chemistry).
- vehicle(gate2/axis2): uPAR-Ab nanoparticle — entry requires surface uPAR (Amor Nature 2020).
ORTHOGONALITY: uPAR(surface receptor·TFEB-independent) ⊥ SA-β-gal(lysosomal biogenesis) — different regulatory hubs → ρ→0 preserves multiplicative selectivity. NEITHER is kill axis (kill=BCL/MCL dependency f_s/f_q, NOT affinity).
FALSE-ESCAPE MITIGATIONS: (1) systemic β-gal leak → uPAR entry-lock breaks it + local delivery (2) avoided SASP-correlated markers (NOT IL-6R/MMP) (3) PROTAC E3-sparing treated as bonus not recognition axis.
BIGGEST RISK: uPAR–β-gal independence may be weaker than assumed (both downstream of senescence program) → if ρ≫0 AND-gate collapses. = pre-registered decisive computation: PLAUR↔GLB1 ρ from public single-cell senescence atlases (zero synthesis/pods).
CITATIONS: Nav-Gal 10.1111/acel.13142 · DT2216 10.1038/s41591-019-0668-z · PZ15227 10.1038/s41467-020-15838-0 · S63845 10.1038/nature19830 · uPAR 10.1038/s41586-020-2403-9.
