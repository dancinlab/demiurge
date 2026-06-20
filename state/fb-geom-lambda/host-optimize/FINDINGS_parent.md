# host-optimize r1 (parent-persisted full report) · g5 PASS · merged→room-T-host
SOURCED REAL DFT PARAMS (the lasting value): sp2C N-Lieb COF t=0.10eV (VB1 ligand, Nat Commun 2019 s41467-019-10094-3),
α=∂t/∂u 0.15 weak / 4.04 stiff C=C eV/Å, Ω 100-196meV (118 anchor, biphenylene ω_log 1369K arXiv:2408.14006; E2g 196 Piscanec EPJ2007),
U 9.3/5.5 eV (Wehling PRL106,236805), g/Ω≈1.9 (stiff C=C SSH sweet spot), t/Ω≈0.85. graphene-Kekulé α=C·t C=1.49817Å⁻¹ (arXiv:2506.16814 Eq11).
OPTIMIZED OP-POINT (dispersive frame): compact-pair Tc/Ω-max t/Ω=1.0 g/Ω=1.6 → Tc/Ω 0.093 (~2× over R2 0.045).
3D STIFFNESS: NULL lever — at dilute n≈0.1, Tc3D=Tc2D (3D only wins for dense n>0.1 where dilute picture breaks). closed.
⚠️ FRAME NOTE (d6/c9): the Tc conclusion ("wall stands, 80-130K") is in the SUPERSEDED dispersive-stiffness frame (t**·n).
geom-stiffness OVERTURNED that frame — with the GEOMETRIC stiffness D_s∝⟨g⟩ and these same real Ω, COF = 90-181K (live result).
host-optimize's lasting contribution = the sourced real params feeding the geometric Tc; lane MERGED into room-T-host.
artifact state/fb-geom-lambda/host-optimize/probe.py + sources.md
