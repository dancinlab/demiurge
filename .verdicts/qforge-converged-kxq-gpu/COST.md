# Cost — qforge-converged-kxq-gpu campaign

- Pod: vast.ai instance 40418055, RTX 3090 24GB, $0.2322/hr (dph_total incl. storage).
- Provider: vast.ai (d17 priority). Offer 38954733.
- Rent fired: 2026-06-10 ~23:24 (d17 autonomous, est stated ~$0.5-1).
- Sweep walltime (CPU single-thread, GPU idle — see VERDICT §4):
  NPW64 94s · NPW128 426s · NPW256 1543s · NPW512 (running) · q≠Γ pending.
- Running cost at NPW256-done checkpoint: $0.366 (1.58 hr).
- Budget cap: ≤$10 (target). Final cost recorded at teardown below.
- Teardown: pod destroyed immediately after sweep completes (d17 harvest→down).

## Final
- Total runtime: 2.82 hr @ $0.2322/hr = **$0.654** (well under ≤$10 cap; under the stated ~$0.5-1 est).
- Teardown: `vastai destroy instance 40418055 -y` → "destroying instance 40418055" →
  `vastai show instances` → active instances: NONE. **POD DESTROYED — confirmed gone.**
- GPU was idle the entire run (CPU-only release build, VERDICT §4); the $0.65 bought a
  192-core/220GB host that let NPW256 + 2 q-points land (the 0-pod d11 walltime wall, broken).
