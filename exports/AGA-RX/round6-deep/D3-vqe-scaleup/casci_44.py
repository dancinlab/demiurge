import numpy as np
from pyscf import gto, scf, mcscf
KC=627.5094740631  # Ha→kcal/mol
def int_energy(atom_d, atom_a, atom_dimer, basis='6-31g(d)', ncas=4, nelec=4):
    res={}
    for tag,atom,chg in [('dimer',atom_dimer,res.get('chg',0))]:
        pass
    def run(atom,charge,spin):
        m=gto.M(atom=atom,basis=basis,charge=charge,spin=spin,verbose=0)
        mf=scf.RHF(m).run()
        mc=mcscf.CASCI(mf,ncas,nelec); ec=mc.kernel()[0]
        return mf.e_tot, ec
    return run
# --- anchor: water dimer (neutral), CASCI(4,4)/6-31G(d) vs lit De ~ -5.0 kcal/mol ---
wd="""O 0 0 0; H 0.757 0.586 0; H -0.757 0.586 0; O 0 0 2.98; H 0 -0.31 2.40; H 0.76 0.20 3.30"""
wm="""O 0 0 0; H 0.757 0.586 0; H -0.757 0.586 0"""
run=int_energy(None,None,None)
ed,_=run(wd,0,0); em,_=run(wm,0,0)
# CASCI on each
def casci(atom,charge,spin,ncas=4,nelec=4):
    m=gto.M(atom=atom,basis='6-31g(d)',charge=charge,spin=spin,verbose=0); mf=scf.RHF(m).run()
    mc=mcscf.CASCI(mf,ncas,nelec); e=mc.kernel()[0]; return mf.e_tot,e
hf_d,cas_d=casci(wd,0,0); hf_m,cas_m=casci(wm,0,0)
hf_int=(hf_d-2*hf_m)*KC; cas_int=(cas_d-2*cas_m)*KC
print(f"[ANCHOR water dimer] HF int={hf_int:.2f}  CASCI(4,4) int={cas_int:.2f} kcal/mol  (lit De ~ -5.0; CASCI(4,4)/6-31G(d) qualitative, BSSE-uncorrected)")
print(f"   active space (4e,4o) = 8 spin-orbitals → 8 qubits (6 after parity+symmetry taper); CASCI=FCI-in-AS=UCCSD-VQE-exact for this AS")
# --- PATH-B salt bridge: methylguanidinium (CH6N3+) ··· formate (CHO2-) at R(N..O)~2.8A ---
gdm="C 0 0 0; N 1.34 0 0; N -0.67 1.16 0; N -0.67 -1.16 0; H 1.90 0.81 0; H 1.90 -0.81 0; H -0.13 2.00 0; H -1.68 1.20 0; H -0.13 -2.00 0; H -1.68 -1.20 0"
fmt="C 0 0 0; O 1.10 0.68 0; O -1.10 0.68 0; H 0 -1.09 0"
# dimer: place formate so an O sits ~2.8A from a guanidinium N-H (N at x=1.34, H at ~1.90,0.81)
dim=gdm+"; C 4.6 0.7 0; O 3.55 1.25 0; O 5.30 1.60 0; H 4.85 -0.42 0"
hf_gd,cas_gd=casci(dim,0,0); hf_g,cas_g=casci(gdm,1,0); hf_f,cas_f=casci(fmt,-1,0)
hf_sb=(hf_gd-hf_g-hf_f)*KC; cas_sb=(cas_gd-cas_g-cas_f)*KC
print(f"\n[PATH-B salt bridge methylguanidinium(+)···formate(−)] R(N···O)~2.8A, approx (unoptimized) geom")
print(f"   HF int={hf_sb:.1f}  CASCI(4,4) int={cas_sb:.1f} kcal/mol   correlation contribution={cas_sb-hf_sb:.1f}")
print(f"   (Coulomb-dominated charged contact ≫ neutral H-bond; gas-phase, no solvent → magnitude not net ΔG_bind)")
print("__AGA_RX_QUANTUM_44__ DONE")
