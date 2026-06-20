# route-nonconv lane r1 (parent-persisted) · 2026-06-19 · branch(b): no room-Tc channel · g5 PASS

7 non-conventional channels rated {pred Tc, ambient?, FP-tractable?, escapes el-ph bound?}:
| channel | Tc | ambient | FP-tractable | escapes bound |
|---|---|---|---|---|
| Bipolaronic (bond-Peierls SSH light bipolaron) | ~20-40K | ✅ | ◐ (QMC + DFT-downfold loop OPEN) | ✅ Migdal-λ breaks |
| Non-adiabatic/vertex (PGS) | −30..−40% (suppress) | ✅ | ✅ | ✗ |
| Flat-band geometric superfluid weight (Peotta-Törmä) | 1-10K | ✅ | ✅ cheap | ◐ rescue not enhance |
| Multi-gap/interband (MgB2) | ×1.5 | ✅ | ✅ (inside Eliashberg) | ✗ |
| Plasmonic (Akashi-Arita SCDFT) | +10-15% | ✅ | ✅ | ✗ |
| Excitonic | >200K claimed | ◐ | ✗ | unproven |
| Kohn-Luttinger | ~mK | ✅ | ◐ | ✗ |

KEY INSIGHT: 4/5 channels escape the el-ph bound in the right UNITS (Tc/Ω, stiffness, λ_eff
factor) but ABSOLUTE Tc stays pinned at tens of K — the boson energy replacing the phonon
(U~meV, weak plasmon/KL coupling) is itself small. High boson energy never converts to high Tc
when the dimensionless coupling is correspondingly weak. The only >200K claim (exciton-BEC) is
unreproduced and not first-principles-computable.

DEPLETION branch (b): NONE clears {room-Tc + ambient + tractable}. el-ph bound Tc≤0.364·ω_log(W*)
STANDS as the operative ambient ceiling — confirms closing-negative for ROOM-Tc.

BREAKTHROUGH lever named (d2, cross-confirmed with cap-escape): BIPOLARONIC bond-Peierls SSH
light-bipolaron SC (arXiv:2203.07380, Zhang/Berciu PRX 13,011010). Mechanistically breaks Migdal-λ
(light Peierls bipolaron escapes Holstein exponential-mass death; U enhances Tc), ambient, cheap
exact two-particle QMC solver; OPEN FP loop: DFT/DFPT downfold light-atom t/Ω~1 candidate →
bond-Peierls (∂t/∂u) + U → bipolaron QMC → Tc. NOVEL campaign, NOT reproduction. HONEST (d6):
tens-of-K (~20-40K) probe, NOT a room-Tc closing formula.
Sources: arXiv:2203.07380, PRX 13 011010, PRB 109 L220502, Akashi-Arita SCDFT, Peotta-Törmä NatComm 6:8944.
