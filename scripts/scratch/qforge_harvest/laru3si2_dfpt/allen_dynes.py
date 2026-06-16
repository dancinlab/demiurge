#!/usr/bin/env python3
"""Allen-Dynes Tc from QE 'electron_phonon=simple' el-ph output for LaRu3Si2.

QE prints, per broadening sigma, q-resolved lambda(q,nu), gamma(q,nu), omega(q,nu),
and (when la2F) a q-summed lambda + omega_log. We harvest the FINAL summed
lambda + omega_log that QE prints (it already applies q-weights + the acoustic
sum rule via the dynamical matrices), then evaluate Allen-Dynes Tc.

Allen-Dynes (1975):
  Tc = (omega_log / 1.2) * exp( -1.04 (1+lambda) / (lambda - mu*(1 + 0.62 lambda)) )

No tuning to 7 K (c9/d6). Report what DFPT gives.
"""
import sys, math, json, re, glob, os

def allen_dynes(lam, wlog_K, mu):
    if lam <= mu*(1+0.62*lam):
        return 0.0
    return (wlog_K/1.2)*math.exp(-1.04*(1+lam)/(lam - mu*(1+0.62*lam)))

def parse_qe_elph(text):
    """Extract per-sigma summed lambda and omega_log if QE printed them.
    'electron_phonon=simple' prints per-q blocks; the la2F summary prints
    'lambda :  X.XXX   ...' lines. We collect the broadening table:
       'Broadening   X.XXXX  DOS(EF)= ...  lambda= ...  <log w>= ... K'
    QE matdyn/lambda summary format varies; we grep robustly.
    """
    res = {"per_sigma": [], "raw_lambda_lines": []}
    # ph.x simple prints lines like:
    #  lambda(    1)=  ...   (per q, per mode) and a final
    #  "lambda =   X   gamma=   Y  ..."  Plus broadening table from la2F.
    for m in re.finditer(r'Broadening\s+([\d.]+)\s+DOS\(EF\)?=?\s*([\d.eE+-]+).*?lambda\s*=?\s*([\d.eE+-]+).*?(?:<?\s*log\s*w?\s*>?\s*=?\s*([\d.eE+-]+))?', text):
        res["per_sigma"].append({"sigma": float(m.group(1)),
                                  "dos_ef": float(m.group(2)),
                                  "lambda": float(m.group(3)),
                                  "wlog_raw": m.group(4)})
    for ln in text.splitlines():
        if re.search(r'lambda', ln, re.I) and re.search(r'[\d.]', ln):
            res["raw_lambda_lines"].append(ln.strip())
    return res

if __name__ == "__main__":
    # accepts: lambda omega_log_K  (manual) OR a ph_elph.out path to grep
    if len(sys.argv) >= 3 and re.match(r'^[\d.]+$', sys.argv[1]):
        lam = float(sys.argv[1]); wlog = float(sys.argv[2])
        out = {"lambda": lam, "omega_log_K": wlog}
    else:
        path = sys.argv[1] if len(sys.argv) > 1 else "ph_elph.out"
        txt = open(path).read()
        p = parse_qe_elph(txt)
        print("PARSED per-sigma:", json.dumps(p["per_sigma"], indent=1))
        print("RAW lambda lines (first 30):")
        for l in p["raw_lambda_lines"][:30]:
            print("  ", l)
        sys.exit(0)
    for mu in (0.10, 0.13):
        tc = allen_dynes(out["lambda"], out["omega_log_K"], mu)
        print(f"mu*={mu}: Tc = {tc:.3f} K  (lambda={out['lambda']}, omega_log={out['omega_log_K']} K)")
