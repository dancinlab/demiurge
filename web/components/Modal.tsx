"use client";

// Modal — 재사용형 팝업/모달. @radix-ui/react-dialog 기반 (overlay + content,
// 포커스 트랩 · Esc 닫기 · aria 접근성은 Radix 가 제공). 전환(fade + scale)은
// Motion + useReducedMotion 으로 — reduced-motion 이면 무모션 즉시 표시/숨김.
//
// 시맨틱 토큰만(bg-surface · border-hairline · text-ink · rounded-card 등).
// 라벨/제목은 호출부에서 i18n prop 으로 주입 — 하드코딩 텍스트 없음.

import * as Dialog from "@radix-ui/react-dialog";
import { AnimatePresence, motion } from "motion/react";
import { useEffectiveReducedMotion } from "@/lib/motion";
import { X } from "lucide-react";
import type { ReactNode } from "react";

const EASE_BRAND = [0.23, 1, 0.32, 1] as const;

export function Modal({
  open,
  onOpenChange,
  trigger,
  title,
  description,
  closeLabel,
  children,
  footer,
}: {
  open?: boolean;
  onOpenChange?: (open: boolean) => void;
  /** 선택적 트리거 — 제어형(open prop)으로도 쓸 수 있다. */
  trigger?: ReactNode;
  title: string;
  description?: string;
  /** 닫기 버튼 aria-label (i18n) */
  closeLabel: string;
  children?: ReactNode;
  footer?: ReactNode;
}) {
  const reduced = useEffectiveReducedMotion();

  return (
    <Dialog.Root open={open} onOpenChange={onOpenChange}>
      {trigger && <Dialog.Trigger asChild>{trigger}</Dialog.Trigger>}
      {/* forceMount + AnimatePresence: Radix가 즉시 unmount하지 않게 두고
          Motion이 exit 전환을 끝낸 뒤 사라지도록. open 값으로 AnimatePresence 제어. */}
      <AnimatePresence>
        {open && (
          <Dialog.Portal forceMount>
            <Dialog.Overlay asChild forceMount>
              <motion.div
                className="fixed inset-0 z-50 bg-inverted/40 backdrop-blur-[2px]"
                initial={reduced ? false : { opacity: 0 }}
                animate={{ opacity: 1 }}
                exit={reduced ? { opacity: 0 } : { opacity: 0 }}
                transition={{ duration: 0.18, ease: EASE_BRAND }}
              />
            </Dialog.Overlay>
            <Dialog.Content asChild forceMount>
              <motion.div
                className="fixed left-1/2 top-1/2 z-50 w-[min(92vw,30rem)] -translate-x-1/2 -translate-y-1/2 rounded-card border border-hairline bg-surface p-5 shadow-card focus:outline-none"
                initial={reduced ? false : { opacity: 0, scale: 0.96, y: 4 }}
                animate={{ opacity: 1, scale: 1, y: 0 }}
                exit={reduced ? { opacity: 0 } : { opacity: 0, scale: 0.96, y: 4 }}
                transition={{ duration: 0.22, ease: EASE_BRAND }}
              >
                <div className="mb-3 flex items-start justify-between gap-3">
                  <div className="space-y-1">
                    <Dialog.Title className="font-display text-base font-medium text-ink">
                      {title}
                    </Dialog.Title>
                    {description && (
                      <Dialog.Description className="text-[13px] text-muted">
                        {description}
                      </Dialog.Description>
                    )}
                  </div>
                  <Dialog.Close
                    aria-label={closeLabel}
                    className="shrink-0 rounded-control p-1 text-muted transition hover:bg-surface-strong hover:text-ink focus:outline-none"
                  >
                    <X className="h-4 w-4" />
                  </Dialog.Close>
                </div>
                {children}
                {footer && (
                  <div className="mt-4 flex items-center justify-end gap-2">{footer}</div>
                )}
              </motion.div>
            </Dialog.Content>
          </Dialog.Portal>
        )}
      </AnimatePresence>
    </Dialog.Root>
  );
}
