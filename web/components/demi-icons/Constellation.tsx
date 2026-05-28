"use client";

// 데미 아이콘 후보 D — 컨스텔레이션 (Constellation)
// 점 5개가 선으로 이어진 별자리. 한 노드는 노란 닷(앵커 = 데미). idle = 잇는 선이
// 은은히 숨쉼(opacity), thinking = 노드가 선을 따라 순차 점등(8-verb 흐름 은유).
//
// Hydration-safe: 서버 + 첫 클라 렌더 = 동일한 정적 별자리(노드 5 + 선 4).
// 모션(선 호흡·노드 순차 점등)은 mount 이후에만. 프리뷰 평가용 → reduce-motion 무시.

import { useEffect, useState } from "react";
import { motion } from "motion/react";

// Fixed star layout in 0..24 space (server == client). Index 0 = brand anchor.
const NODES = [
  { x: 12, y: 12 }, // 0 — center brand dot (yellow)
  { x: 5.5, y: 6.5 }, // 1
  { x: 18, y: 5.5 }, // 2
  { x: 19, y: 17 }, // 3
  { x: 6, y: 18.5 }, // 4
] as const;

// Edges form a path through the constellation (a "tour").
const EDGES: [number, number][] = [
  [1, 0],
  [0, 2],
  [2, 3],
  [3, 0],
  [0, 4],
  [4, 1],
];

export function Constellation({
  state = "idle",
  size = 24,
}: {
  state?: "idle" | "thinking";
  size?: number;
}) {
  const [mounted, setMounted] = useState(false);
  useEffect(() => setMounted(true), []);

  const thinking = state === "thinking";
  const cycle = thinking ? 2.4 : 4.5;

  return (
    <svg
      viewBox="0 0 24 24"
      width={size}
      height={size}
      fill="none"
      aria-hidden="true"
      style={{ display: "block" }}
    >
      {/* connecting lines — breathe in opacity */}
      {EDGES.map(([a, b], i) => (
        <motion.line
          key={`e${i}`}
          x1={NODES[a].x}
          y1={NODES[a].y}
          x2={NODES[b].x}
          y2={NODES[b].y}
          stroke="currentColor"
          strokeWidth={0.7}
          strokeLinecap="round"
          strokeOpacity={0.3}
          animate={
            mounted
              ? { strokeOpacity: thinking ? [0.25, 0.6, 0.25] : [0.15, 0.4, 0.15] }
              : undefined
          }
          transition={
            mounted
              ? {
                  duration: cycle,
                  ease: "easeInOut",
                  repeat: Infinity,
                  delay: thinking ? (i / EDGES.length) * cycle : 0,
                }
              : undefined
          }
        />
      ))}

      {/* outer nodes — sequential light-up when thinking, soft twinkle when idle */}
      {NODES.slice(1).map((n, i) => (
        <motion.circle
          key={`n${i}`}
          cx={n.x}
          cy={n.y}
          r={1.5}
          fill="currentColor"
          fillOpacity={0.6}
          style={{ transformOrigin: `${n.x}px ${n.y}px` }}
          animate={
            mounted
              ? thinking
                ? { fillOpacity: [0.4, 1, 0.4], scale: [1, 1.4, 1] }
                : { fillOpacity: [0.45, 0.8, 0.45] }
              : undefined
          }
          transition={
            mounted
              ? {
                  duration: cycle,
                  ease: "easeInOut",
                  repeat: Infinity,
                  // sequential phase offset → "signal travels the constellation"
                  delay: thinking ? (i / (NODES.length - 1)) * cycle : i * 0.3,
                }
              : undefined
          }
        />
      ))}

      {/* center brand dot (yellow) — the anchor star */}
      <motion.circle
        cx={NODES[0].x}
        cy={NODES[0].y}
        r="3"
        className="fill-yellow-300"
        style={{ transformOrigin: `${NODES[0].x}px ${NODES[0].y}px` }}
        animate={mounted && thinking ? { scale: [1, 1.15, 1] } : undefined}
        transition={
          mounted && thinking
            ? { duration: cycle, ease: "easeInOut", repeat: Infinity }
            : undefined
        }
      />
    </svg>
  );
}
