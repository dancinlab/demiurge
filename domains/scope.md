# domain — scope (space telescope, segmented-mirror)

> Status: **shallow public-surface map** (Cohort 2, `design.md` Decision 6).
> Boundary: public-surface clean-room (`design.md` Decision 1). Pipeline =
> 7-verb spine (`HANDOFF.md` §4 · D5). **Note**: shares NASA-open stack
> with Cohort-1 `space.md` (GMAT / OpenMDAO) and inherits its *smallest
> proprietary gap* property at the system-engineering level — but optics
> design itself is dominated by Code V / Zemax.

## 1. "Design blueprint" deliverable

Segmented primary-mirror prescription + active-optics control plan,
end-to-end PSF / wavefront-error budget, instrument throughput +
sensitivity curves, plus orbit / observatory-bus integration. JWST's
18-segment 1.32 m beryllium hexagonal mirror is the n=6 invariant
public reference; LUVOIR / HWO build on the same segmented architecture
(HabEx contrasts as monolithic — ⚠ *do not conflate*).

## 2. Public-surface tool map (7-verb 1:1)

| verb | 오픈소스 | 상용 — 공개문서 한정 |
|---|---|---|
| 명세 SPECIFY | (science case → mission concept; NASA SE Handbook + NPR 7150 / 7123 / 8705) | — |
| 구조 ARCHITECT | (segmented vs monolithic primary; JWST 18-hex reference — NASA Webb mirrors page) | — |
| 설계 DESIGN | **POPPY** (Physical Optics Propagation in Python, BSD; spacetelescope/poppy); **WebbPSF** (JWST + Roman PSF simulator built on POPPY) | **Code V** · **Zemax OpticStudio** (commercial optical design — ray-trace + tolerancing; public marketing docs only) |
| 해석 ANALYZE ⟲ | POPPY diffractive PSF; **synphot** / **stsynphot** (Astropy-affiliated synthetic photometry, throughput tables) | **FEMAP** · **NX Nastran** (structural / opto-mechanical FEA; public datasheets) |
| 합성 SYNTHESIZE | **OpenMDAO** (NASA Glenn; multidisciplinary opt with analytic derivatives — coupled optics + structure + thermal possible via custom components) | — |
| 검증 VERIFY | POPPY + WebbPSF end-to-end PSF validation; Astropy ecosystem for photometric / spectral verification | STK-class mission-analysis (public docs only — see Cohort-1 `space.md` ⚠ flag) |
| 인계 HANDOFF | (Phase D production → launch per NASA SE / ECSS-E-ST-32C; OSS deliverable format 약함) | — |

## 3. Notable proprietary (public docs only)

**Code V** and **Zemax OpticStudio** dominate the *optical-prescription*
design loop (tolerancing, freeform, multi-configuration zoom); POPPY +
WebbPSF cover the *diffractive* simulation that flight-validated JWST,
but they are not a commercial-grade optical-design replacement. **FEMAP**
/ **NX Nastran** dominate opto-mechanical / thermal FEA. Coronagraph /
starshade design uses a mix of NASA-internal codes (some open via
exoplanet-imaging GitHub) and proprietary tools.

## 4. Biggest open-source gap

A fully open, tolerancing-capable optical-design suite at Code V / Zemax
parity. POPPY is excellent for *physical-optics propagation* and PSF
modeling but does not replace ray-trace optical-prescription design with
production-grade tolerancing.

## 5. Cited sources

- POPPY (spacetelescope) — <https://github.com/spacetelescope/poppy>
- WebbPSF — <https://github.com/spacetelescope/webbpsf>
- synphot — <https://synphot.readthedocs.io/>, <https://www.ascl.net/1811.001>
- stsynphot — <https://stsynphot.readthedocs.io/en/stable/>
- OpenMDAO (NASA Glenn) — <https://software.nasa.gov/software/LEW-18550-1>, <https://openmdao.org/>
- JWST 18-segment mirror — <https://www.nasa.gov/image-article/honeycomb-mirrors-make-nasas-webb-most-powerful-space-telescope/>, <https://science.nasa.gov/mission/webb/webbs-mirrors/>
- HWO / LUVOIR / HabEx segmented-vs-monolithic — <https://ntrs.nasa.gov/api/citations/20230014335/downloads/CAA%20Presentation_100923rev2%2010-10.pdf>, <https://www.science.org/content/article/nasa-unveils-initial-plan-multibillion-dollar-telescope-find-life-alien-worlds>

## 6. Design options (workbench shelf)

> rfc_012 §5 ingredient shelf — plain design options per verb.
> Line form `- <verb>: <group> = a / b / c`; ` ; ` separates groups.

- 구조: 거울 = 단일 / 분할
- 설계: 분할 수 = 7 / 18 / 36 ; 소재 = 베릴륨 / 유리세라믹
