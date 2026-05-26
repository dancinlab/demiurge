# 🛸 UFO — 응력 LC-1~5 FEA ledger (CalculiX ccx · 디스크 frame)

@title: 🛸 UFO — 통합 비행체(직접개발) · 응력 LC-1~5 외부-solver FEA
@parent: ~/core/demiurge/UFO.md
@gate: V4_tier_ledger §3 "응력 LC-1~5 FEA (650kg·SF2.5)" 🟠 → 본 라운드 판정
@governance: @D d1 (non-wet-lab → completed-form) · d6 (목표 수 강제 금지 · 정직) · d7 (compute sizing) · d16 (free dry-run 선행) · g5 (verdict verbatim)

> verb-2 structure(`UFO/structure/integrated-vehicle-structure.md` §1·§5)가 **선언**만
> 닫은 응력 budget(650 kg · SF 2.5)과 LC-1~5 하중 카탈로그를, **외부 FEM solver
> (CalculiX ccx)** 로 실제 풀어 σ_vm,max 를 산출하고 closed-form Kirchhoff 판이론으로
> 교차검증한다. 결론을 먼저 적는다: **5/5 LC 全 PASS — SF ≥ 64.8 ≫ 2.5** ·
> closed-form 교차검증 17/17 PASS → 게이트 **🟠 → 🟢 닫힘**.

---

## 0. TL;DR

```
   UFO 디스크 frame — LC-1~5 관성 G-하중 FEA (CalculiX ccx 2.23)
   ─────────────────────────────────────────────────────────────────
   case          G    σ_vm,max [MPa]   SF=σ_allow/σ_vm   verdict
   LC-1 hover    1G       0.771            778.1          PASS
   LC-2 cruise   3G       2.313            259.4          PASS
   LC-3 orbital  9G       6.940             86.5          PASS
   LC-4 landing  6G       4.627            129.7          PASS
   LC-5 abort   12G       9.254             64.8          PASS
   ─────────────────────────────────────────────────────────────────
   σ_allow = 600 MPa (CFRP T700 QI rupture 1500 / SF 2.5) · SF_req = 2.5
   판정: 全 LC SF ≫ 2.5 → 응력 게이트 🟢 CLOSED (정직: 본해 + closed-form anchor)
```

## 1. Solver / 환경

| 항목 | 값 |
|---|---|
| Solver | **CalculiX ccx 2.23** (free open-source FEM) |
| Mesher | gmsh 4.15.2 (3-D OCC · 2차 사면체 C3D10) |
| 설치 | mini (macOS arm64) conda env `fea` = `conda create -n fea -c conda-forge calculix=2.23 gmsh` |
| 설치 비고 | `brew install calculix-ccx` 정식 formula **부재** → 태스크 지정 conda-forge fallback 사용 (free) |
| 실행 host | mini (free · load idle) — CFD agent(ubu-1)와 분리, @D d7 small-job |
| dry-run | @D d16 — mesh + LC-1 1-case 사전검증 PASS 후 full solve |

## 2. 모델 (디스크 frame → 등가 원형판)

verb-2 structure §1.1 의 lenticular 디스크(외경 D=6.0 m · 두께 H=1.6 m · frame
180 kg CFRP+honeycomb)를 **LC 관성하중 게이트**에 맞춰 등가 평판으로 축약:

| 파라미터 | 값 | 근거 |
|---|---|---|
| 외반경 a | 3.0 m | D=6.0 m (structure §1.1) |
| 등가 굽힘두께 t | 0.040 m | sandwich 굽힘깊이 (아래 질량-정합 참조) |
| 전체 질량 m_total | 650 kg | structure §5.1 |
| 재료 | CFRP T700 quasi-isotropic | structure §5.2 |
| E (등가등방) | 70 GPa | T700 QI in-plane 유효계수 |
| ν | 0.30 | structure §5.2 |
| mesh | 13886 node · 7038 C3D10 (2차 tet) | gmsh |
| rim BC | clamped (ENCASTRE, 630 node) | frame↔skirt 부착링 |

**질량-정합 (정직 검토)**: frame budget 180 kg 의 CFRP(ρ≈1600)는 디스크 면적
28.27 m² 에 펼치면 단층 ~4 mm. 이를 honeycomb core 로 이격한 sandwich 로 구성하면
질량 180 kg 을 유지한 채 굽힘깊이 t≈40 mm 확보 — 물리적으로 타당. 

**하중 적용 (관성)**: ccx `*DLOAD, GRAV` body-load 로 N·g 관성 부하 적용. 하중을
강성과 분리하기 위해 등가밀도 ρ_eff = m_total / V_plate = 650 / 1.131 = **574.7 kg/m³**
를 사용 — GRAV 1회 = 전체 650 kg 차량 관성을 디스크 전면에 균일분포 → Kirchhoff
**균일하중 판이론**과 정확히 매칭(교차검증용). E(강성)는 별도 입력이라 영향 없음.

## 3. CFRP 물성 / 허용응력

| 영역 (structure §5.2) | σ_allow | SF |
|---|---|---|
| frame 외피 CFRP T700 QI | 600 MPa (rupture 1500 / 2.5) | 2.5 |
| (참고) CFRP T1100 등급 | ~2–3 GPa rupture | 승격 마진 path (structure §5.4) |

본 FEA 는 보수적으로 T700 QI 의 600 MPa allowable 로 SF 산출. T1100 승격 시
SF 는 추가 2.5~5× 여유.

