# M5-MN MD/QM 실행 하네스 — push-button 매니페스트

> scope: TTR-MN M5 (12-cell 잉크-활성분자 MD/QM) 를 **렌트 직전까지 무료로 준비**해 둔 하네스.
> 원칙: demiurge = 매니페스트/문서 (@D d3) · 실행 엔진 = `hexa cloud` (@D g8) · 렌트 = 실비 (별도 최종확인).
> 상태: **준비중 (rent 미발사 · 과금 0)**.

## 1. 무엇 / 비유

🧪 **M5 하네스 — "분자 반응 시뮬 12판짜리 요리 키트"**
- 하는 일: 후보물질(CeO₂·DyP·AzoR·DFO…) × 잉크(azo·Cu-Pc·Fe₂O₃…) × pH 조합 12개를 GPU에서 MD/DFT로 돌려 ΔG·Ea·ROS·결합력 산출
- 비유: 12개 칸짜리 머핀 틀 — 칸마다 다른 반죽(cell), 오븐(GPU pod)에 한 번에 굽기
- vs 실험실 wet-lab: 시약·세포 없이 in-silico로 회당 제거율 x 의 물리 근거를 먼저 확보 (wet-lab 은 downstream 확인)

## 2. 12-cell 매트릭스 → `cells.tsv`

`cells.tsv` (machine-readable). 요약:

| 단계 | cell | 호스트 | 도구 |
|---|---|---|---|
| docking (정적) | c05·c06·c07 의 dock 단계 | **pool ubu-1 CPU · 무료** | AutoDock Vina + GNINA |
| MD 효소 (CHARMM36m) | c05·c06·c07·c08 | rtx4090 24GB | GROMACS |
| MD NP (ReaxFF) | c01·c02·c03 | rtx4090 24GB | LAMMPS |
| DFT/TD-DFT | c01·c02·c04·c09·c10·c11·c12 | **A100 80GB** (CeO₂ 122원자 hybrid) | NWChem ωB97X-D/def2-TZVP |

GPU-hr ≈ rtx4090 230h + A100-80 84h (docking 은 pool 무료).

## 3. 소프트웨어 스택 → `environment.yml`

단일 conda env (`ttr-m5`, 전부 FOSS): GROMACS · LAMMPS(ReaxFF) · NWChem · Vina · ASE · pymatgen · RDKit. 자세히는 `environment.yml`.

## 4. 입력 구조 source (전부 공개 · 무료 fetch)

| 종류 | source | ID |
|---|---|---|
| 효소 (PDB) | RCSB | 1V4B(AzoR) · 4G2C/2D3Q(DyP) · 1KYA(laccase) · 1ATJ(HRP) |
| 리간드/안료 | PubChem 3D SDF | CID 2169(azo) · 14570(Cu-Pc) · 54670067(ascorbate) · 2973(DFO) · 643975(FMN) |
| 산화물 | Materials Project (ICSD 라이선스 → MP 오픈 대체) | CeO₂ mp-20194 · Fe₂O₃ mp-19770 · Cr₂O₃ mp-19399 · TiO₂ mp-390 |

```bash
# 무료 fetch (pool ubu-1 또는 로컬). PDB/PubChem 은 키 불필요.
for id in 1V4B 4G2C 2D3Q 1KYA 1ATJ; do curl -fsSL https://files.rcsb.org/download/$id.pdb -o inputs/pdb/$id.pdb; done
for cid in 2169 14570 54670067 2973 643975; do curl -fsSL "https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/cid/$cid/SDF?record_type=3d" -o inputs/ligand/cid_$cid.sdf; done
# 산화물 CIF: MP_API_KEY 필요 → pymatgen MPRester.get_structure_by_material_id (mp-20194 등)
```

## 5. 🔧 수동 큐레이션 TODO (스크립트로 안 되는 부분 · 정직)

