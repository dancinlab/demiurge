import numpy as np
# arm③ permanence-mechanism comparison: expected effect-duration vs risk → relapse-0 cure fit
# DPC = slow-turnover quiescent niche; lifetime horizon ~50 yr. relapse-0 needs duration≥lifetime OR self-renewing.
LIFE=50.0  # yr remaining horizon
mechs={
# name:               (dur_yr, self_renew, risk[0-1], reversible, note)
"senolytic 1x":        (3,   False, 0.10, True,  "clears senescent DPC; DHT re-acts → re-senescence → not durable alone"),
"AAV episomal ★현재":   (8,   False, 0.20, True,  "non-integrating; persists in slow DPC but dilutes; low risk"),
"integrating (lenti/TB)":(50, True,  0.65, False, "genomic integration in cell+progeny → lifelong; insertional-mutagenesis risk"),
"CRISPR KO (AR/SRD5A2)":(50, True,  0.55, False, "permanent genomic edit; off-target + irreversible"),
"epigenetic edit (dCas9)":(15,True,  0.30, True,  "durable Wnt-on/DKK1-off memory; lower risk, no DNA cut; durability less certain"),
"cell replace (iPSC DPC)":(50,True,  0.60, False, "androgen-resistant new follicles, intrinsically permanent; tumorigenicity/engraft risk"),
"synthetic bistable":  (30,  True,  0.45, True,  "homeostatic lock by design; circuit silencing risk"),
}
print("=== arm③ 영구화 7-기전 — durability × risk × relapse-0 fit ===")
print(f"{'mechanism':26s} {'dur(yr)':>7s} {'self-renew':>10s} {'risk':>5s} {'relapse-0?':>11s}  {'cure-fit*':>9s}")
rows=[]
for n,(d,sr,r,rev,note) in mechs.items():
    # relapse-0 met if duration>=lifetime OR self-renewing
    relapse0 = (d>=LIFE) or sr
    # cure-fit = relapse-0 efficacy × (1-risk) × reversibility-bonus(safety net)
    fit = (1.0 if relapse0 else d/LIFE) * (1-r) * (1.10 if rev else 1.0)
    rows.append((n,d,sr,r,relapse0,fit,note))
for n,d,sr,r,r0,fit,note in sorted(rows,key=lambda x:-x[5]):
    print(f"{n:26s} {d:7.0f} {str(sr):>10s} {r:5.2f} {str(r0):>11s}  {fit:9.2f}")
print("\n* cure-fit = relapse-0-eff × (1−risk) × reversibility-bonus (higher=better balance of permanence+safety)")
best=max(rows,key=lambda x:x[5])
print(f"→ best balance: {best[0]} (fit {best[5]:.2f}) — {best[6]}")
print("verdict: 현재 AAV episomal은 안전하나 dilution으로 relapse-0 미달(8yr<50). 균형 최적 = 후성유전 편집(durable+reversible+저risk). 최강 영구 = CRISPR KO/통합(relapse-0 확실하나 비가역+mutagenesis). → arm③ 권고: 후성유전 편집 1차 + CRISPR KO를 강력옵션, 세놀리틱은 단독 아닌 병용 prep.")
