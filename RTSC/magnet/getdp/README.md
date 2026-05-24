# RTSC magnet — GetDP 2-D 축대칭 자기정역학 템플릿

RTSC 자석 sub-track 의 GetDP(오픈소스 FEM) 2-D 축대칭(axisymmetric) 자기정역학
템플릿 모음. 코일 권선의 진공/공기 자기장을 선형 A-φ formulation 으로 푼다.

> 정직한 범위(commons g3): **선형 · μ_r = 1 전역**. 규정된 engineering 전류밀도가
> 만드는 공기/진공 자기장만 모델링한다. HTS 임계상태(Jc(B,T,θ)) · 퀀치 · ramp loss ·
> 3-D end effect 는 **미반영**. HTS-grade 물리는 별도 H-formulation 트랙(multi-week)
> 영역. RTSC.md §4.3 caveats 참조.

## 파일

| 파일 | 역할 |
|---|---|
| `solenoid_axisym.pro` | **공용 problem 정의** — A-φ 선형 (`magstat_a_linear`). geo 와 무관하게 동일 물리. |
| `solenoid_axisym.geo` | 솔레노이드 형상 (직사각 환형 권선, 좁고 긴 단면). |
| `pancake_axisym.geo`  | 팬케이크 형상 stub (평면 나선 → 넓고 얇은 단면). **동일 `.pro` 재사용.** |

세 파일은 **동일한 physical-group 계약**을 공유하므로 `solenoid_axisym.pro` 가
두 `.geo` 모두에서 그대로 돈다:

| Physical group | tag | 의미 |
|---|---|---|
| Surface `AIR`     | 1000 | 공기/진공 (μ_r = 1) |
| Surface `COIL`    | 2000 | 권선 단면 (J_φ 소스) |
| Curve `AXIS`      | 3000 | r=0 대칭축 (Dirichlet A=0) |
| Curve `FAR_BND`   | 4000 | 절단 경계 (Dirichlet A=0) |

좌표 규약: gmsh x → r, gmsh y → z. Jacobian 은 `VolAxiSqu` (2π·r measure,
축 r=0 에서 정칙).

## 실행 방법

### 1) 메시 생성 (Gmsh)

```sh
gmsh solenoid_axisym.geo -2 -o solenoid.msh    # 솔레노이드
gmsh pancake_axisym.geo  -2 -o pancake.msh     # 팬케이크
```

### 2) 풀기 + 후처리 (GetDP)

```sh
# 솔레노이드 (기본 파라미터: N=120, I=100A, A_coil=0.005)
getdp solenoid_axisym.pro -msh solenoid.msh \
      -solve MagStat -pos MagStat -setstring OUT_DIR ./out_sol

# 팬케이크 — 동일 .pro, 권선 단면적만 형상에 맞게 전달
#   A_coil = (R_OUTC - R_IN) * H_PANCAKE = (0.150-0.030)*0.012 = 0.00144
getdp solenoid_axisym.pro -msh pancake.msh \
      -solve MagStat -pos MagStat -setstring OUT_DIR ./out_pan \
      -setnumber A_COIL 0.00144 -setnumber Z_SWEEP 0.3
```

파라미터는 `DefineConstant[...]` 로 기본값이 박혀 있어 인자 없이도 실행되며,
`-setnumber N_TURNS 240`, `-setnumber I_CURRENT 150` 등으로 덮어쓴다.

### 3) 출력 (`OUT_DIR/`, Format Table 평문)

| 파일 | 내용 |
|---|---|
| `bmag_center.txt`   | 중심(r=0,z=0) `\|B\|` — ⚠ 축 노드 정확히 r=0 에서 1/r 특이점. **on-axis 값은 `bmag_axis.txt` 의 z=0 샘플을 권장**. |
| `bz_center.txt`     | 중심 Bz (부호 있음). |
| `bmag_axis.txt`     | 축 z ∈ [-Z_SWEEP, +Z_SWEEP] `\|B\|` 200 샘플 — on-axis 프로파일. |
| `stored_energy.txt` | 총 자기에너지 W → 인덕턴스 L = 2W/I². |

검증 참고: 본 템플릿 기본 솔레노이드는 z=0 on-axis `|B| ≈ 0.0684 T` 로,
RTSC.md §4.2.1 cross-check record 의 FEM 값(0.06842 T)과 일치.

## 별도 milestone — scipy Wheeler 교차검증

축상(on-axis) B 의 **scipy closed-form Wheeler 공식 교차검증**은 이 디렉토리
범위 밖의 **별도 milestone** 이다 (RTSC.md §5 Axis C: "scipy closed-form
parallel verifier · Wheeler formula on-axis B"). FEM 결과를 해석해(analytic)와
대조하는 cross-check 는 `getdp_hts.py` (hexa-lang stdlib) 의 V1 closed-form ⨯
V2 getdp 경로에서 수행한다.

> 구현 코드 SSOT (@D d3): 실제 producer/solver 코드는 hexa-lang stdlib
> (`stdlib/rtsc/getdp_hts.py`) 에 산다. 이 폴더는 형상/문제정의 **템플릿**(문서격)
> 만 보관한다.
