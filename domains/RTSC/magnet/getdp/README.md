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

## Wheeler closed-form 병렬 검증 — `wheeler_axis_b.hexa`

축상(on-axis) `B_z` 의 **유한 솔레노이드 Wheeler 폐형식(closed-form) 병렬
검증기**. M318 (RTSC.md §5 Axis C: "scipy closed-form parallel verifier ·
Wheeler formula on-axis B") 의 `.hexa` 구현이다. `.hexa-only` 제약
(`reference_demiurge_sim_hexa_only.md`) 하에서 M318 의 "scipy" 는 폐형식
재계산의 약칭으로 해석된다 — Wheeler 식은 외부 의존(`scipy`) 없이
`self/runtime/math_pure` (`sqrt_pure`) 만으로 닫힌다.

**식** (μ_r=1, 축상, 박판 이상화):

```
B_z(z) = (μ₀·N·I / 2L) · [ (z+L/2)/√((z+L/2)²+R²)
                         − (z−L/2)/√((z−L/2)²+R²) ]
```

**범위/한계**: μ_r=1 · 축상(on-axis)만 · 박판(thin-shell) 이상화. 따라서 단일
유효반경 `R_eff = (R_IN + R_OUTC)/2` 에서의 값을 보고하며, 두꺼운 권선의 FEM
적분값과는 본질적으로 ~수 % 의 thin-shell 갭이 생긴다. End-effect 자체는
finite-length 항이 잡지만, ramp loss · 퀀치 · Jc(B,T,θ) 같은 HTS 임계상태
효과는 미반영 (RTSC.md §4.3 caveats 동일).

**실행**:

```sh
hexa run RTSC/magnet/getdp/wheeler_axis_b.hexa
```

**무엇을 cross-check 하는가**: `solenoid_axisym.{pro,geo}` 의 §4.2.1 기준 형상
(N=120, I=100 A, L=0.200 m, R_IN=0.030 m, R_OUTC=0.055 m) 의 GetDP FEM
출력 `bmag_axis.txt` 의 `z=0` 샘플 (≈ 0.06842 T) 과 Wheeler 폐형식
`B_z(R_eff, z=0)` 값을 |Δ| · rel% 로 대조한다. 동시에 z ∈ {0, L/4, L/2}
스윕과 `{B(R_IN), B(R_eff), B(R_OUTC)}` 두꺼운-권선 envelope 도 출력하여
FEM 값이 envelope `(B(R_OUTC), B(R_IN))` 안에 들어가는지 확인한다.

**해석적 한계 sanity** (회귀-잠금용):

- 장(長) 솔레노이드 극한 `L/R=50` → `B_z(0) → μ₀·n·I` (0.5 % 이내)
- 원거리 감쇠 `|z|=50·L` → `B_z` ≲ 1 µT
- 축대칭 `B_z(+z) = B_z(-z)`

**`getdp` 부재 시 정직 강등(honest-degrade)**: 본 검증기는 hexa 안에서 `getdp`
를 직접 호출하지 않는다 (`.hexa-only` · 본 디렉토리의 GetDP 파이프라인은
README 상단 절차로 별도 실행). FEM 기준값은 §4.2.1 기록의 `0.06842 T` 를
파일 내 상수로 고정해두며, getdp 가 PATH 에 없어도 Wheeler 폐형식 단독으로
유효하다 — 폐형식이 **독립** 병렬 검증기이고 FEM 은 선택적 교차참조다.

**구현 위치 결정 (@D d3 + @D g61)**: Wheeler 폐형식 **원자(primitive)** 는
hexa-lang PR #892 로 stdlib SSOT (`stdlib/material/magnet/wheeler.hexa`) 에
이전 완료. 본 파일(`wheeler_axis_b.hexa`)은 이제 **얇은 wrapper** 로 축소되어,
stdlib 의 `wheeler_bz` / `wheeler_envelope` 를 `use` 한 뒤 RTSC.md §4.2.1
의 FEM 기준값 `FEM_BZ_Z0 = 0.06842 T` 와의 **도메인 특수 교차검증 driver** 만
남긴다. 일반 폐형식의 해석적 한계 sanity (long-solenoid · far-field ·
symmetry · envelope ordering · linearity) 는 모두 stdlib 측 self-test 가
담당한다 — 본 wrapper 의 falsifier 두 개는 RTSC §4.2.1 record 특정의
3 % 합치 + envelope-bracket 만 검증.

---

## 구현 코드 SSOT (@D d3)

실제 일반 producer/solver 코드는 hexa-lang stdlib 에 산다:

- 일반 GetDP HTS producer: `stdlib/rtsc/getdp_hts.py`
- Wheeler 폐형식 primitive: `stdlib/material/magnet/wheeler.hexa`
  (`wheeler_bz`, `wheeler_envelope` — hexa-lang PR #892)

이 폴더는 형상/문제정의 **템플릿**(문서격) + 위 Wheeler stdlib 를 wrapping
하는 RTSC §4.2.1 **도메인 특수 교차검증기** 만 보관한다.
