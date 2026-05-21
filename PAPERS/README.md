# PAPERS — demiurge / hexa-lang research paper repository

> arxiv-quality LaTeX papers, one per directory under this root. Compiled
> PDFs sit alongside their source for review. Sample target quality:
> arxiv:2409.00101 (NeuroLM, ICLR 2025) — single-column ~14-18 pages, with
> figures + tables + bibliography.
>
> opened: 2026-05-21 KST · status: drafting first sample

---

## Directory layout

```
PAPERS/
├── README.md                          ← this file (rules)
├── sample-nb-bcs-absorbed/            ← first sample (Nb BCS absorbed=true)
│   ├── main.tex
│   ├── references.bib
│   ├── Makefile
│   ├── figures/
│   │   ├── *.tikz / *.pdf / *.png
│   └── README.md                      ← paper-specific notes
└── <slug>-<topic>/                    ← future papers, same layout
```

`<slug>` 규칙: lowercase-kebab-case · short · 본문 영역 식별 가능
(예: `mp-cache-roadmap`, `tier4-falsifier-dispatch`, `cube-fullcycle-617s`).

---

## LaTeX rules

- **Class**: `\documentclass[11pt]{article}` + arxiv-style preamble
  (single-column, A4 or letter, 11pt). Larger conference templates (NeurIPS,
  ICLR, IEEE) 는 별 PR 에서 결정.
- **Bibliography**: BibTeX (`references.bib`) + `\bibliographystyle{plain}`
  또는 `unsrt`. 모든 인용은 source URL 또는 DOI 또는 arxiv ID 필수.
- **Figures**: vector (`.pdf` · `.eps`) 권장. 비트맵 (`.png`) 은 OpenAI-생성
  cover / 사진성 자료만. 모든 figure 는 `figures/<slug>.{pdf,png,tikz}`.
- **Compile**: `make` 또는 `pdflatex main.tex` × 3 (cross-ref + bibtex pass).

---

## g3 honest stance (RTSC.md / MP.md 와 정합)

- **measurement-oracle parity** 가 absorbed=true 의 유일 경로. paper 가
  주장하는 결과는 모두 동반 record JSON (exports/) 으로 검증 가능해야 함.
- **scope_caveats** 를 paper 본문 마지막에 별 §로 표기 — record 의
  caveat 와 word-for-word 일치 권장.
- **provenance**: 모든 측정값 / 식 / 인용 출처는 `\cite{}` + bibtex entry +
  URL/DOI 까지 추적 가능. 추적 불가능한 claim 은 paper 에 안 들어감.
- **absorbed=true 주장 paper** 는 동반 record 의 `measurement_gate =
  GATE_CLOSED_MEASURED` 필수.
- **claim-only 영역** (LK-99 / hexa-rtsc n=6 등 미재현 RTSC) 의 paper 는
  `absorbed=false · gate_type=empirically-unproven` 명시 + 'claim 자체'
  논의로 명확히 제한.

---

## Image generation (fal.ai · OpenAI gpt-image-1 wrap)

본 repo 의 paper 는 *arxiv:2409.00101 수준* (full-conference 14-18 pages, 9+
figures) 을 목표. 그 정도 figure 수에 도달하려면 TikZ + matplotlib + **fal.ai
hosted OpenAI gpt-image-1** 셋을 같이 써야 함.

OpenAI 직접 API 가 아니라 **fal.ai proxy 를 사용** — 더 빠른 latency, 더 나은
text-rendering, 같은 OpenAI 모델 액세스.

### Figure 분류 기준

| 종류 | 도구 | 예 |
|---|---|---|
| 정량 데이터 plot | matplotlib | 측정 점 + error bar + threshold band |
| 기술 block diagram (정합성 필수) | TikZ | 4-tier 파이프라인 · gate 흐름 · timing |
| 개념 / cover / teaser / schematic | **fal.ai (gpt-image-1)** | 추상 물리 · cross-domain 비유 · 표지 |
| 결정 격자 · 원자 모형 | fal.ai + 캡션에 비-quantitative 명시 | crystal · phonon |

