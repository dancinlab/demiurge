import warnings, json, sys
warnings.filterwarnings("ignore")
from admet_ai import ADMETModel
leads = {
 "WAY-316606":"C1CNCCC1NS(=O)(=O)C2=C(C=CC(=C2)S(=O)(=O)C3=CC=CC=C3)C(F)(F)F",
 "2-naphthylguanidine":"NC(=N)Nc1ccc2ccccc2c1",
 "4-guanidinobenzoic_acid":"OC(=O)c1ccc(cc1)NC(=N)N",
 "tyramine-guanidine_hybrid":"Oc1ccc(cc1)CCNC(=N)N",
}
m = ADMETModel()
out = {}
for n,smi in leads.items():
    p = m.predict(smiles=smi)
    out[n] = p
json.dump(out, open("/tmp/aga_admet_full.json","w"), indent=1, default=str)
# print the keys once
print("KEYS:", sorted(list(next(iter(out.values())).keys())))
