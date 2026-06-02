#!/usr/bin/env python
"""Symmetry-naive heavy-atom RMSD between a docked pose (pdbqt, model N) and a
native reference (pdb), matched by best Hungarian assignment over heavy atoms
to be robust to atom-name reordering after obabel/meeko prep.
Usage: rmsd.py <native.pdb> <docked.pdbqt> [model_index(1-based)]"""
import sys, numpy as np
from scipy.optimize import linear_sum_assignment

def read_pdb_heavy(path):
    P=[]
    for ln in open(path):
        if ln.startswith(("ATOM","HETATM")):
            el=ln[76:78].strip() or ln[12:16].strip()[0]
            if el.upper().startswith("H"): continue
            P.append((float(ln[30:38]),float(ln[38:46]),float(ln[46:54]),el.upper()))
    return P

def read_pdbqt_model(path, model=1):
    cur=0; P=[]; want=(model is not None)
    started = not want
    for ln in open(path):
        if ln.startswith("MODEL"):
            cur=int(ln.split()[1]); started=(cur==model); 
            if want and cur==model: P=[]
            continue
        if ln.startswith("ENDMDL"):
            if want and cur==model: break
            continue
        if ln.startswith(("ATOM","HETATM")) and (started or not want):
            el=ln[77:79].strip() or ln[12:16].strip()[0]
            # strip AD types
            el=''.join([c for c in el if c.isalpha()])[:2]
            if el.upper().startswith("H") and el.upper() not in ("HG","HF","HO","HE","HS"):
                # AD pdbqt: column 77-79 holds AD atom type; treat polar H types
                pass
            P.append((float(ln[30:38]),float(ln[38:46]),float(ln[46:54]),el.upper(),ln[77:79].strip()))
    # filter hydrogens by AD type
    out=[]
    for x,y,z,el,ad in P:
        ad=ad.upper()
        if ad in ("H","HD","HS"): continue
        out.append((x,y,z,el if el and el[0].isalpha() else ad[0]))
    return out

def rmsd_match(native, pose):
    # group by element, assign min-cost within element via Hungarian, sum
    import collections
    nat=collections.defaultdict(list); pos=collections.defaultdict(list)
    for x,y,z,e in native: nat[e[0]].append((x,y,z))
    for x,y,z,e in pose:   pos[e[0]].append((x,y,z))
    keys=set(nat)|set(pos)
    tot=0.0; n=0
    for k in keys:
        A=np.array(nat.get(k,[])); B=np.array(pos.get(k,[]))
        if len(A)==0 or len(B)==0:
            return None, f"element {k} mismatch nat={len(A)} pose={len(B)}"
        if len(A)!=len(B):
            return None, f"element {k} count mismatch nat={len(A)} pose={len(B)}"
        D=np.linalg.norm(A[:,None,:]-B[None,:,:],axis=2)
        r,c=linear_sum_assignment(D**2)
        tot+=np.sum(D[r,c]**2); n+=len(r)
    return np.sqrt(tot/n), f"matched {n} heavy atoms"

if __name__=="__main__":
    nat=read_pdb_heavy(sys.argv[1])
    model=int(sys.argv[3]) if len(sys.argv)>3 else 1
    pose=read_pdbqt_model(sys.argv[2],model)
    r,msg=rmsd_match(nat,pose)
    if r is None:
        print(f"RMSD=FAIL ({msg})"); sys.exit(2)
    print(f"RMSD={r:.3f} A  ({msg}, model {model})")
