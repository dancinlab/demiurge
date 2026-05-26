# demiurge XPRIZE 2026 데모 영상

🎬 3분 미만 (목표 2:30) Remotion + ElevenLabs 생성 영상. Devpost 제출 자료.

## 📁 구조

```
demo-video/
├── src/
│   ├── index.ts              # registerRoot
│   ├── Root.tsx              # Composition 등록 (1920x1080 @ 30fps)
│   ├── XprizeDemo.tsx        # 메인 timeline · 16 shots 시퀀스
│   └── content/
│       └── narration.json    # 15 narration + 1 outro · George 음성 메타
├── scripts/
│   └── generate-voice.ts     # ElevenLabs API → public/voice/*.mp3
├── public/
│   └── voice/                # generated · gitignored
├── assets/
│   ├── voice/                # legacy (Desktop 샘플) — 무시 가능
│   └── screen/               # 화면 녹화 .mp4 (gitignored)
└── remotion.config.ts        # h264 yuv420p crf 18
```

## 🚀 빠른 시작

```bash
cd demo-video

# 1) 의존성 설치 (pool-route hook이 차단하면 sidecar host에서)
npm install

# 2) 음성 생성 (15 mp3 · ~5 sec ElevenLabs API 호출)
ELEVENLABS_API_KEY=$(secret get elevenlabs.api_key) npm run voice

# 3) Remotion Studio 로컬 미리보기 (자동 hot-reload)
npm run studio

# 4) 최종 MP4 렌더 (2:30 영상, ~3분 소요)
npm run render

# 출력: out/demiurge-xprize-demo.mp4
```

## ✏️ narration 수정

`src/content/narration.json` 의 `narration` 필드 수정 → `npm run voice` 재실행 → 자동 hot-reload.

## 📐 timing

- fps: 30 (Remotion default)
- 해상도: 1920×1080
- 총 길이: narration.json `shots[].duration_sec` 합 (현재 ~2:30)
- 각 shot duration은 ElevenLabs 실측 길이로 미리 측정됨 (afinfo)

## 🎙️ 음성

- voice: George (British storyteller · `JBFqnCBsd6RMkjVDRZzb`)
- model: `eleven_multilingual_v2`
- stability 0.55 · similarity 0.75 · style 0.0 · speaker_boost true

수정 시 `_meta` 블록 변경 후 `npm run voice` 재실행.

## 🎥 실제 영상 워크플로

본 스캐폴드는 **timeline 뼈대** — 각 shot의 visual은 현재 placeholder card (id + narration + capture 지시문).

production 영상 만들 때:
1. 각 shot의 `capture` 필드 가이드를 보고 화면 녹화 (`assets/screen/<id>.mp4`)
2. `XprizeDemo.tsx`에서 `<ShotCard>` 자리에 `<Video src={staticFile('screen/<id>.mp4')} />` 합성
3. text overlay 필요 시 Remotion `<spring>` + `<interpolate>` 사용
4. outro montage (shot 16)는 evidence card 컬렉션 (GCP product logos · Devpost 카테고리 · 5-locale)

## 🏆 XPRIZE 출전 데모 원칙

- ② AI-Native Operations ⅓ 축 reinforce — Gemini가 운영, sacred verify enforced
- 8-verb pipeline 보여주기 — 각 shot 1 verb (spec/structure/design/analyze/synth/verify/handoff + discover)
- production live evidence — shot 14 실 curl 응답 JSON
- 5-locale rapid cycle — shot 1, 11에서 글로벌 진입 장벽 0 강조

## 🔗 관련

- production: https://demiurge.dancinlab.org
- Devpost narrative: `../domains/XPRIZE/devpost_submission.md`
- XPRIZE 도메인 SSOT: `../domains/XPRIZE.md`
