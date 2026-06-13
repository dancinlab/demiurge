from pyscf import gto, scf, mcscf
KC=627.5094740631
def casci(atom,charge=0,spin=0,ncas=4,nelec=4):
    m=gto.M(atom=atom,basis='6-31g(d)',charge=charge,spin=spin,verbose=0)
    mf=scf.RHF(m).run(); mc=mcscf.CASCI(mf,ncas,nelec); e=mc.kernel()[0]
    return mf.e_tot,e
# canonical Szalewicz water dimer (eq, O···O~2.91A), monomer = first 3 atoms
dim="""O -1.551007 -0.114520 0; H -1.934259 0.762503 0; H -0.599677 0.040712 0;
O 1.350625 0.111469 0; H 1.680398 -0.373741 -0.758561; H 1.680398 -0.373741 0.758561"""
mon="""O -1.551007 -0.114520 0; H -1.934259 0.762503 0; H -0.599677 0.040712 0"""
hf_d,cas_d=casci(dim); hf_m,cas_m=casci(mon)
print(f"[ANCHOR water dimer eq] HF int={(hf_d-2*hf_m)*KC:.2f}  CASCI(4,4) int={(cas_d-2*cas_m)*KC:.2f} kcal/mol  (lit De −4.9..−5.0; BSSE-uncorrected so ~−6..−7 expected)")
print("__OK__")
