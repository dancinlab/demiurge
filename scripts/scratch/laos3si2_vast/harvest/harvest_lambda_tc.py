#!/usr/bin/env python3
"""LaOs3Si2 2x2x2 DFPT el-ph harvest: lambda / omega_log / Allen-Dynes Tc.

q-star-weighted assembly (same method as LaRu3Si2, lambda.x DOS-mismatch bypass).
NAIVE = all modes (imaginary modes carry unphysical negative lambda).
PHYSICAL = imaginary modes (omega<=threshold) excluded — the trustworthy soft-mode
upper bound when the 2x2x2 grid is dynamically unstable (d6).
"""
import re, math, glob, os

HERE = os.path.dirname(os.path.abspath(__file__))
# q-star weights from ph_elph.out "Number of q in the star"
QFILES = [
    ("laos3si2.dyn1.elph.1", "laos3si2.dyn1", 1),
    ("laos3si2.dyn2.elph.2", "laos3si2.dyn2", 1),
    ("laos3si2.dyn3.elph.3", "laos3si2.dyn3", 3),
    ("laos3si2.dyn4.elph.4", "laos3si2.dyn4", 3),
]
NSIG = 10
SIG0, DSIG = 0.005, 0.005  # Ry
IMAG_THRESH_CM = 1.0       # |omega| below this (or negative) = imaginary/excluded

def parse_elph(path):
    """Return list (per broadening) of 18 lambda values."""
    txt = open(os.path.join(HERE, path)).read()
    blocks = re.split(r"Gaussian Broadening:", txt)[1:]  # one per sigma
    out = []
    for b in blocks:
        lams = [float(m) for m in re.findall(r"lambda\(\s*\d+\)=\s*(-?\d+\.\d+)", b)]
        out.append(lams)
    return out  # len NSIG, each 18

def parse_freq_cm(path):
    txt = open(os.path.join(HERE, path)).read()
    return [float(m) for m in re.findall(r"freq\s*\(\s*\d+\)\s*=\s*-?\d+\.\d+\s*\[THz\]\s*=\s*(-?\d+\.\d+)", txt)]

# load
qdata = []
for elph, dyn, w in QFILES:
    lams_per_sig = parse_elph(elph)
    freqs = parse_freq_cm(dyn)
    qdata.append((w, lams_per_sig, freqs))

CM_TO_K = 1.438776  # 1 cm-1 = 1.4388 K
Wtot = sum(w for w, _, _ in qdata)

def assemble(isig, physical):
    """lambda, omega_log(K) for a given broadening index."""
    num_lam = 0.0
    num_wlog = 0.0   # sum w_q lambda_qv ln(omega_qv)
    for w, lams_per_sig, freqs in qdata:
        lams = lams_per_sig[isig]
        for nu in range(len(lams)):
            om_cm = freqs[nu]
            lam = lams[nu]
            if physical and om_cm <= IMAG_THRESH_CM:
                continue  # drop imaginary/soft-unstable mode
            if not physical:
                # naive keeps everything (incl. negative lambda from imag modes)
                num_lam += w * lam
                if om_cm > IMAG_THRESH_CM and lam > 0:
                    num_wlog += w * lam * math.log(om_cm * CM_TO_K)
                continue
            num_lam += w * lam
            if lam > 0:
                num_wlog += w * lam * math.log(om_cm * CM_TO_K)
    lam_tot = num_lam / Wtot
    if lam_tot > 0 and num_wlog != 0:
        wlog = math.exp(num_wlog / (num_lam))  # ln-weighted by lambda
    else:
        wlog = float("nan")
    return lam_tot, wlog

def allen_dynes_tc(lam, wlog_K, mu):
    if lam <= mu * (1 + 0.62 * lam) or lam <= 0 or math.isnan(wlog_K):
        return 0.0
    return (wlog_K / 1.2) * math.exp(-1.04 * (1 + lam) / (lam - mu * (1 + 0.62 * lam)))

print(f"LaOs3Si2 2x2x2 DFPT el-ph harvest  (Wtot={Wtot}, q-star w=1,1,3,3)")
print(f"{'sigma(Ry)':>9} | {'NAIVE lam':>10} | {'PHYS lam':>9} {'wlog(K)':>9} {'Tc.10':>7} {'Tc.13':>7}")
for isig in range(NSIG):
    sig = SIG0 + isig * DSIG
    lam_n, _ = assemble(isig, physical=False)
    lam_p, wlog_p = assemble(isig, physical=True)
    tc10 = allen_dynes_tc(lam_p, wlog_p, 0.10)
    tc13 = allen_dynes_tc(lam_p, wlog_p, 0.13)
    print(f"{sig:9.3f} | {lam_n:10.3f} | {lam_p:9.3f} {wlog_p:9.2f} {tc10:7.2f} {tc13:7.2f}")

# count imaginary modes
print("\nimaginary-mode census (omega <= 1 cm-1):")
for (elph, dyn, w), (w2, _, freqs) in zip(QFILES, qdata):
    nimag = sum(1 for f in freqs if f <= IMAG_THRESH_CM)
    print(f"  {dyn}: {nimag}/18 imaginary (w={w}) min={min(freqs):.1f} cm-1")
