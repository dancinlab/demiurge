import sys, re
ef = 16.0669  # E_F from scf.out (eV)
gnu = '/root/laru3si2/laru3si2_bands.dat.gnu'
# .gnu format: blocks separated by blank line; each block = one band, lines "kdist  energy"
blocks=[]
cur=[]
for line in open(gnu):
    s=line.strip()
    if not s:
        if cur: blocks.append(cur); cur=[]
        continue
    parts=s.split()
    if len(parts)>=2:
        try: cur.append((float(parts[0]), float(parts[1])))
        except: pass
if cur: blocks.append(cur)
print(f"E_F={ef} eV ; parsed {len(blocks)} band-blocks")
if not blocks: sys.exit("no blocks")

# k-path: 6 segments x12 +1 = 73 kpts. in-plane Gamma-K-M-Gamma = first 3 seg = first ~37 kpts.
# determine kdist at end of 3rd segment: each block has same kdist axis. Use kdist values.
kd = [p[0] for p in blocks[0]]
nk = len(kd)
# segment boundaries at indices 0,12,24,36,48,60,72 (12 intervals each)
inplane_end_idx = 36  # Gamma..K..M..Gamma  (3 segments x 12)
inplane_kmax = kd[inplane_end_idx] if inplane_end_idx < nk else kd[-1]
print(f"nk per band={nk}; in-plane kdist range 0..{inplane_kmax:.4f}")

stats=[]
for j,b in enumerate(blocks):
    e_inplane=[e for (k,e) in b if k<=inplane_kmax+1e-6]
    if not e_inplane: continue
    mean=sum(e_inplane)/len(e_inplane)
    bw=max(e_inplane)-min(e_inplane)
    stats.append((j,mean,bw))

# flat band candidates: bandwidth < 0.7 eV across Gamma-K-M, within 1.5 eV of E_F
cands=[s for s in stats if s[2]<0.7 and abs(s[1]-ef)<1.5]
cands.sort(key=lambda s:s[2])
print("\n--- flat manifold candidates (in-plane bw<0.7 eV, |mean-EF|<1.5 eV) ---")
print(f"{'band':>5} {'mean_eV':>9} {'inplane_bw':>10} {'dE=mean-EF':>11}")
for j,mean,bw in cands[:10]:
    print(f"{j+1:5d} {mean:9.4f} {bw:10.4f} {mean-ef:11.4f}")

# also print ALL bands near E_F (within 0.6 eV) regardless of flatness, for context
print("\n--- ALL bands with mean within 0.6 eV of E_F (context) ---")
near=[s for s in stats if abs(s[1]-ef)<0.6]
near.sort(key=lambda s:abs(s[1]-ef))
for j,mean,bw in near[:12]:
    print(f"  band{j+1:3d}  mean={mean:8.4f}  inplane_bw={bw:7.4f}  dE={mean-ef:+8.4f}")

if cands:
    topflat=sorted(cands[:6], key=lambda s:abs(s[1]-ef))
    j,mean,bw=topflat[0]
    dE=mean-ef
    av=abs(dE)
    print(f"\n>>> SELECTED Ru-kagome flat band: band#{j+1} mean={mean:.4f} eV inplane_bw={bw:.4f} eV dE={dE:+.4f} eV")
    if av<0.10: v="PASS (GREEN)"
    elif dE>0.2 or av>0.2: v="FALSIFY (RED)"
    else: v="INCONCLUSIVE (ORANGE)"
    print(f">>> |dE|={av:.4f} eV -> gate(dE): {v}")
