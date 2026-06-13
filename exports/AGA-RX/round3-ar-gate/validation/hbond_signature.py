#!/usr/bin/env python
"""AR-agonism H-bond signature score.
Counts polar contacts (<=3.5A donor/acceptor heavy-atom dist) between the docked
ligand (model 1, ligand portion only) and the 4 anchor residues that define
androgen agonism in AR-LBD (2AM9):  Asn705, Gln711, Arg752, Thr877.
A true androgen anchors its 3-keto + 17-OH into this network; a non-androgen
that merely fills the hydrophobic cavity will miss it.
Usage: hbond_signature.py <receptor_apo.pdbqt> <docked_ligand.pdbqt>"""
import sys, numpy as np
ANCHORS = {"705":"ASN","711":"GLN","752":"ARG","877":"THR"}
POLAR = set("NO")  # only N/O heavy atoms can H-bond

def lig_polar(path):
    pts=[]; in_flex=False
    for ln in open(path):
        if ln.startswith("MODEL") and ln.split()[1]!="1": continue
        if ln.startswith("ENDMDL"): break
        if ln.startswith("BEGIN_RES"): in_flex=True; continue
        if ln.startswith("END_RES"): in_flex=False; continue
        if in_flex: continue
        if ln.startswith(("ATOM","HETATM")):
            ad=ln.split()[-1].upper()
            if ad[0] in POLAR:
                pts.append([float(ln[30:38]),float(ln[38:46]),float(ln[46:54])])
    return np.array(pts)

def recep_anchor_polar(path):
    res={}
    for ln in open(path):
        if ln.startswith(("ATOM","HETATM")):
            ri=ln[22:26].strip(); rn=ln[17:20].strip()
            if ri in ANCHORS and rn==ANCHORS[ri]:
                el=ln.split()[-1].upper()[0]
                if el in POLAR:
                    res.setdefault((ri,rn),[]).append([float(ln[30:38]),float(ln[38:46]),float(ln[46:54])])
    return {k:np.array(v) for k,v in res.items()}

if __name__=="__main__":
    L=lig_polar(sys.argv[2]); R=recep_anchor_polar(sys.argv[1])
    if len(L)==0:
        print("anchor_contacts=0  (ligand has NO polar atoms)"); sys.exit(0)
    hits=[]; total=0
    for (ri,rn),A in sorted(R.items()):
        d=np.min(np.linalg.norm(A[:,None,:]-L[None,:,:],axis=2))
        if d<=3.5: hits.append(f"{rn}{ri}({d:.2f})"); total+=1
    print(f"anchor_contacts={total}/4  hits=[{', '.join(hits) if hits else 'none'}]")