렌트 전 반드시 사람/전문 판단이 필요한 입력:
- [ ] CeO₂ `Ce₄₂O₈₀` NP 클러스터 carve (ASE, bulk CIF → ~122원자 NP)
- [ ] DyP **Compound-I** 상태 (heme 에 oxo-ferryl Fe(IV)=O 수동 추가)
- [ ] FMN → **FMNH⁻** (isoalloxazine 환원/양성자화)
- [ ] azo 염료 **CHARMM36m 파라미터** (CGenFF/paramchem 로그인 또는 GAFF antechamber)
- [ ] 각 cell pH 별 protonation state (PROPKA)
> ⚠ 이 큐레이션 + 수렴 실패 재실행이 **숨은 진짜 비용** (렌트비 $237 외 시간·반복).

## 6. 🚀 발사 절차 (준비 완료 후 · @D g8 — `hexa cloud`)

```
0. (선결) 최신 hexa-cloud 빌드 — rent verb(#798) 는 정식 루트에서:
     cd ~/core/hexa-lang && bash tool/build_hexa_cloud.sh   # 현재 bin/hexa-cloud 는 구버전(rent 없음)
   vastai CLI: 설치됨(~/Library/Python/3.12/bin/vastai) · 키 = secret get vast.api_key (설정완료)

1. docking (무료, pool):
     pool on ubu-1 'cd ~/ttr-m5 && conda run -n ttr-m5 vina --config c05.conf ...'

2. rent (실비 — 아래 §7 라이브 offer · 최종확인 후):
     vastai create instance <OFFER_ID> --image <cuda-base> --disk 60 --label ttr-m5::owner=demiurge

3. 스택 + 입력 업로드 → hexa cloud copy-to:
     hexa cloud copy-to <pod> environment.yml /root/ ; hexa cloud copy-to <pod> inputs/ /root/ttr-m5/inputs

4. pod 셋업 (micromamba + env):
     hexa cloud run <pod> --port <p> --insecure -- bash -lc 'micromamba create -y -f /root/environment.yml'

5. cell 실행 (cells.tsv 순회 · nohup + poll):
     hexa cloud nohup <pod> /root/c01.log -- conda run -n ttr-m5 <method-cmd>   # method dispatch = cells.tsv col5

6. 결과 회수 + teardown (과금 정지):
     hexa cloud copy-from <pod> /root/ttr-m5/out ./out ; vastai destroy instance <id>
```

method → 명령 매핑:
- `dft_opt`/`qm_cluster`/`dft*`/`tddft*` → `nwchem <cell>.nw`
- `reaxff*` → `lmp -in <cell>.in` (ReaxFF pair_style)
- `md*`/`md_charmm36m*` → `gmx mdrun -deffnm <cell>` (CHARMM36m topol)
- `vina` → `vina --config <cell>.conf` (pool CPU)

## 7. 💸 라이브 vast offer (2026-05-25 조회 · on-demand)

| GPU | offer 후보 | $/hr | est | 비용 |
|---|---|---|---|---|
| rtx4090 24GB | ES `id=30740609` (reliab 0.987) | $0.60 | 230 GPU-hr | ~$138 |
| A100 80GB SXM | TW `id=36994174` (reliab 0.999) | $0.775 | 84 GPU-hr | ~$65 |
| **합계** | — | — | — | **~$203** (+ 큐레이션/재실행 α) |

> offer ID 는 시간이 지나면 만료 — 발사 직전 `vastai search offers ... -o dph` 재조회 필수.

## 8. fire-checklist (전부 ✅ 면 렌트 go)

- [ ] §5 수동 큐레이션 입력 완료
- [ ] §4 공개 구조 fetch 완료 (`inputs/`)
- [ ] docking(c05-07) pool 무료 선행 완료 → MD 입력 pose 확보
- [ ] 최신 hexa-cloud(rent) 빌드 완료
- [ ] §7 offer 재조회 → 실가 확정
- [ ] **사용자 최종 rent 승인** (실비 ~$203, irreversible)
