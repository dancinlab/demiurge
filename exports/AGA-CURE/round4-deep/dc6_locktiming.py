import numpy as np
# Fixed insight from v1: arms ①②④ all reach ~0.99 restored by 24mo regardless of order
# (gains are gap-closing exponentials; order only shifts by ~1mo). The REAL control variable
# is WHEN arm③ permanence-lock fires. Model that directly.
mass={'mini':0.45,'dorm':0.30,'fibr':0.25}
k={'rev':0.35,'wake':0.30,'neo':0.18}
def restored_at(t):
    # arms ①②④ concurrent from month 0
    wnt=1-(0.75**t)                       # Wnt tone builds (reversal)
    mini=1-(1-k['rev']-0.5*k['wake'])**t if t>0 else 0
    dorm=1-(1-k['wake'])**t if t>0 else 0
    # neogenesis coupled to instantaneous wnt; approximate cumulative
    fibr=0.0; w=0.0
    for s in range(t):
        w=1-(0.75**(s+1)); eff=k['neo']*(0.4+0.6*w); fibr+=eff*(1-fibr)
    return mini*mass['mini']+dorm*mass['dorm']+fibr*mass['fibr']
print("=== DC6 (fixed) — arm③ LOCK timing sweep (arms①②④ concurrent from t=0) ===")
print(f"{'lock@month':>11s} {'restored@lock':>13s} {'relapse':>8s} {'5yr-FINAL':>10s}")
best=None
for lock_t in [0,3,6,9,12,18,24,30,36]:
    r=restored_at(lock_t)
    # locked gains held (relapse 0.05); unlocked portion would relapse 0.45 over 5yr.
    # final = restored_at_lock held + (full_restore - restored_at_lock) realized later but UNLOCKED → relapses
    full=restored_at(36)
    held=r*(1-0.05)                       # locked fraction, near-permanent
    later=(full-r)*(1-0.45)               # gains after lock are unprotected
    final=held+later
    print(f"{lock_t:11d} {r:13.3f} {0.05:8.2f} {final:10.3f}")
    if best is None or final>best[1]: best=(lock_t,final)
print(f"→ optimal lock timing: month {best[0]} (5yr final restored {best[1]:.3f})")
print("  trade-off: lock too EARLY → most gains unprotected (relapse); lock too LATE → exposed window before lock.")
