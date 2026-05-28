"use client";

// DemiIcon — 데미 시그니처 아이콘 = 모핑 닷(Morph 컨셉 채택, 2026-05-28).
// 노란 브랜드 닷 하나가 원 ↔ 육각(⬡) ↔ 다이아(◆) 로 숨쉬듯 변형 — demiurge =
// δημιουργός(조물주·장인)가 형태를 빚는 은유. ElevenLabs 절제 톤(느린 5.5s idle).
//
// 세 형태 모두 6-앵커 path 로 통일 → motion.path d 보간이 깔끔.
// Hydration-safe: 서버 + 첫 클라 렌더 = 동일한 정적 path(원). 모션은 mount 이후만.
// 모션 on/off = lib/motion 의 RESPECT_REDUCED_MOTION 단일 토글(useEffectiveReducedMotion).

import { useEffect, useState } from "react";
import { motion } from "motion/react";
import { useEffectiveReducedMotion } from "@/lib/motion";

// 6 anchors shared across shapes so the path morph interpolates cleanly. cx,cy=12.
function hexPath(r: number, rot = 0): string {
  const pts = Array.from({ length: 6 }, (_, i) => {
    const a = rot + (i / 6) * Math.PI * 2;
    return [12 + r * Math.cos(a), 12 + r * Math.sin(a)] as const;
  });
  return (
    `M ${pts[0][0].toFixed(2)} ${pts[0][1].toFixed(2)} ` +
    pts
      .slice(1)
      .map((p) => `L ${p[0].toFixed(2)} ${p[1].toFixed(2)}`)
      .join(" ") +
    " Z"
  );
}

const CIRCLE = hexPath(6.3, Math.PI / 6); // soft round-ish dot
const HEX = hexPath(6.6, 0); // pointy-side hexagon ⬡
const DIAMOND =
  "M 12.00 5.20 L 16.80 9.40 L 16.80 14.60 L 12.00 18.80 L 7.20 14.60 L 7.20 9.40 Z";

// 데미 시각 아이덴티티 단일 SSOT — size·state·className 만 받으면 어디서든 재사용.
// 레일 헤더(20) · 빈 상태/온보딩(48~64) · 로딩 자리(16) · 작업 중(state="thinking") 등.
export function DemiIcon({
  size = 20,
  state = "idle",
  className,
}: {
  /** px 크기. 레일 20 · 빈 상태/온보딩 48~64 · 인라인 16. */
  size?: number;
  /** idle = 평상(활발한 숨쉬기) · thinking = 더 빠른 맥동(작업 중). */
  state?: "idle" | "thinking";
  className?: string;
}) {
  const reduced = useEffectiveReducedMotion();
  const [mounted, setMounted] = useState(false);
  useEffect(() => setMounted(true), []);

  // 서버 + hydration(첫 클라 렌더)는 정적. mount 이후 + 모션 허용일 때만 변형.
  const animate = mounted && !reduced;
  const thinking = state === "thinking";

  return (
    <svg
      viewBox="0 0 24 24"
      width={size}
      height={size}
      className={className}
      aria-hidden="true"
      style={{ display: "block" }}
    >
      <motion.path
        d={CIRCLE}
        className="fill-yellow-300"
        style={{ transformOrigin: "12px 12px" }}
        animate={
          animate
            ? {
                d: [CIRCLE, HEX, DIAMOND, CIRCLE],
                scale: thinking ? [1, 1.22, 0.84, 1.22, 1] : [1, 1.16, 0.9, 1.16, 1],
                rotate: thinking ? [0, 20, -20, 10, 0] : [0, 14, -14, 6, 0],
              }
            : undefined
        }
        transition={
          animate
            ? { duration: thinking ? 1.8 : 3.0, ease: "easeInOut", repeat: Infinity }
            : undefined
        }
      />
    </svg>
  );
}
