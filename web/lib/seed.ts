// QUBIT demo seed — Q14 + Q14′ 의 sign-up 직후 자동 적재.
// Writes one project + 7 minimal verb records under `users/{uid}/projects/qubit-demo/`.
// Idempotent — overwrites if already present (cheap; lets us evolve the seed).

import { setDoc } from "./firestore";

type SeedRecord = {
  verb: string;
  status: "complete" | "in_progress" | "todo";
  summary: string;
  payload: Record<string, unknown>;
};

const NOW_ISO = () => new Date().toISOString();

const QUBIT_SEED: SeedRecord[] = [
  {
    verb: "spec",
    status: "complete",
    summary: "transmon target — f01 4-6 GHz · T1≥80μs · single-q F≥0.999",
    payload: { f01_GHz: 5.0, T1_us: 80, T2_us: 100, gate_fidelity: 0.999 },
  },
  {
    verb: "structure",
    status: "complete",
    summary: "Al/AlOx/Al Dolan-bridge + λ/4 readout coupler",
    payload: { junction: "Al/AlOx/Al", coupler: "λ/4 resonator" },
  },
  {
    verb: "design",
    status: "complete",
    summary: "EJ/EC=50 transmon · g/2π=80 MHz · χ/2π=2 MHz",
    payload: { EJ_EC: 50, g_MHz: 80, chi_MHz: 2 },
  },
  {
    verb: "analyze",
    status: "complete",
    summary: "Koch2007 asymptotic — f01=4.69898 GHz (hexa libm sqrt)",
    payload: { f01_GHz: 4.69898, EJ_GHz: 15, EC_GHz: 0.2, anh_GHz: -0.2 },
  },
  {
    verb: "synth",
    status: "in_progress",
    summary: "Dolan-bridge e-beam · oxidation 1 mTorr · 10 min",
    payload: { oxidation_torr: 0.001, dose_uC_cm2: 600 },
  },
  {
    verb: "verify",
    status: "complete",
    summary: "QuTiP-eq T1/T2 closed-form — gate F=0.9991 (idealized)",
    payload: { gate_F: 0.9991, T1_us: 82, T2_us: 95 },
  },
  {
    verb: "handoff",
    status: "todo",
    summary: "cryostat wiring + RB calibration sequence dossier (PR#5+)",
    payload: {},
  },
];

export async function seedQubitDemo(uid: string): Promise<void> {
  const base = `users/${uid}/projects/qubit-demo`;
  await setDoc(base, {
    name: "QUBIT demo",
    domain: "qubit",
    demo: true,
    createdAt: NOW_ISO(),
    description: "Google Willow-aligned transmon demo (auto-seeded on sign-up).",
  });
  for (const r of QUBIT_SEED) {
    await setDoc(`${base}/records/${r.verb}`, {
      ...r,
      ts: NOW_ISO(),
    });
  }
}
