"use client";

// Motion policy — SINGLE SOURCE OF TRUTH.
//
// Flip the ONE constant below to change motion behavior app-wide. The decision
// may change (a11y-strict vs demo-flashy), so it lives in exactly one place:
//
//   RESPECT_REDUCED_MOTION = true   → honor the OS "Reduce Motion" setting
//                                     (accessibility default; motion off for
//                                      users who asked for it)
//   RESPECT_REDUCED_MOTION = false  → ignore it, always animate
//                                     (demo / marketing — current choice)
//
// Every animated component consumes useEffectiveReducedMotion() instead of
// motion's useReducedMotion() directly, so toggling is a one-line edit here.

import { useReducedMotion } from "motion/react";

export const RESPECT_REDUCED_MOTION = false;

/** Effective reduced-motion flag = OS preference gated by app policy. */
export function useEffectiveReducedMotion(): boolean {
  const system = useReducedMotion();
  return RESPECT_REDUCED_MOTION ? !!system : false;
}
