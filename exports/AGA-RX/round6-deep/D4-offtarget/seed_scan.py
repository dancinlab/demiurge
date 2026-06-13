import gzip
guides={  # label: guide 5'->3' (antisense), from R3-D
 "DKK1_g971":"UAUAAAAGGAGUUCACUGC","DKK1_cds539":"UUUUGCAGUAAUUCCCGGG",
 "SRD5A2_1427":"UCAUCAACUAAGACACUGC","SFRP1_3006":"UUUAUCAGGAUAACUCUCC",
 "AR_2857":"UUGAAGAAGACCUUGCAGC"}
comp={'A':'T','C':'G','G':'C','U':'A','T':'A'}
def seed_site(g):  # mRNA off-target site = RC of guide seed (pos 2-8, 1-indexed)
    s=g[1:8]                       # 7-mer seed, RNA
    rc=''.join(comp[b] for b in reversed(s))  # DNA reverse-complement
    return rc
seeds={k:seed_site(v) for k,v in guides.items()}
print("guide seeds (mRNA 7-mer target site, DNA):")
for k,v in seeds.items(): print(f"  {k:12s} guide5'={guides[k]}  seed_site={v}")
# stream transcripts, count hits per seed
cnt={k:0 for k in seeds}; ntx=0
with gzip.open("cdna.fa.gz","rt") as f:
    seq=[]
    def flush(s):
        global ntx
        if not s: return
        ntx+=1
        for k,site in seeds.items():
            if site in s: cnt[k]+=1
    for line in f:
        if line[0]=='>':
            flush(''.join(seq)); seq=[]
        else: seq.append(line.strip())
    flush(''.join(seq))
print(f"\nscanned {ntx} transcripts (Ensembl GRCh38 cDNA r111)")
print("per-guide seed-driven off-target transcript count (7-mer exact, miRNA-like seed):")
for k in seeds:
    frac=100*cnt[k]/ntx
    flag="HIGH" if frac>6 else ("MOD" if frac>2 else "LOW")
    print(f"  {k:12s}: {cnt[k]:6d} transcripts ({frac:.2f}%)  [{flag}]")
print("\nnote: 7-mer seed match in ANY transcript region = upper-bound off-target pool; true risk needs 3'UTR-restricted + expression-weighting (siSPOTR/GESS). Random 7-mer expectation ~ ntx*(1/4)^7 baseline.")
import math
print(f"random-7mer baseline per transcript ~ {(1/4)**7:.2e}; expected hits if no structure ≈ {ntx*(1-(1-(1/4)**7)**1500):.0f} (1.5kb avg)")
