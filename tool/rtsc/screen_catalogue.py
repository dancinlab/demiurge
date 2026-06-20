"""
SCREEN the Materials Project for real light-element flat-band SC candidates (new-candidate extractor).

Pipeline: MP query (light-element, metallic, stable) -> flat-band proxy (high DOS@E_F via bandstructure
later) -> novelty cross-check vs the 18-roster + known SC -> hand box-passing hits to predict_candidates.

KEY GOTCHA (baked in · self-improving): MP's API returns 403 without a User-Agent header (Cloudflare).
Always send User-Agent. Key via `secret get materialsproject.api_key`.
"""
import os, json, re, urllib.request, urllib.parse

LIGHT = {"Li","Be","B","C","N","H","Mg","Al","Si"}          # light/stiff-bond elements (Z<=14)
ROSTER = {"CoSn","Nb3Cl8","tMoTe2","MATBG","Re6Se8Cl2","graphene","biphenylene","triangulene",
          "GaNb4S8","GaNb4Se8","bismuthate","MgB2","CaC6","YBC","LiBC"}   # already-known / in-roster

def mp_get(path, params, key):
    url = f"https://api.materialsproject.org/{path}/?" + urllib.parse.urlencode(params)
    req = urllib.request.Request(url, headers={"X-API-KEY":key, "accept":"application/json",
                                               "User-Agent":"demiurge/1.0"})   # UA required (403 guard)
    with urllib.request.urlopen(req, timeout=60) as r:
        return json.load(r)

def screen(key, hull_max=0.03):
    fields = "material_id,formula_pretty,is_metal,energy_above_hull,nelements,symmetry"
    systems = ["B-C","Li-B-C","Be-B","B-C-N","Li-C","Be-C","Mg-B","Al-B","Li-B","B","C","Be-C-N","Li-Be-B"]
    out = {}
    for sysm in systems:
        try:
            d = mp_get("materials/summary", {"chemsys":sysm,"is_metal":"true",
                       "energy_above_hull_max":str(hull_max),"_fields":fields,"_limit":"50"}, key)
            for m in d.get("data", []):
                f = set(re.findall(r"[A-Z][a-z]?", m["formula_pretty"]))
                if f <= LIGHT:
                    out[m["formula_pretty"]] = (m["material_id"], round(m.get("energy_above_hull",0),3),
                                                (m.get("symmetry") or {}).get("symbol","?"))
        except Exception as e:
            print(f"  [{sysm}] err: {str(e)[:70]}")
    return out

if __name__ == "__main__":
    key = os.popen("secret get materialsproject.api_key").read().strip()
    hits = screen(key)
    print("="*92)
    print(f"SCREEN — MP light-element metallic stable compounds (flat-band SC candidate pre-filter): {len(hits)}종")
    print("="*92)
    print(f"  {'formula':<14}{'mp-id':<14}{'E_hull':>7}  {'symmetry':<14} novelty")
    print("  "+"-"*88)
    for f,(mid,eh,sym) in sorted(hits.items(), key=lambda kv: kv[1][1]):
        known = any(k.lower() in f.lower() or f.lower() in k.lower() for k in ROSTER)
        nov = "known/roster" if known else "★ NOT-in-roster (novelty PENDING — arxiv check needed)"
        print(f"  {f:<14}{mid:<14}{eh:>7}  {sym:<14} {nov}")
    print("\nHONEST (d6): this is the PRE-FILTER (light + metallic + stable). Flat-band@E_F + scalar <g>")
    print("+ stiff-Omega still need per-material bandstructure/DFPT-Wannier (next stage). '★ NOT-in-roster'")
    print("hits are CANDIDATES, not discoveries — each needs an arxiv SC-novelty probe (d_novel_only) before")
    print("any claim. The screen EXTRACTS names; confirmation is downstream compute + novelty gate.")
