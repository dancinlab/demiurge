from rdkit import Chem
from rdkit.Chem import Descriptors, Crippen, rdMolDescriptors, QED
leads = [
 ("WAY-316606","C1CNCCC1NS(=O)(=O)C2=C(C=CC(=C2)S(=O)(=O)C3=CC=CC=C3)C(F)(F)F"),
 ("2-naphthylguanidine","NC(=N)Nc1ccc2ccccc2c1"),
 ("4-guanidinobenzoic_acid","OC(=O)c1ccc(cc1)NC(=N)N"),
 ("tyramine-guanidine_hybrid","Oc1ccc(cc1)CCNC(=N)N"),
]
print(f"{'name':28s} {'MW':>7s} {'cLogP':>6s} {'TPSA':>6s} {'HBD':>3s} {'HBA':>3s} {'RotB':>4s} {'QED':>4s} {'Lipinski':>9s} {'Veber':>6s}")
for n,smi in leads:
    m=Chem.MolFromSmiles(smi)
    mw=Descriptors.MolWt(m); logp=Crippen.MolLogP(m); tpsa=rdMolDescriptors.CalcTPSA(m)
    hbd=rdMolDescriptors.CalcNumHBD(m); hba=rdMolDescriptors.CalcNumHBA(m)
    rot=rdMolDescriptors.CalcNumRotatableBonds(m); qed=QED.qed(m)
    lip_viol = sum([mw>500, logp>5, hbd>5, hba>10])
    lip = "PASS" if lip_viol<=1 else f"FAIL({lip_viol})"
    veb = "PASS" if (rot<=10 and tpsa<=140) else "FAIL"
    print(f"{n:28s} {mw:7.1f} {logp:6.2f} {tpsa:6.1f} {hbd:3d} {hba:3d} {rot:4d} {qed:4.2f} {lip:>9s} {veb:>6s}")
