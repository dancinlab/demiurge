# RTSC re-fire runbook — mini-host execution

> Execute every command below ON `mini` (`/Users/mini/dancinlab/demiurge`) — the SOLE
> management host. `hexa cloud` (run·nohup·dft-run·copy) + the `id_vast_anima` identity
> live here; ghost is RETIRED and MUST NOT be used. Generated 2026-05-30 from RTSC_LEDGER.jsonl (SSOT).
>
> identity = `/Users/mini/.ssh/id_vast_anima` · default path = new `dft-run --detach` phase-1
> (PR#2210/#2211), which AUTO-PROVISIONS pw.x + PSL pseudos on the pod. `pseudo/` absent
> from decks on disk is NORMAL — it is provisioned pod-side, not shipped in the deck.

---

## §0 — refresh stale pods.json FIRST (gate for §3)

`pods.json` is stale (predates the entire wave3b per-candidate re-fire). Refresh from the
provider before trusting any pod liveness:

```sh
cd /Users/mini/dancinlab/demiurge
hexa cloud list          # repopulates pods.json from vast.ai/runpod live state
```

Dead pod IDs DISAPPEAR from the live list → those candidates need re-fire (see §3).

---

## §1 — Branch 1: novel-batch re-fire (crashed pod 38444699 — provision-fail)

Root cause was POD provisioning (no pw.x / empty pseudo) on the OLD fire path, NOT the decks.
All three decks carry a passing `.validated` stamp. Re-fire each on its own pod via the
auto-provisioning `--detach` path (d_parallel_fire: 1 pod = 1 candidate). Pace 1–2 at a time.

```sh
hexa cloud dft-run exports/rtsc/decks/H3S_anchor       --detach --identity /Users/mini/.ssh/id_vast_anima
hexa cloud dft-run exports/rtsc/decks/ThH10_clathrate  --detach --identity /Users/mini/.ssh/id_vast_anima
hexa cloud dft-run exports/rtsc/decks/LuH10_falsifier  --detach --identity /Users/mini/.ssh/id_vast_anima
```

Roles: H3S_anchor = pipeline anchor (known +) · ThH10_clathrate = novel candidate (250 GPa
LaH10-isostructural) · LuH10_falsifier = pre-registered falsifier. After each returns clean,
update the ledger line (status running, fresh pod id) — see §4. Advance later with
`hexa cloud dft-run <deck> --resume`.

---

## §2 — Branch 3: CaAuH3_SOC re-fire (crashed pod 38367660 — mac-freeze 19h, output 0)

DISCRETIONARY — base CaAuH3 @23 GPa is already terminal 🔴 CLOSED-negative (#532). This SOC
(spin-orbit-coupling) rerun only adds whether SOC shifts that verdict. Fire only if the SOC
check is still wanted:

```sh
hexa cloud dft-run exports/rtsc/decks/CaAuH3_SOC --detach --identity /Users/mini/.ssh/id_vast_anima
```

If NOT wanted → mark the ledger line terminal (defer to base verdict) instead of re-firing.

---

## §3 — Branch 2: liveness health-check of the 21 "running" candidates

After §0 refresh, the ledger marks these 21 as running. Verify each pod still exists in the
live list; any whose pod vanished → re-fire (same `--detach` form as §1). `--resume` is
idempotent — it advances a live candidate or reports it still-running, and is safe to poll.

| # | candidate | pod | stage (ledger) | note |
|---|-----------|-----|----------------|------|
| 1 | H3S        | 38495596 | ph 3/36 | validation run |
| 2 | Li2MgH16   | 38382692 | ph 1/8  | top clathrate Tc |
| 3 | LaBeH8     | 38384813 | vc-relax | ⚠ SUSPECT — 38384813 was the bin-pack pod; ledger line 26 says its dup was downed. Verify hard. |
| 4 | YSbH6      | 37868501 | ph 1/11 | oldest pod — verify alive |
| 5 | LaBH8      | 38546678 | vc-relax | |
| 6 | Y2InH18    | 38570772 | vc-relax | |
| 7 | Y2CdH18    | 38571294 | vc-relax | |
| 8 | Ca2SnH18   | 38571466 | vc-relax | |
| 9 | ScBeH8     | 38566207 | vc-relax | detach ref (.dft_detach.state) |
| 10| YBeH8      | 38566661 | vc-relax | |
| 11| LaH10      | 38566907 | vc-relax | |
| 12| YH6        | 38567061 | vc-relax | |
| 13| YH9        | 38567300 | vc-relax | |
| 14| BaAuH3     | 38569202 | vc-relax | |
| 15| SrPtH3     | 38569347 | vc-relax | |
| 16| YAuH3      | 38569481 | vc-relax | |
| 17| KBeH8      | 38569710 | vc-relax | |
| 18| MgBeH8     | 38569852 | vc-relax | |
| 19| ScH9       | 38570075 | vc-relax | |
| 20| CeH9       | 38570194 | vc-relax | |
| 21| LaY_H10    | 38570469 | vc-relax | |

Poll loop (advance + liveness in one pass):

```sh
for d in H3S Li2MgH16 LaBeH8 YSbH6 LaBH8 Y2InH18 Y2CdH18 Ca2SnH18 ScBeH8 \
         YBeH8 LaH10 YH6 YH9 BaAuH3 SrPtH3 YAuH3 KBeH8 MgBeH8 ScH9 CeH9 LaY_H10; do
  echo "=== $d ==="
  hexa cloud dft-run "exports/rtsc/decks/$d" --resume --identity /Users/mini/.ssh/id_vast_anima
done
```

Any candidate that errors "pod not found" / instance gone → re-fire with `--detach` (§1 form),
then update its ledger line with the fresh pod id.

---

## §4 — ledger reconcile (after §1–§3)

Per d_campaign_ledger, mirror EVERY state change into `RTSC_LEDGER.jsonl`:

- novel-batch (line 8): on re-fire, split into per-candidate lines OR update note with the 3
  fresh pod ids + `status: running`.
- CaAuH3_SOC (line 7): re-fired → `status: running` + fresh pod; deferred → `status: terminal`,
  note "defer to base CaAuH3 #532 🔴".
- any §3 candidate whose pod was dead → `status: crashed` then re-fired → `running` + new pod.
- regenerate pods.json is automatic via §0 `hexa cloud list`.

Commit on `mini`, sequential / one candidate at a time (d9 — `git add <explicit-file>` only).
