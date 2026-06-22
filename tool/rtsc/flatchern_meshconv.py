import sys, numpy as np
from numpy.linalg import eigh
sx=np.array([[0,1],[1,0]],complex);sy=np.array([[0,-1j],[1j,0]],complex);sz=np.array([[1,0],[0,-1]],complex)
def lb(kx,ky,m):
    d=[np.sin(kx),np.sin(ky),m-np.cos(kx)-np.cos(ky)]
    w,v=eigh(d[0]*sx+d[1]*sy+d[2]*sz);return v[:,0]
def chern_g(m,N):
    ks=np.linspace(0,2*np.pi,N,endpoint=False);U=np.empty((N,N,2),complex)
    for a,kx in enumerate(ks):
        for b,ky in enumerate(ks):U[a,b]=lb(kx,ky,m)
    F=0.0
    for a in range(N):
        for b in range(N):
            ap,bp=(a+1)%N,(b+1)%N
            F+=np.angle(np.vdot(U[a,b],U[ap,b])*np.vdot(U[ap,b],U[ap,bp])*np.vdot(U[ap,bp],U[a,bp])*np.vdot(U[a,bp],U[a,b]))
    C=F/(2*np.pi); dk=ks[1]-ks[0]; g=0.0
    for a,kx in enumerate(ks):
        for b,ky in enumerate(ks):
            u0=lb(kx,ky,m);ux=lb(kx+dk,ky,m);uy=lb(kx,ky+dk,m)
            g+=(1-abs(np.vdot(u0,ux))**2)/dk**2+(1-abs(np.vdot(u0,uy))**2)/dk**2
    return C,g/(N*N)
def pair_invm(m,U,N):
    ks=[2*np.pi*i/N for i in range(N)];u=np.empty((N,N,2),complex)
    for a,kx in enumerate(ks):
        for b,ky in enumerate(ks):u[a,b]=lb(kx,ky,m)
    def pH(Qa,Qb):
        idx=[(a,b) for a in range(N) for b in range(N)];M=len(idx);H=np.zeros((M,M),complex)
        for I,(a,b) in enumerate(idx):
            qa=(Qa-a)%N;qb=(Qb-b)%N;u1=u[a,b];u2=u[qa,qb]
            for J,(c,d) in enumerate(idx):
                qc=(Qa-c)%N;qd=(Qb-d)%N;v1=u[c,d];v2=u[qc,qd]
                amp=np.conj(u1[0])*v1[0]*np.conj(u2[0])*v2[0]+np.conj(u1[1])*v1[1]*np.conj(u2[1])*v2[1]
                H[I,J]=(U/(N*N))*amp
        return np.linalg.eigvalsh(H)[0].real
    dQ=ks[1];return (pH(1,0)-pH(0,0))/dQ**2
print("[L44 2체 mesh-convergence] pair 1/m* vs N, C=1(m=1) vs C=0(m=3), U=-4",flush=True)
print("%4s | %7s %7s | %9s %9s | %s"%("N","C(m1)","C(m3)","1/m*(C1)","1/m*(C0)","ratio C1/C0"),flush=True)
for N in [6,8,10,12,16,20]:
    C1,_=chern_g(1.0,N);C0,_=chern_g(3.0,N)
    i1=pair_invm(1.0,-4.0,N);i0=pair_invm(3.0,-4.0,N)
    r=i1/i0 if abs(i0)>1e-12 else float('nan')
    print("%4d | %+7.2f %+7.2f | %9.5f %9.5f | %.1f"%(N,C1,C0,i1,i0,r),flush=True)
print("[VERDICT] ratio가 N키워도 >>1로 수렴하면 2체 처방 PASS=mesh-robust 확정",flush=True)