→ AI 이미지 생성은 정량성 보장 안 함 — 데이터 plot 용도 금지. 개념 schematic 한정.

### Tool: `PAPERS/_tools/fal_gen.sh`

Queue-pattern (submit → poll status → fetch result) 을 캡슐화한 헬퍼 스크립트:

```bash
PAPERS/_tools/fal_gen.sh <image_size> <prompt_file> <out_png>
# 예:
PAPERS/_tools/fal_gen.sh square_hd      _prompts/01_cover.txt    01_cover.png
PAPERS/_tools/fal_gen.sh landscape_16_9 _prompts/02_framework.txt 02_framework.png
```

내부 동작:
- `secret get fal.api_key` 로 키 인-flight (env 노출 X, argv 노출 X)
- 모델: `openai/gpt-image-2` (= 사용자가 "openai images2" 라고 부르는 그 모델)
- `IN_QUEUE` → 3s 간격 80회 polling (~4분 한도) → `COMPLETED` 시 result fetch
- 페이로드 JSON 은 mktemp 파일 경유 (argv 인용 안전)
- Submit 응답의 `response_url` / `status_url` 을 verbatim 사용 (모델별 path 변형 대응)

병렬 호출 패턴 (5 figure 동시):
```bash
cd PAPERS/<slug>/figures/
( ../../_tools/fal_gen.sh square_hd _prompts/01_*.txt 01_cover.png ) &
( ../../_tools/fal_gen.sh landscape_16_9 _prompts/02_*.txt 02_framework.png ) &
...
wait
```

### fal.ai API 사용 (`secret get fal.api_key`)

```bash
FAL_KEY=$(secret get fal.api_key) curl -sS \
  https://queue.fal.run/fal-ai/gpt-image-1 \
  -H "Content-Type: application/json" \
  -H "Authorization: Key $FAL_KEY" \
  -d '{
    "prompt": "...",
    "image_size": "square_hd",
    "num_images": 1,
    "output_format": "png"
  }' | tee /tmp/fal_response.json | python3 -c "
import sys, json, urllib.request
r = json.load(sys.stdin)
# fal queue endpoint returns request_id; need to poll status_url for completion
if 'request_id' in r:
    print('[fal] queued request_id=' + r['request_id'], file=sys.stderr)
    print('[fal] poll: GET ' + r['status_url'], file=sys.stderr)
"
# 또는 direct sync endpoint (모델이 지원 시):
# https://fal.run/fal-ai/gpt-image-1
```

**Queue 패턴** (recommended — 더 robust):
```bash
RESP=$(curl -sS -X POST https://queue.fal.run/fal-ai/gpt-image-1 \
  -H "Authorization: Key $(secret get fal.api_key)" \
  -H "Content-Type: application/json" \
  -d "{\"prompt\": \"$(cat _prompts/cover.txt)\", \"image_size\": \"square_hd\"}")
RID=$(echo "$RESP" | jq -r .request_id)
# Poll until status=COMPLETED:
while true; do
  STATUS=$(curl -sS https://queue.fal.run/fal-ai/gpt-image-1/requests/$RID/status \
    -H "Authorization: Key $(secret get fal.api_key)")
  echo "$STATUS" | jq -r .status
  [ "$(echo "$STATUS" | jq -r .status)" = "COMPLETED" ] && break
  sleep 3
done
RESULT=$(curl -sS https://queue.fal.run/fal-ai/gpt-image-1/requests/$RID \
  -H "Authorization: Key $(secret get fal.api_key)")
URL=$(echo "$RESULT" | jq -r '.images[0].url')
curl -sS "$URL" -o figures/cover.png
```

사이즈 옵션 (fal.ai 표준): `square_hd` (1024×1024) · `landscape_16_9` (1792×1024) ·
`portrait_16_9` (1024×1792) · `square` (512×512).