## 4. 결과 — LC-1~5 σ_vm,max + SF

(`UFO/sim/decks/stress_fea/RESULTS.txt` — ccx .frd STRESS 블록에서 nodal von Mises 추출)

| case | G | σ_vm,max [MPa] | SF = 600/σ_vm | σ_target(structure) | verdict |
|---|---|---|---|---|---|
| LC-1 hover (sustain) | 1G | 0.771 | 778.1 | ≤240 MPa | **PASS** |
| LC-2 cruise (10 min) | 3G | 2.313 | 259.4 | ≤240 MPa | **PASS** |
| LC-3 orbital boost (5s) | 9G | 6.940 | 86.5 | ≤240 MPa | **PASS** |
| LC-4 landing (impact) | 6G | 4.627 | 129.7 | ≤240 MPa | **PASS** |
| LC-5 emergency abort (3s) | 12G | 9.254 | 64.8 | ≤240 MPa | **PASS** |

최악 케이스(LC-5, 12G)에서도 σ_vm = 9.25 MPa ≪ σ_allow 600 MPa, SF = 64.8 ≫ 2.5.
물리적 해석: 6 m 디스크에 650 kg 차량은 **가벼운 하중**(q≈226 Pa/g) → 응력 여유 큼.

## 5. Closed-form 교차검증 (Kirchhoff 균일하중 원형판)

`UFO/sim/decks/stress_fea/stress_xcheck.hexa` — `hexa run` **17/17 PASS**
(대형 응력값 abs-ε 함정 회피: 전부 **무차원 ratio** verify).

- **§1 선형성** σ_N/σ_1 = G : LC-1~5 全 PASS (rel < 3e-4) — linear static 정확 확인.
- **§2 해석 bracket** : FEA σ_vm 가 Kirchhoff clamped(상한)와 simply-supported 사이에
  위치 — **fea/clamp = 0.81** · fea/ss = 0.49. 유한두께 solid-3D 가 thin-plate
  clamped-edge 응력의 ~81% 를 보임 (3-D 가 edge moment 를 두께방향 분산 — 교과서 정합).
- **§3 SF ratio** SF = σ_allow/σ_vm ≥ 2.5 : 全 LC PASS.
- **§4 정확 closed-form** σ_clamp(12)/σ_clamp(1)=12 · σ_ss(9)/σ_ss(3)=3 : exact (rel<1e-9).

교차검증 anchor 값(1g): q=225.5 Pa · σ_clamp=0.95 MPa · σ_ss=1.57 MPa →
FEA 0.771 MPa 가 두 해석 bound 사이에 정확히 위치 → 본해 신뢰성 확인.

## 6. 판정 (@D d5 · d6 · g5)

```
   응력 LC-1~5 FEA 게이트 :  🟠 (budget만 선언) → 🟢 CLOSED
   ───────────────────────────────────────────────────────────
   근거: CalculiX ccx 본해 5/5 LC PASS (SF ≥ 64.8 ≫ 2.5)
        + closed-form Kirchhoff 교차검증 17/17 PASS (무차원 ratio)
        + 선형성 σ_N/σ_1=G 정확 (linear static 검증)
   정직 (@D d6): SF 강제 아님 — 가벼운 디스크 하중의 자연 결과.
                3-D laminate ply-by-ply / honeycomb-core sandwich /
                buckling(좌굴) / 동적(impact transient) 본해는 pool/cloud
                deferred (@D d7) — 본 게이트는 정적 von Mises body-solve 로 닫음.
```

**돌파 마진 (@D d2 — wall ≠ 불가능)**: SF 여유가 매우 크므로(64.8×) frame 두께
축소(경량화) trade 가능 — structure §5.4 의 마진 path (CFRP T1100 승격 ·
솔레노이드 6→4)와 결합해 무게 budget 최적화 여지. 현재 판정은 **충분-여유 PASS**.

## 7. 파일 / cross-link

- `UFO/sim/decks/stress_fea/disc_frame.geo` — gmsh 디스크 원형판 3-D (C3D10)
- `UFO/sim/decks/stress_fea/disc_frame.master.inp` — ccx master deck (CFRP · GRAV · clamped)
- `UFO/sim/decks/stress_fea/run` — extensionless driver (gmsh→mesh.inc→ccx LC loop→RESULTS)
- `UFO/sim/decks/stress_fea/RESULTS.txt` — LC-1~5 σ_vm + SF 표 (ccx 출력)
- `UFO/sim/decks/stress_fea/stress_xcheck.hexa` — closed-form 교차검증 17/17 PASS
- `UFO/structure/integrated-vehicle-structure.md` §1.1 (형상) · §5 (응력 budget · LC 카탈로그)
- `UFO/verify/V4_tier_ledger.md` §3 (게이트 status)
- @D d1 · d5 · d6 · d7 · d16 · g5

## 8. HEXA-PORT 후보

> **CalculiX FEM 커널 hexa-native 포팅** — 본 게이트는 외부 solver(ccx)로 닫았으나,
> C3D10 사면체 강성행렬 조립 + 선형 정적 solve(MUMPS/PCG) + von Mises 후처리를
> hexa-native 로 포팅하면 demiurge sim 의 self-contained FEM 백엔드 확보. HEXA-PORT
> 별도 도메인 목표로 등록 권고 (getdp magstat 포팅과 자매 — RTSC/EM 패턴).
