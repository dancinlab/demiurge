# L44 (3) sparse many-body twist-D_s: resolve finite-density sign via larger mesh.
# scipy.sparse + eigsh(ground state only) -> N=5 (2pair, dim 90k) tractable.
import sys, numpy as np
from numpy.linalg import eigh
from itertools import combinations
import bisect
try:
    from scipy.sparse import csr_matrix
    from scipy.sparse.linalg import eigsh
except Exception as e:
    print("NO_SCIPY:",e,flush=True); sys.exit(1)
sx=np.array([[0,1],[1,0]],complex);sy=np.array([[0,-1j],[1j,0]],complex);sz=np.array([[1,0],[0,-1]],complex)
def uc(kx,ky,m):
    d=[np.sin(kx),np.sin(ky),m-np.cos(kx)-np.cos(ky)]
    w,v=eigh(d[0]*sx+d[1]*sy+d[2]*sz);return v[:,0]
def fsign(occ,kr,ka):
    o=sorted(occ);i=o.index(kr);s=(-1)**i;o.pop(i);j=bisect.bisect_left(o,ka);return s*((-1)**j)
def gs(m,U,N,n,th):
    ks=[(2*np.pi*a/N,2*np.pi*b/N) for a in range(N) for b in range(N)];Nk=len(ks)
    km=[(a,b) for a in range(N) for b in range(N)]
    uU=[uc(kx+th/N,ky,m) for kx,ky in ks];uD=[uc(kx,ky,m) for kx,ky in ks]
    st=list(combinations(range(Nk),n));ix={s:i for i,s in enumerate(st)};D=len(st);dim=D*D
    rows=[];cols=[];vals=[];Ua=U/Nk
    for iu,us in enumerate(st):
        sU=set(us)
        for idn,ds in enumerate(st):
            sD=set(ds);col=iu*D+idn
            for k4 in us:
                for k1 in range(Nk):
                    if k1!=k4 and k1 in sU:continue
                    for k3 in ds:
                        for k2 in range(Nk):
                            if k2!=k3 and k2 in sD:continue
                            if (km[k1][0]+km[k2][0]-km[k3][0]-km[k4][0])%N or (km[k1][1]+km[k2][1]-km[k3][1]-km[k4][1])%N:continue
                            amp=np.conj(uU[k1][0])*uU[k4][0]*np.conj(uD[k2][0])*uD[k3][0]+np.conj(uU[k1][1])*uU[k4][1]*np.conj(uD[k2][1])*uD[k3][1]
                            if amp==0:continue
                            if k1!=k4:
                                nu=sorted(list(us)+[k1]);nu.remove(k4);nu=tuple(nu);s1=fsign(us,k4,k1)
                            else:nu=us;s1=1
                            if k2!=k3:
                                nd=sorted(list(ds)+[k2]);nd.remove(k3);nd=tuple(nd);s2=fsign(ds,k3,k2)
                            else:nd=ds;s2=1
                            if nu in ix and nd in ix:
                                rows.append(ix[nu]*D+ix[nd]);cols.append(col);vals.append(Ua*amp*s1*s2)
    H=csr_matrix((vals,(rows,cols)),shape=(dim,dim));H=(H+H.getH())*0.5
    return eigsh(H,k=1,which='SA',return_eigenvectors=False)[0].real
def Ds(m,U,N,n,th=0.3):return 2*(gs(m,U,N,n,th)-gs(m,U,N,n,0.0))/th**2
print("[L44 (3) sparse many-body] 2pair twist-D_s vs N (odd 3,5 + even 4), U=-3",flush=True)
print("%4s | %9s %9s | %s"%("N","Ds(C1)","Ds(C0)","ratio"),flush=True)
for N in [3,4,5]:
    d1=Ds(1.0,-3.0,N,2);d0=Ds(3.0,-3.0,N,2)
    r=d1/d0 if abs(d0)>1e-12 else float('nan')
    fl="" if d1>d0 else " FLIP"
    print("%4d | %9.4f %9.4f | %.2f%s"%(N,d1,d0,r,fl),flush=True)
print("[VERDICT] N키울수록 ratio>1 수렴=many-body도 PASS / 계속FLIP·진동=유한밀도 미결",flush=True)