가격 (fal.ai gpt-image-1, 2026-05 기준): ~\$0.07-0.12 per image (HD), low-res
~\$0.02. fal.ai 대시보드에서 실시간 quota 확인.

### 라이선스 / attribution

- fal.ai → OpenAI gpt-image-1 → 생성 이미지는 사용자 소유 (OpenAI Terms
  2024+, fal.ai usage terms 동의). attribution 의무 X.
- 그러나 본 repo g3 stance: **caption 에 `Generated with gpt-image-1 via
  fal.ai (prompt: "...")` 명시** 또는 `% generated via fal.ai gpt-image-1`
  주석. provenance 추적 가능해야 함.
- `figures/_prompts/<name>.txt` 에 prompt 원문 verbatim 보존 — provenance
  audit 시 입력 재현 가능.
- arxiv 제출 시 `figures/*.png` 는 tarball 에 포함; LaTeX 가
  `\includegraphics{figures/cover.png}` 로 끌어옴.

### 비교: fal.ai vs OpenAI 직접

| | fal.ai | OpenAI 직접 |
|---|---|---|
| Endpoint | `queue.fal.run/fal-ai/gpt-image-1` | `api.openai.com/v1/images/generations` |
| Auth | `Authorization: Key <FAL_KEY>` | `Authorization: Bearer <OPENAI_API_KEY>` |
| Pattern | Queue + poll (robust) | Sync (timeout 위험) |
| Latency | ~3-15s (queue) | ~5-30s (sync) |
| Text rendering | 더 안정적 | 변동 |
| Models available | gpt-image-1, flux/dev, imagen3, ideogram, recraft, … | DALL-E 3 한정 |
| 키 위치 | `secret get fal.api_key` | `secret get openai.api_key` |

→ 본 repo default = fal.ai (더 다양한 모델 + queue robustness).

### Figure 디렉토리 layout

```
<paper-slug>/
├── figures/
│   ├── cover.png             ← DALL-E (teaser, 1024x1024)
│   ├── framework.png         ← DALL-E (landscape, 1792x1024)
│   ├── consensus.tikz        ← TikZ (inline in main.tex)
│   ├── data_plot.pdf         ← matplotlib export
│   └── _prompts/
│       └── cover.txt         ← DALL-E prompt 원문 (provenance)
```

`_prompts/` 디렉토리 모든 DALL-E prompt 를 verbatim 보존 — provenance.

## Compile pipeline

```bash
cd PAPERS/<slug>/
make            # pdflatex + bibtex + pdflatex × 2
# 또는 수동:
pdflatex main.tex && bibtex main && pdflatex main.tex && pdflatex main.tex
```

결과: `main.pdf` 같은 디렉터리 안. arxiv 제출 시 `main.tex` + `references.bib`
+ `figures/*` tarball 로 묶음.

---

## Submission categories (arxiv 기준)

본 repo 의 paper 가 arxiv 갈 때 주로 cross-list 후보:

| category | 범위 |
|---|---|
| `cond-mat.supr-con` | 초전도 (RTSC.md 작업 1순위) |
| `cond-mat.str-el` | 강상관 전자계 (cuprate · iron-based) |
| `physics.comp-ph` | 계산 물리 (FEM · DFT pipeline) |
| `physics.ins-det` | 측정 instrument (Tier 3 ingest) |
| `cs.SE` | software engineering · framework paper |

---

## Cross-reference

- `~/core/demiurge/RTSC.md` — RTSC 도메인 5축 + §8 4-tier
- `~/core/demiurge/MP.md` — Materials Project key-free 로드맵
- `~/core/demiurge/exports/material_attestation/` — absorbed=true 검증 record (paper 동반)
- `~/core/hexa-lang/stdlib/material/` — Tier 1-4 producer SSOT
- `~/core/hexa-lang/stdlib/rtsc/` — device-side FEM (Tier 0)

## Log

- **2026-05-21 KST** — opened. PAPERS/ 루트 + 첫 샘플 (Nb BCS absorbed=true attestation).
