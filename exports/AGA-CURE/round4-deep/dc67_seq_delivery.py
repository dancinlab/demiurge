import numpy as np

# ===== DC6: 4-arm sequencing / timing dynamic model =====
# State = restored fraction per follicle-class. Three follicle populations:
#   F_mini  : miniaturized-but-alive (reversible) — responds to arm② reversal + arm① wake
#   F_dorm  : dormant HFSC (preserved bulge)      — responds to arm① reactivation
#   F_fibr  : fully-fibrosed (lost dermal niche)  — responds ONLY to arm④ neogenesis
# Coupling: arm④ neogenesis efficiency scales with the Wnt tone established by arm② (eff4 = base4 * (0.4 + 0.6*wnt))
# arm③ permanence lock multiplies the RETAINED fraction (relapse guard) but adds nothing if applied before gains realized.
print("=== DC6 4-arm sequencing — discrete-time gain model (t in months) ===")
def run(order, T=24):
    # population mass fractions of the balded scalp
    mass={'mini':0.45,'dorm':0.30,'fibr':0.25}
    state={'mini':0.0,'dorm':0.0,'fibr':0.0}   # restored fraction within each class
    wnt=0.0; locked=False; lock_t=None
    # per-arm monthly rate constants (fraction of remaining gap closed / month)
    k={'rev':0.35,'wake':0.30,'neo':0.18}
    active=set()
    schedule={}  # arm -> start month from `order` (staggered every 2 mo as listed)
    for i,a in enumerate(order): schedule[a]=i*2
    for t in range(T):
        for a,st in schedule.items():
            if t>=st: active.add(a)
        if 'rev'  in active: wnt = wnt + 0.25*(1-wnt)           # reversal builds Wnt tone
        if 'rev'  in active: state['mini'] += k['rev'] *(1-state['mini'])
        if 'wake' in active:
            state['dorm'] += k['wake']*(1-state['dorm'])
            state['mini'] += 0.5*k['wake']*(1-state['mini'])    # wake also helps mini
        if 'neo'  in active:
            eff4 = k['neo']*(0.4+0.6*wnt)                       # COUPLING: neogenesis needs Wnt tone
            state['fibr'] += eff4*(1-state['fibr'])
        if 'lock' in active and not locked:
            locked=True; lock_t=t
    restored = sum(state[c]*mass[c] for c in mass)
    # relapse over 5yr after stopping: locked → near-0; unlocked → decays
    relapse = 0.05 if locked else 0.45
    # lock value: only counts gains present AT lock time → penalize early lock
    realized_at_lock = restored if (lock_t is not None and lock_t>=18) else (restored*0.6 if lock_t is not None else restored)
    final = realized_at_lock*(1-relapse)
    return restored, relapse, final, wnt
orders={
 "②→①→④→③ (rev,wake,neo,lock)":['rev','wake','neo','lock'],
 "①→②→④→③ (wake,rev,neo,lock)":['wake','rev','neo','lock'],
 "③ first (lock,rev,wake,neo)":['lock','rev','wake','neo'],
 "④ first (neo,rev,wake,lock)":['neo','rev','wake','lock'],
 "all-concurrent then lock":['rev','wake','neo','lock'],  # handled same sched; informative baseline
}
print(f"{'order':40s} {'restored':>9s} {'relapse':>8s} {'wnt':>6s}  {'FINAL':>7s}")
best=None
for nm,o in orders.items():
    r,rel,fin,w=run(o)
    print(f"{nm:40s} {r:9.3f} {rel:8.2f} {w:6.2f}  {fin:7.3f}")
    if best is None or fin>best[1]: best=(nm,fin)
print(f"→ best sequence: {best[0]} (final restored-after-relapse {best[1]:.3f})")

# ===== DC7: arm③ epigenetic-editor delivery (dCas9-KRAB ~4.1kb cargo) =====
print("\n=== DC7 arm③ epigenetic-editor delivery — 5 routes ===")
# axes: cargo-fit (does payload fit?), skin/DPC-tropism, durability(epigenetic memory retained), safety/immunogenicity
rows=[
 ("single-AAV dCas9-KRAB",      0.15,0.70,0.80,0.65),  # 4.1kb+effector+promoter > 4.7kb ceiling → cargo FAILS
 ("dual-AAV split-intein",      0.75,0.70,0.80,0.60),  # splits cargo, recombines; lower efficiency, 2-vector dose
 ("CasMINI / Cas12f (~1.6kb)",  0.90,0.70,0.78,0.70),  # compact editor fits single-AAV easily
 ("LNP-mRNA (transient editor)",0.85,0.55,0.75,0.80),  # transient expression OK (epigenetic edit is heritable post-edit), skin-LNP harder
 ("polymer nanoparticle",       0.70,0.45,0.70,0.65),  # flexible cargo but weak DPC tropism
]
print(f"{'route':30s} {'cargo':>6s} {'tropism':>8s} {'durab':>6s} {'safety':>7s}   FIT")
b=None
for nm,*v in rows:
    fit=float(np.prod(v))**(1/len(v))
    print(f"{nm:30s} "+" ".join(f"{x:6.2f}" for x in v)+f"   {fit:.3f}")
    if b is None or fit>b[1]: b=(nm,fit)
print(f"→ best delivery: {b[0]} ({b[1]:.3f})")
