#!/usr/bin/env python3
"""Full domain met lab — RDKit MMFF conformer + Stokes-Einstein diffusion @298K water
   + PHMB n=4·6·8·10·12 length scan (LENS R&D 추가)"""
import math
from rdkit import Chem
from rdkit.Chem import AllChem, Descriptors, Lipinski

KT = 4.11e-21; ETA = 8.9e-4; SIX_PI_ETA = 6 * math.pi * ETA

def analyze(name, smi):
    mol = Chem.MolFromSmiles(smi)
    if not mol: return None
    mh = Chem.AddHs(mol)
    try:
        cids = AllChem.EmbedMultipleConfs(mh, numConfs=5, randomSeed=42)
        energies = []
        for cid in cids:
            ff = AllChem.MMFFGetMoleculeForceField(mh, AllChem.MMFFGetMoleculeProperties(mh), confId=cid)
            if ff: ff.Minimize(maxIts=100); energies.append((cid, ff.CalcEnergy()))
        if not energies: return None
        best_cid, _ = min(energies, key=lambda x: x[1])
        conf = mh.GetConformer(best_cid)
        coords = [conf.GetAtomPosition(i) for i in range(mh.GetNumAtoms())]
        cx = sum(c.x for c in coords) / len(coords)
        cy = sum(c.y for c in coords) / len(coords)
        cz = sum(c.z for c in coords) / len(coords)
        r_g = math.sqrt(sum((c.x-cx)**2 + (c.y-cy)**2 + (c.z-cz)**2 for c in coords) / len(coords))
        r_h_m = r_g * 1.29e-10
        D = KT / (SIX_PI_ETA * r_h_m)
        return (Descriptors.MolWt(mol), r_g, D, Descriptors.MolLogP(mol),
                Lipinski.NumHDonors(mol), Lipinski.NumHAcceptors(mol))
    except Exception: return None

