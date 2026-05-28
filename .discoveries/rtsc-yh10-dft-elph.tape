@V := "discovery" :: rtsc-yh10-dft-elph [active]
  date    = "2026-05-28"
  seed    = "YH10 wave3 first terminal el-ph harvest — q-weighted lambda + Allen-Dynes Tc @ ~250 GPa"
  domain  = "RTSC"
  mechanism = "Y-H sodalite clathrate: H2-cage + Y interstitial -> strong el-ph coupling (lambda 2.8) at high pressure; conventional BCS phonon-mediated, strong-coupling regime (m-sign +)"

# verified DFT el-ph result (verdict-tier = GREEN, hexa verify allen_dynes_tc verbatim)
@F f1 := "YH10 @250GPa: lambda=2.82, omega_log=1300K, Tc=216-228K (Allen-Dynes)" :: verified [active]
  producer = "QE 7.5 ph.x electron_phonon=simple, 4x4x4-q (8/8 IBZ complete, star weights sum 64), vast pod-2 /root/wave3/YH10"
  pressure = "vc-relax P=2499.98 kbar (~250 GPa); 0 imaginary modes (dynamically stable)"
  lambda   = "2.8197 (sigma=0.020 Ry, center of 0.010-0.030 plateau spanning 2.51-3.02)"
  omega_log = "1300.43 K (903.85 cm-1)"
  tc       = "227.501 K (mu*=0.10) / 215.916 K (mu*=0.13) — both hexa verify allen_dynes_tc GREEN SUPPORTED-NUMERICAL"
  m_sign   = "+ (m=(2.8197-2.5)/2.8197=+0.113) -> strong-coupling side (lambda>2.5)"
  record   = "exports/material_discovery/rtsc_yh10_dft_elph_20260528.json"
  status   = "GREEN measured-grade; pressure-bound (~250 GPa) NOT ambient -> not RTSC by ambient gate; high-Tc (NOT low-Tc/closed-negative)"
  target   = "lambda-ladder cross-check vs CaH6 (3.4-4.4) + H3S anchors; denser q-grid / higher-P run for lit ~300K comparison"
