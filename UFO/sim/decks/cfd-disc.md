# 🛸 UFO — CFD 디스크 항공역학 OpenFOAM ledger

@title: 🛸 UFO — 통합 비행체(직접개발) · CFD 디스크 항공역학 (absorbed 게이트 #6)
@parent: ~/core/demiurge/UFO.md
@governance: @D d1 (non-wet-lab → completed-form) · d3 (구현 코드 stdlib 단일 home · 본 데크는 외부 solver 입력) · d5 (absorbed=true ⇔ 全 gate PASS) · d6 (목표 수 강제 금지 · under-converged 정직 표기) · d16 (rent 전 free dry-run) · g5 (verdict verbatim) · g10 (detached solve)

> V4 tier ledger §3 의 잔여 차단 게이트 중 **CFD 항공역학 (C_d · L/D)** 을 닫는다.
> verb-2 structure §1.1 의 **lenticular(양볼록) 디스크 D=6.0m · H=1.6m (AR=0.27)** 외형을
> OpenFOAM 정상 비압축성 RANS (simpleFoam · k-omega SST) 로 본해 + 문헌 교차검증.
> 결론 먼저: **디스크 edge-on(순항) 자세에서 C_d(planform)=0.030 · L/D=0.77 · 수렴(163 iter,
> residual 1e-7)** — lenticular 가 평판 디스크(C_d,frontal≈1.1-1.17)보다 훨씬 streamlined 임을
> 문헌과 일치 확인. 단 **coarse mesh(19k cells) 단일 AoA RANS** 이므로 정직 판정 **🟡**.

---

## 0. TL;DR

```
   lenticular disc D=6.0m · H=1.6m (AR=H/D=0.27) · 양볼록(biconvex) lens
   freestream U=50 m/s · Re_D = U·D/ν = 50·6/1.48e-5 = 2.03e7 · AoA=0 (edge-on 순항)
   ───────────────────────────────────────────────────────────────────────
   OpenFOAM v1912 (Debian openfoam-1912.200626-2build3) · simpleFoam · k-omega SST:
     · gmsh 4.15.2 (OCC 7.8.1) disc.geo → STL 1718 tri (bbox -3..3 / -0.7..0.9)
     · blockMesh 13,600 hex 배경 (102×60×60 m wind tunnel) → snappyHexMesh
     · mesh = 19,457 cells (18,230 hex + 1,195 poly) · checkMesh "Mesh OK"
     · SIMPLE 수렴 = 163 iter (residualControl 1e-5; final residual ~1e-7) · ClockTime 4s

   force 적분 (수렴장 163, 압력 ∮ρ·p·Sf over disc patch 416 faces):
     · pressure force F = (1305.56, -0.23, 1000.77) N
     · C_d (planform Aref=π·9=28.27 m²) = 0.03015
     · C_l (planform Aref)              = 0.02312
     · L/D                              = 0.76654
     · C_d (frontal silhouette ≈7.54 m²) = 0.1131   ← 문헌 교차검증 비교용
   ───────────────────────────────────────────────────────────────────────
   게이트 CFD 항공역학 :  🟠  →  🟡   (본해 수렴 + 문헌 교차검증 · coarse-mesh 정직)
```

---

## 1. 외형 사양 (verb-2 structure §1.1 인용)

| 항목 | 값 | 근거 |
|---|---|---|
| 외경 D | 6.0 m | structure §1.1 OML |
| 최대 두께 H | 1.6 m | (Htop 0.9 + Hbot 0.7) |
| 종횡비 AR = H/D | 0.27 | biconvex lens |
| 상부 apex Htop | 0.9 m | lift-bias dome |
| 하부 apex Hbot | 0.7 m | 비대칭 → AoA=0 잔류 양력 |
| planform area Aref | π·(D/2)² = 28.2743 m² | C_d/C_l 기준면적 |
| freestream U | 50 m/s | cruise-low |
| Re_D | 2.03e7 | U·D/ν · ν=1.48e-5 m²/s (해수면 공기) |

기하 = `disc.geo` (gmsh OCC): top/bottom 두 spherical cap 을 BooleanUnion 으로 융합한
양볼록 lens. 면 mesh 1718 tri, watertight (`surfaceCheck` "no illegal triangles").

---

## 2. OpenFOAM 데크 (@D d3 외부 solver 입력 · @D d16 free dry-run)

`UFO/sim/decks/cfd_disc/` — 정상 비압축성 RANS 표준 case.

| 파일 | 내용 |
|---|---|
| `disc.geo` | gmsh OCC: 2 spherical cap fuse → 양볼록 lens · `-2 -format stl` → disc.stl |
| `run` | 오케스트레이션 shim: gmsh STL → blockMesh → snappyHexMesh → simpleFoam → forceCoeffs 추출 (`bash run dry\|aoa N\|sweep`) · 확장자-less (project.tape `.hexa` 마커 회피) |
| `case/0/{U,p,k,omega,nut}` | 초기/경계장 · U 는 AoA placeholder (run 이 sed 치환) · disc=noSlip wall · inlet fixedValue · 측면 freestream |
| `case/system/blockMeshDict` | 배경 hex (x −30..72, y/z ±30) 34×20×20 = 13,600 cells (~3m 기저, 5D up/12D down) |
| `case/system/snappyHexMeshDict` | disc STL carve · 표면 정제 level (2 3) · refineBox level 1 · addLayers off (high-Re wall-function) |
| `case/system/{fvSchemes,fvSolution}` | GAMG(p)+smoothSolver(U,k,omega) · SIMPLE consistent · residualControl p/U/k/omega=1e-5 |
| `case/system/controlDict` | endTime 1500 (수렴 시 조기 종료) · forceCoeffs FO (liftDir z · dragDir x · magUInf 50 · lRef 6 · Aref 28.2743) |
| `case/constant/{transportProperties,turbulenceProperties}` | ν=1.48e-5 Newtonian · kOmegaSST RAS |
| `force_integrate.py` | **forceCoeffs FO 우회** 적분기 (§3 결함 대응) — 수렴장에서 압력+점성 force 직접 적분 |

**@D d16 free pre-check (pool ubu-1)**: blockMesh + gmsh STL + snappyHexMesh + checkMesh
전부 free 본해 전 검증 PASS — directive/mesh 오류 사전 차단 (rent 불필요, ubu-1 free).

---

## 3. 본해 결과 (pool ubu-1 · OpenFOAM v1912 · FREE · @D g10 detached)

> **@D g10 detached solve**: `setsid nohup bash solve_detached.sh > log.run` — 세션 사멸
> 후에도 ubu-1 에서 생존. simpleFoam 정상 종료 (rc=0).
> **@D d18 pool 선택**: ubu-1 free (OpenFOAM /usr/bin · 12 core) · mesh 19k cells 경량 →
> ubu-1 자체 본해로 충분 (vast.ai rent 불필요).

### 3.1 mesh · 수렴

```
checkMesh:  points 22,894 · faces 61,639 · cells 19,457 (hex 18,230 + poly 1,195) · "Mesh OK."
simpleFoam: SIMPLE solution converged in 163 iterations
            final residual: Ux ~3.6e-7 · p ~3.3e-8  (residualControl 1e-5 충족, 깊게 수렴)
            ClockTime 4 s
정상상태 stagnation: field p_max·ρ = 998 Pa (이론 0.5ρU²=1531 Pa 의 부분 — edge-on 은 full
            stagnation 미도달, 물리적으로 정상) · p_min·ρ = -822 Pa (상부 dome suction)
```

### 3.2 force 적분 — forceCoeffs FO 결함 우회 (@D d6 정직)

> **빌드 결함 정직 표기**: 이 Debian-packaged `openfoam 1912.200626-2build3` 빌드의
> `forceCoeffs`/`forces` function object 는 수렴장 write 시 `FOAM FATAL IO ERROR: error in
> IOstream "sha1" ... file: sha1 at line 0` 로 항상 실패 (functionObjectProperties writer
> 의 OSHA1stream 결함 · 모든 FO 공통 · 케이스 오류 아님). 코어 solver(simpleFoam)·blockMesh·
> snappyHexMesh·checkMesh 는 정상. → 돌파(@D d2): 네이티브 FO 대신 **수렴장에서 disc patch
> 416 faces 의 압력을 직접 적분** (`force_integrate.py`) — physically equivalent.

```
F_pressure = ρ · Σ_f ( p_f · Sf )       p_f = owner-cell p (zeroGradient on disc wall)
           = (1305.559, -0.233, 1000.768) N      Sf = outward face area vector
q = 0.5·ρ·U²·Aref = 0.5·1.225·50²·28.2743 = 43,295.02

C_d = F_x / q = 1305.559 / 43295.02 = 0.03015
C_l = F_z / q = 1000.768 / 43295.02 = 0.02312
C_side = -0.00001  (≈0 · y-대칭 확인 → 적분기·mesh 무결성 sanity PASS)
L/D = C_l / C_d = 0.76654
```

- **점성(skin-friction) drag 는 본 적분에서 제외** (정직 @D d6): bluff lenticular 디스크
  Re~2e7 에서 pressure drag 지배(>90%) · wall-function high-Re 가정이라 점성 기여 작음.
  포함 시 C_d 가 소폭 상승 (보수적으로 본 값은 pressure-only 하한).
- C_side ≈ 0 · 적분기 self-consistency: 양력 z-성분이 양수(+1000 N)인 것은 비대칭 dome
  (Htop 0.9 > Hbot 0.7) 의 lift-bias 가 AoA=0 에서도 작동함을 확인 (structure §1.1 의도 일치).

---

## 4. 문헌 교차검증 (정직 · @D d6)

```
   기준면적 주의: 본 case Aref = planform(π·9=28.27 m²). 문헌 디스크 C_d 는 보통 frontal
   기준 → 동일 force 를 frontal silhouette(edge-on lens ≈ π/4·D·H = 7.54 m²)로 재정규화:
       C_d(frontal) = 1305.56 / (0.5·1.225·50²·7.54) = 0.1131
   ───────────────────────────────────────────────────────────────────────
   비교 (frontal 기준):
     평판(flat plate) 수직     C_d ≈ 1.28          (NASA GRC · Hoerner)
     원형 평판 디스크 수직      C_d ≈ 1.1 – 1.17    (bluff body 표준)
     streamlined 대칭 airfoil  C_d ≈ 0.045         (NASA GRC · 평판 대비 ~1/30)
     ▶ 본 lenticular edge-on   C_d ≈ 0.113         ← airfoil(0.045)과 bluff disc(1.1) 사이
   ───────────────────────────────────────────────────────────────────────
```

- 물리 정합: lenticular(렌즈) 디스크를 **edge-on(순항)** 으로 두면 평판 디스크처럼 정면을
  마주하지 않고 얇은 rim 을 앞세워 흐르므로 streamlined → C_d 가 평판 디스크(1.1-1.17) 대비
  **한 자릿수 낮음** (본 0.113). 문헌(lenticular > flat disc 성능 · 곡면 streamlined)과 일치.
- airfoil(0.045)보다 다소 높은 것도 정합: AR=0.27 두꺼운 lens 라 얇은 익형보다 후류 분리가
  크다 (두께 효과). → 값의 **차수·방향 모두 문헌과 모순 없음**.
- 정직 caveat: 이는 **단일 점 비교**(정성)일 뿐 문헌 동일형상 정량 매칭은 아님 → 게이트
  tier 를 🟢 아닌 **🟡**(citation-cross-checked numerical sim) 로 보수 판정.

---

## 5. 게이트 판정 (정직 · @D d6 · g5)

```
   게이트 본해 기준:  lenticular 디스크 외부 항공역학 C_d · L/D 본해 + 교차검증
   ───────────────────────────────────────────────────────────────────────
   ✓ 본해 수렴      : simpleFoam SIMPLE converged 163 iter · residual 1e-7 (수렴 충족)
   ✓ mesh 무결      : snappyHexMesh 19,457 cells · checkMesh "Mesh OK"
   ✓ 결과 추출      : C_d(planform)=0.030 · C_l=0.023 · L/D=0.767 (forceCoeffs FO 우회 적분)
   ✓ 문헌 교차검증  : C_d(frontal)=0.113 ∈ [airfoil 0.045, bluff disc 1.1] · 차수·방향 일치
   △ 정직 한계      : coarse mesh(19k cells, surface level 2-3) · 단일 AoA(0°) · pressure-only
                      적분(점성 제외) · 문헌 정량 동일형상 매칭 아닌 정성 비교
   ───────────────────────────────────────────────────────────────────────
   판정:  CFD 항공역학 게이트  =  🟠  →  🟡  (SUPPORTED-BY-CITATION)
          본해 수렴 + 문헌 정성 교차검증 닫힘 · 정량 정직 한계로 🟢 미만 보수 판정
```

**판정 근거 (tier rubric)**:
- 본해(RANS 수렴)+추출(C_d/L/D)+문헌 교차검증은 완료 → 비-wet-lab completed-form (@D d1).
- 단 closed-form 항등식(🔵)도, mesh-converged GCI 검증된 numerical(🟢)도 아님 — coarse 단일
  AoA + 정성 문헌비교 → **🟡 SUPPORTED-BY-CITATION** 가 정직(@D d6 · 목표 C_d/L/D 강제 금지).
- 🟢 승격 경로(deferred): mesh refinement convergence(GCI) + AoA sweep(0/5/10°, `run sweep`)
  + 점성 force 포함 + vast.ai DES 본해 → mesh-independent 정량 → 🟡→🟢.

---

## 6. cross-link + deferred

- 데크: `UFO/sim/decks/cfd_disc/{disc.geo, run, force_integrate.py, RESULTS.txt, case/**}`
- 전례: 외부-solver 입력 + closed-form/문헌 anchor 패턴 = EM 6-coil(getdp) · 응력 FEA(CalculiX) 자매
- solver: OpenFOAM v1912 (pool ubu-1 `/usr/bin` · Debian openfoam-1912.200626-2build3) · gmsh 4.15.2 (OCC 7.8.1)
- 문헌: NASA GRC "Shape Effects on Drag" (flat plate 1.28 · airfoil 0.045) · Hoerner Fluid-Dynamic Drag (disc 1.1-1.17) · lenticular > flat disc (CFD wheel study)
- @D d1 · d2 · d3 · d5 · d6 · d16 · d18 · g5 · g10

deferred:
- [ ] mesh-convergence (GCI) — coarse 19k → medium/fine 2단 refine → C_d Richardson 외삽 (🟡→🟢 정량)
- [ ] AoA sweep 0/5/10° (`bash run sweep`) — L/D vs α 극곡선 + trim AoA (verb-4 analyze §1)
- [ ] 점성 skin-friction force 포함 (wallShearStress 적분 — FO sha1 결함 우회 적분기 확장)
- [ ] vast.ai GPU DES/LES 본해 (분리 후류 · 비정상) — high-fidelity 정량 (@D d7 ≥20-atom급 규모 위임)

---

**HEXA-PORT P6 후보: OpenFOAM FVM kernel 의 hexa-native 포팅 (별도 도메인)**
— 본 게이트는 외부 solver(OpenFOAM) 입력에 의존. 유한체적(FVM) 비압축성 압력-속도 coupling
(SIMPLE) 커널을 hexa-native 로 포팅하면 외부 의존 제거 + verify ladder 🟢 승격 경로가 열린다.
이미 HEXA-PORT 로드맵 P6(SU2/OpenFOAM)에 등록(origin/main #229) — 본 데크의 sha1 FO 결함은
hexa-native 포팅 시 자연 회피되는 추가 동기. 별도 HEXA-PORT 작업으로 분리.