# QD + COSME 도메인 핵심 활성성분 (소재형 mask·band·nail·booster 제외)
domains = {
    "QD-SANITIZER":  [("Ethanol","CCO"), ("Glycerin","OCC(O)CO"), ("Panthenol","CC(C)(CO)C(O)C(=O)NCCCO")],
    "QD-PAD":        [("Cotton(unit)","OC[C@H]1O[C@H](O)[C@H](O)[C@@H](O)[C@@H]1O"), ("SAP_AA","CC(=O)O")],
    "QD-GARGLE":     [("CPC","CCCCCCCCCCCCCCCC[N+]1=CC=CC=C1"), ("Xylitol","OCC(O)C(O)C(O)CO"), ("Tranexamic","NCC1CCC(C(=O)O)CC1"), ("CitricA","OC(=O)CC(O)(CC(=O)O)C(=O)O")],
    "QD-FWASH":      [("LacticA","CC(O)C(=O)O"), ("CitricA","OC(=O)CC(O)(CC(=O)O)C(=O)O"), ("Allantoin","NC(=O)NC1NC(=O)NC1=O")],
    "QD-MWASH":      [("CPC","CCCCCCCCCCCCCCCC[N+]1=CC=CC=C1"), ("TeaTreeT4OL","CC(C)C1CCC(C)=CC1O"), ("Menthol","CC(C)C1CCC(C)CC1O")],
    "QD-HSHAMPOO":   [("Ketoconazole","CC(=O)N1CCN(CC1)c1ccc(OC[C@H]2CO[C@@](Cn3ccnc3)(O2)c2ccc(Cl)cc2Cl)cc1"), ("Climbazole","CC(C)(C)C(=O)C(Cn1ccnc1)Oc1ccc(Cl)cc1"), ("ZPT_anion","[O-]N1=CC=CC=C1[S-]"), ("Salicylic","O=C(O)c1ccccc1O")],
    "QD-HSPRAY":     [("Menthol","CC(C)C1CCC(C)CC1O"), ("Salicylic","O=C(O)c1ccccc1O"), ("CPC","CCCCCCCCCCCCCCCC[N+]1=CC=CC=C1")],
    "QD-TPASTE":     [("Tranexamic","NCC1CCC(C(=O)O)CC1"), ("CPC","CCCCCCCCCCCCCCCC[N+]1=CC=CC=C1"), ("Allantoin","NC(=O)NC1NC(=O)NC1=O"), ("AsAc(VitC)","OC1=C(O)C(=O)O[C@@H]1[C@@H](O)CO")],
    "QD-LENS":       [("Tocopherol","CC1=C(C)C2=C(CCC(C)(CCCC(C)CCCC(C)CCCC(C)C)O2)C(C)=C1O"), ("MPDA","CCCCCCCCCCCCCC(=O)NCCCN(C)C"), ("EDTA","OC(=O)CN(CCN(CC(=O)O)CC(=O)O)CC(=O)O")],
    "QD-INCONT":     [("SAP_PAA","CC(C(=O)O)CC(C(=O)O)CC(=O)O"), ("Chitosan","OC[C@H]1O[C@H](O)[C@H](N)[C@@H](O)[C@@H]1O")],
    "QD-POSTPART":   [("Panthenol","CC(C)(CO)C(O)C(=O)NCCCO"), ("Allantoin","NC(=O)NC1NC(=O)NC1=O"), ("Madecasso","OC[C@H]1OC(=O)C2(O)C[C@H](O)C[C@@]34CC[C@H](O)[C@@H](C)C[C@H]3[C@H](C)CCC2[C@@]14C")],
    "QD-INSECT":     [("DEET","CCN(CC)C(=O)c1cccc(C)c1"), ("Icaridin","CCC(C)C(=O)OC1CCCC(N1C(C)C)C"), ("Citronellal","O=CC/C=C(\\C)CCC(C)C")],
    "QD-SANSURF":    [("HOCl","ClO"), ("H2O2","OO"), ("Ethanol","CCO")],
    "QD-AWAKE":      [("Caffeine","CN1C=NC2=C1C(=O)N(C(=O)N2C)C"), ("Menthol","CC(C)C1CCC(C)CC1O"), ("Pepperminth","CC(=O)C1CCC(C)=CC1")],
    "QD-PETHYG":     [("TeaTreeT4OL","CC(C)C1CCC(C)=CC1O"), ("Citronellal","O=CC/C=C(\\C)CCC(C)C")],
    "COSME-AMPOULE": [("Niacinamide","NC(=O)c1cccnc1"), ("Retinol","CC1=C(CCCC1(C)C)/C=C/C(C)=C/C=C/C(C)=C/CO"), ("Adenosine","Nc1ncnc2c1ncn2[C@@H]1O[C@H](CO)[C@@H](O)[C@H]1O")],
    "COSME-SUN":     [("ZnO","[Zn]=O"), ("Avobenzone","CC(C)(C)c1ccc(C(=O)CC(=O)c2ccc(OC)cc2)cc1"), ("Oxybenzone","COc1cc(C(=O)c2ccccc2O)ccc1")],
    "COSME-DERM":    [("Madecasso","OC[C@H]1OC(=O)C2(O)C[C@H](O)C[C@@]34CC[C@H](O)[C@@H](C)C[C@H]3[C@H](C)CCC2[C@@]14C"), ("Ceramide_NP","CCCCCCCCCCCCCC(O)C(NC(=O)CCCCCCCCCCCCCC)CO"), ("Panthenol","CC(C)(CO)C(O)C(=O)NCCCO")],
    "COSME-SCALP":   [("Dexpanthenol","CC(C)(CO)C(O)C(=O)NCCCO"), ("Salicylic","O=C(O)c1ccccc1O"), ("Menthol","CC(C)C1CCC(C)CC1O"), ("Niacinamide","NC(=O)c1cccnc1"), ("Biotin","O=C1N[C@H]2CS[C@@H](CCCCC(=O)O)[C@@H]2N1")],
    "COSME-ACNE":    [("Salicylic","O=C(O)c1ccccc1O"), ("Niacinamide","NC(=O)c1cccnc1"), ("AzelaicA","O=C(O)CCCCCCCC(=O)O"), ("TeaTreeT4OL","CC(C)C1CCC(C)=CC1O")],
    "COSME-EYE":     [("Retinol","CC1=C(CCCC1(C)C)/C=C/C(C)=C/C=C/C(C)=C/CO"), ("Caffeine","CN1C=NC2=C1C(=O)N(C(=O)N2C)C"), ("VitK","CC1=CC(=O)c2ccccc2C1=O")],
    "COSME-FOOT":    [("Urea","NC(=O)N"), ("Salicylic","O=C(O)c1ccccc1O"), ("GlycolicA","OCC(=O)O")],
}

print("=" * 80)
print("FULL DOMAIN met lab — RDKit MMFF + Stokes-Einstein diffusion")
print("=" * 80)
print("{:14s} {:18s} {:>6s} {:>6s} {:>6s} {:>10s} {:>6s}".format("Domain","Compound","MW","R_g","logP","D(m²/s)","HBD"))
print("-" * 80)
for dom, ligs in domains.items():
    for name, smi in ligs:
        r = analyze(name, smi)
        if r is None:
            print("{:14s} {:18s} {:>6s}".format(dom, name, "FAIL")); continue
        mw, r_g, D, logp, hbd, hba = r
        print("{:14s} {:18s} {:>6.1f} {:>6.2f} {:>+6.2f} {:>10.2e} {:>6d}".format(dom, name, mw, r_g, logp, D, hbd))

print()
print("=" * 80)
print("PHMB length scan — n=4·6·8·10·12 (LENS R&D 추가 입증)")
print("=" * 80)
# PHMB unit = NH-C(=NH)-NH-C(=NH)-NH-(CH2)6-
# n=N means N repeating units
def phmb_smiles(n):
    unit = "NC(=N)NC(=N)NCCCCCC"
    return "N" + unit * n + "C(=N)N"  # extra terminus
print("{:6s} {:>6s} {:>6s} {:>10s} {:>6s}".format("n","MW","R_g","D(m²/s)","logP"))
for n in [4, 6, 8, 10, 12]:
    smi = phmb_smiles(n)
    r = analyze("PHMB_n{}".format(n), smi)
    if r is None:
        print("{:6d} FAIL".format(n)); continue
    mw, r_g, D, logp, hbd, hba = r
    print("{:6d} {:>6.1f} {:>6.2f} {:>10.2e} {:>+6.2f}".format(n, mw, r_g, D, logp))
