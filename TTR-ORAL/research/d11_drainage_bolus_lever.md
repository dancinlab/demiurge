# TTR-ORAL — d11 적용: 새 dominant lever + NOVEL (함께)

> 🦠 **TTR-ORAL** — "면역세포 택배"
> **@D d11 적용** (벽에서 새 dominant lever + NOVEL 함께 제시). 벽 = BP1 의 "高-β 경구 phagocytosis 차단제 부재". sim = `sim/bp2_drainage_bolus.hexa`.

---

## 벽 (BP1 결론)
재포획 r↓ 의 dominant lever 는 맞으나 — 무른 잉크 재포획은 scavenger-receptor 매개라 **경구 high-β 차단제가 없다**. phagocytosis 를 *막는* 쪽은 경구 손잡이가 없음.

---

## 🆕 NEW dominant lever — 배출 가속 (drainage↑), phagocytosis 안 건드림

핵심 재구성: `r = k_phago / (k_phago + k_drain)`. 지금까지는 분자(k_phago)를 줄이려 했음(β). **분모의 k_drain 을 키우면** phagocytosis 를 *전혀 막지 않고도* r 이 떨어진다.
→ **경구 lymphagogue / 림프 펌프 augmentation** (device-free 호환 · scavenger-receptor 차단제 불요).

```
배출부스트 D    r=19/(19+D)   timeline(T=28d)
D=1  (자연)     0.95          188 mo
D=5             0.79           68 mo
D=19            0.50           31 mo   ← phago 차단 0, 배출만 19×
D=40            0.32           24 mo
```

## 🧬 NOVEL mechanism — 동기화 release bolus 로 재포획 *포화*

CSF1R 펄스로 잉크-적재 macrophage 를 **동시에** 죽이면 → 한 번에 큰 색소 bolus 방출 → 국소 재탐식 용량(유한)을 **초과(zero-order 포화)** → β 와 무관하게 일정 분율이 탈출·배출. `r_eff = r·(1−s_sat)`.

```
D=19 (r=0.50) + bolus 포화 s_sat:
  s_sat=0.0  r_eff 0.50  31 mo
  s_sat=0.4  r_eff 0.30  23 mo
  s_sat=0.7  r_eff 0.15  19 mo
```

## hexa-native recompute (verbatim · 🟢)

```
[1] drainage boost D -> r -> timeline:
  1     0.95      0.045    phi 0.011187   n90 204.674  188.516 mo
  5     0.791667  0.124167 phi 0.0305648  n90 74.1772   68.3211 mo
  19    0.5       0.27     phi 0.0652723  n90 34.1124   31.4193 mo
  40    0.322034  0.358983 phi 0.0858364  n90 25.6568   23.6312 mo
[2] D=19 + bolus saturation:
  s_sat=0.0: r_eff=0.5  31.4193 mo
  s_sat=0.4: r_eff=0.3  22.9276 mo
  s_sat=0.7: r_eff=0.15 19.0634 mo
```

## 함께 (d11) — 둘을 합치면

**배출 가속(D) + 동기화 bolus 포화(s_sat)** = phagocytosis 차단제 없이 r 을 양쪽(분모↑ + 포화)에서 공격 → **~19개월** (D=19·s_sat=0.7). 둘 다 **device-free 경구 호환** (lymphagogue + CSF1R 펄스).

```
   기존 막힘:  β(phago 차단) ──✗ 경구 agent 없음
   d11 우회:   k_drain↑ (배출) ─┐
                                ├─ 함께 → r_eff↓ → ~19mo (경구-OK)
               bolus 포화 ──────┘
```

- vs BP1(β): BP1 은 "먹기를 막자"(경구 agent 없음), d11 은 **"빨리 빼내자 + 한꺼번에 쏟자"**(경구 가능) — 같은 r 을 정반대 방향에서 공격.

## 정직한 tier + 한계
| claim | tier |
|---|---|
| r=k_phago/(k_phago+k_drain) · r(D) · r_eff recompute | 🟢 verbatim |
| 배출 19× 로 r 0.95→0.50 | 🔵/🟢 (모델) |
| 경구 lymphagogue 가 D~19 달성 | 🟠 (실측 필요 · 림프 19× 부스트는 공격적) |
| bolus 포화 s_sat 절대값 | 🟠 (재탐식 용량 실측 · M8 ex-vivo) |

> ~19개월은 여전히 >1yr 이나, **BP1 의 경구-agent 벽을 우회한 비-incremental 경로**(d11 준수). 진정 device-free 의 핵심 미실측 = D(림프 배출 부스트 달성도) + s_sat(포화 escape). near-term 은 여전히 레이저-병용이 가장 빠름. absorbed=false.

## next
- 경구 lymphagogue 후보 + D 달성도 grounding (BP1a 형식).
- s_sat (재탐식 포화) ex-vivo 측정 설계 (M8 통합).
