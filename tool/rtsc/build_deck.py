"""
Build a QE el-ph deck for an MP flat-band candidate via `hexa deck rtsc <slug> --prototype general`.

Bridges the extractor (screen_catalogue.py) to compute: fetch the MP structure, format
CELL_PARAMETERS + ATOMIC_SPECIES + ATOMIC_POSITIONS, and call hexa deck's general-cell prototype
(hexa-lang deck-rtsc-general-cell, PR #3730) so arbitrary low-symmetry hosts (monoclinic LiBeB etc.)
get a turnkey ibrav=0 deck — no hand-authored decks (d_deck_always). Lines use "|" separators (the
JSON spec carrier drops "\n"; hexa _rtsc_lines rejoins).

Usage:  python3 build_deck.py <mp-id> <slug> [ecutwfc] [ecutrho]
"""
import json, sys, subprocess, urllib.request, urllib.parse, os

# light-element masses + PSL PBE rrkjus UPFs (extend as needed; d13 element coverage)
MASS = {"Li":"6.941","Be":"9.0122","B":"10.811","C":"12.011","N":"14.007","H":"1.008",
        "Mg":"24.305","Al":"26.982","Si":"28.085"}
UPF = {"Li":"Li.pbe-s-rrkjus_psl.1.0.0.UPF","Be":"Be.pbe-n-rrkjus_psl.1.0.0.UPF",
       "B":"B.pbe-n-rrkjus_psl.1.0.0.UPF","C":"C.pbe-n-rrkjus_psl.1.0.0.UPF",
       "N":"N.pbe-n-rrkjus_psl.1.0.0.UPF","H":"H.pbe-rrkjus_psl.1.0.0.UPF",
       "Mg":"Mg.pbe-spnl-rrkjus_psl.1.0.0.UPF","Al":"Al.pbe-n-rrkjus_psl.1.0.0.UPF",
       "Si":"Si.pbe-n-rrkjus_psl.1.0.0.UPF"}

def mp_structure(mid, key):
    url = f"https://api.materialsproject.org/materials/summary/?" + urllib.parse.urlencode(
        {"material_ids":mid,"_fields":"structure,formula_pretty"})
    req = urllib.request.Request(url, headers={"X-API-KEY":key,"accept":"application/json",
                                               "User-Agent":"demiurge/1.0"})   # UA guard (403)
    with urllib.request.urlopen(req,timeout=60) as r:
        d = json.load(r)
    return d["data"][0]["structure"], d["data"][0]["formula_pretty"]

def build_spec(st, formula, mid, ecutwfc, ecutrho):
    M = st["lattice"]["matrix"]
    cellpar = "|".join(f"  {v[0]:.8f}  {v[1]:.8f}  {v[2]:.8f}" for v in M)
    order = []
    for s in st["sites"]:
        if s["label"] not in order: order.append(s["label"])
    for el in order:
        if el not in MASS or el not in UPF:
            raise SystemExit(f"d13: pseudo/mass missing for element {el} — add to build_deck.py tables")
    species = "|".join(f"  {el:<3} {MASS[el]:>8}  {UPF[el]}" for el in order)
    positions = "|".join(f"  {s['label']:<3} {s['abc'][0]:.8f} {s['abc'][1]:.8f} {s['abc'][2]:.8f}"
                         for s in st["sites"])
    return {"prototype":"general","prefix":formula.lower().replace(" ",""),"formula":formula,
            "nat":str(len(st["sites"])),"ntyp":str(len(order)),"cell_parameters":cellpar,
            "atomic_species":species,"atomic_positions":positions,"ecutwfc":ecutwfc,
            "ecutrho":ecutrho,"pressure_kbar":"0.0","structure_source":f"Materials Project {mid}"}

if __name__ == "__main__":
    if len(sys.argv) < 3:
        raise SystemExit("usage: build_deck.py <mp-id> <slug> [ecutwfc=60] [ecutrho=480]")
    mid, slug = sys.argv[1], sys.argv[2]
    ew = sys.argv[3] if len(sys.argv) > 3 else "60"
    er = sys.argv[4] if len(sys.argv) > 4 else "480"
    key = os.popen("secret get materialsproject.api_key").read().strip()
    st, formula = mp_structure(mid, key)
    spec = build_spec(st, formula, mid, ew, er)
    r = subprocess.run(["hexa","deck","rtsc",slug,json.dumps(spec)], capture_output=True, text=True)
    print(r.stdout or r.stderr)
    print(f"\n[deck] {formula} ({mid}) -> exports/rtsc/decks/{slug}/ (ibrav=0 general · {len(st['sites'])} atoms)")
    print("[next] d16 free dry-run (`pool on <host>`) -> vc-relax (ambient) -> scf flatness -> matdyn -> el-ph (d6).")
