# phanes — 콘셉트 보관소

> 🥚 **phanes** (Φάνης · "빛으로 끌어내는 첫 신") — 자율 사이클 발견 엔진의 콘셉트 SSOT.
> 작동 코드는 더 이상 sibling `~/core/phanes` 가 아니라 **demiurge 안의 `stdlib/discover/`** 가 canonical home (d3).

## 위치 매핑

| 레이어 | 위치 | 역할 |
|---|---|---|
| 콘셉트 / 계약 | `phanes/README.md` · `phanes/INBOX.md` (여기) | OUROBOROS 루프 정의 · 브릿지 계약 · 어휘 보관 |
| 작동 코드 | `stdlib/discover/discover.hexa` | 8번째 verb `discover` 의 실제 구현 |
| 사용자 진입점 | `demiurge cli discover <objective>` | CLI 표면 (Web `/account?tab=cli` 가이드 4-step) |
| 도메인 매니페스토 | `domains/DOMAINS.tape` + 각 `<DOMAIN>.md` | `discover` row · 도메인별 verifier 경로 |

## 왜 demiurge 안으로 합쳤나

- **단일 CLI 흐름** — 사용자는 `hx install demiurge` 하나만으로 8-verb 전부 사용 가능
- **install 단계 0 추가** — 별도 `hx install phanes` 안 함 (g0 Occam)
- **단일 dispatch** — `domains/DOMAINS.tape` 한 곳에서 `discover` row 추가 (d4 generic dispatch)
- **XPRIZE 2026-08-17 데드라인** — 부가 install/repo 의존성 컷

## OUROBOROS 개념 (요약)

```
seed 한 줄 (objective)
   ↓
phanes 콘셉트 = ⟪ goal → falsifier → saturation ⟫
   ↓
  per-round honesty/falsification gate
   ↓
verified, provenance-tracked catalog (echoes-style)
```

- **goal**: measurable objective (사용자 입력)
- **falsifier**: verifier 모듈 경로 (hexa/py)
- **saturation**: 라운드별 새 발견 없음 → 루프 종료
- **rounds_cap**: 안전 cap (예: 8)

자세한 어휘 + 흡수 논문 10편 (AI-Scientist / RLVR / open-endedness / QD-novelty / AutoML-Zero) 은 sibling
`~/core/phanes/` 에 archive 로 남아 있음 (참고용, 작동에는 미관여).

## 다음 슬라이스

- [ ] `stdlib/discover/discover.hexa` 의 OUROBOROS 라운드 루프 .hexa 구현
- [ ] `domains/DOMAINS.tape` 에 `discover` row 추가 (verifier 경로 규약)
- [ ] `web/app/discover/DiscoverForm.tsx` → `stdlib/discover` 호출 (현재는 외부 phanes 바이너리 호출)
