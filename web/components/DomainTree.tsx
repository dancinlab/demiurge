// DomainTree — recursive domain browser (client). Renders the meta↔sub
// hierarchy from lib/domains listDomainTree(): meta-domains (e.g. CARDIO+)
// expand/collapse to reveal sub-domains (DAPTPGX · DOCTOR · ISR · LPA ·
// NOREFLOW), which may themselves nest. Each node shows:
//   · domain name (+ canonical id on hover)
//   · progress (done/total · %) when the .md carries milestones
//   · a scale badge (atom · material · chip · component · system) ONLY when the
//     data yields one — never invented (#6b: data-less → unmarked)
//   · a verb-launch affordance (→ /spec/<id>, the canonical first build verb)
//
// Selecting a node sets it active (?d=<id>) and opens its spec workspace.
// Semantic tokens only (DESIGN_TOKENS.md SSOT). Copy arrives as i18n props.

"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { useTransition } from "react";
import { setActiveDomain } from "@/app/actions/active-domain";
import {
  DndContext,
  PointerSensor,
  KeyboardSensor,
  useSensor,
  useSensors,
  closestCenter,
  type DragEndEvent,
} from "@dnd-kit/core";
import {
  SortableContext,
  sortableKeyboardCoordinates,
  useSortable,
  verticalListSortingStrategy,
} from "@dnd-kit/sortable";
import { restrictToVerticalAxis, restrictToParentElement } from "@dnd-kit/modifiers";
import { CSS } from "@dnd-kit/utilities";
import { GripVertical } from "lucide-react";

// #5 dnd-kit — 대시보드 도메인 트리 top-level 노드 개인 선호 순서.
// 표시 레이어 + localStorage 영속만 — 데이터 SSOT(서버 트리)는 불변. 8-verb
// spine 은 건드리지 않는다(트리 ≠ verb spine).
const ORDER_KEY = "demiurge.domainTree.order";

function loadOrder(): string[] {
  if (typeof window === "undefined") return [];
  try {
    const raw = localStorage.getItem(ORDER_KEY);
    if (!raw) return [];
    const arr = JSON.parse(raw);
    return Array.isArray(arr) ? (arr as string[]) : [];
  } catch {
    return [];
  }
}

function saveOrder(ids: string[]): void {
  if (typeof window === "undefined") return;
  try {
    localStorage.setItem(ORDER_KEY, JSON.stringify(ids));
  } catch {
    /* quota / disabled storage — silently drop */
  }
}

// 저장된 선호 순서를 서버 트리에 적용. 저장된 id 우선, 신규(미저장) id 는 원래
// 순서대로 뒤에 append — 도메인 추가/삭제에도 안전(데이터 SSOT 추종).
function applyOrder(nodes: TreeNode[], order: string[]): TreeNode[] {
  if (order.length === 0) return nodes;
  const byId = new Map(nodes.map((n) => [n.id, n]));
  const out: TreeNode[] = [];
  for (const id of order) {
    const n = byId.get(id);
    if (n) {
      out.push(n);
      byId.delete(id);
    }
  }
  for (const n of nodes) if (byId.has(n.id)) out.push(n);
  return out;
}

// Mirror of lib/domains DomainNode, serialized (children inline). We keep a
// local type so this client module doesn't import server-only fs code.
export type TreeNode = {
  name: string;
  id: string;
  depth: number;
  scale: "atom" | "material" | "chip" | "component" | "system" | null;
  progress: { done: number; total: number } | null;
  children: TreeNode[];
};

export type DomainTreeI18n = {
  scaleAtom: string;
  scaleMaterial: string;
  scaleChip: string;
  scaleComponent: string;
  scaleSystem: string;
  open: string; // "open" verb-launch label
  emptyTree: string;
  reorder: string; // drag-handle aria-label (#5)
};

const SCALE_ICON: Record<NonNullable<TreeNode["scale"]>, string> = {
  atom: "⚛",
  material: "🧱",
  chip: "🪪",
  component: "🧩",
  system: "🗂",
};

function pctOf(p: TreeNode["progress"]): number | null {
  if (!p || p.total <= 0) return null;
  return Math.round((100 * p.done) / p.total);
}

function ScaleBadge({
  scale,
  i18n,
}: {
  scale: NonNullable<TreeNode["scale"]>;
  i18n: DomainTreeI18n;
}) {
  const label =
    scale === "atom"
      ? i18n.scaleAtom
      : scale === "material"
        ? i18n.scaleMaterial
        : scale === "chip"
          ? i18n.scaleChip
          : scale === "component"
            ? i18n.scaleComponent
            : i18n.scaleSystem;
  return (
    <span className="inline-flex items-center gap-1 text-[10px] text-muted">
      <span aria-hidden="true">{SCALE_ICON[scale]}</span>
      {label}
    </span>
  );
}

function NodeRow({
  node,
  i18n,
  activeId,
  dragHandle,
}: {
  node: TreeNode;
  i18n: DomainTreeI18n;
  activeId: string | null;
  // #5 top-level 행에만 주입되는 드래그 핸들(nested 행은 undefined → 핸들 없음).
  dragHandle?: React.ReactNode;
}) {
  const hasChildren = node.children.length > 0;
  // Meta-domains default open so the tree shows its hierarchy at a glance.
  const [open, setOpen] = useState(node.depth === 0 && hasChildren);
  const router = useRouter();
  const [isPending, startTransition] = useTransition();
  const pct = pctOf(node.progress);
  const isActive = activeId === node.id;

  function select() {
    startTransition(async () => {
      await setActiveDomain(node.name);
      // ?d= syncs the active cookie via middleware; spec is the first build verb.
      router.push(`/spec/${node.id.split("/").map(encodeURIComponent).join("/")}`);
      router.refresh();
    });
  }

  return (
    <li>
      <div
        className={[
          "flex items-center gap-2 rounded-chip px-2 py-1.5 text-[13px] transition",
          isActive
            ? "bg-surface font-semibold text-ink"
            : "text-body-strong hover:bg-surface hover:text-ink",
        ].join(" ")}
        style={{ paddingLeft: `${0.5 + node.depth * 0.9}rem` }}
      >
        {dragHandle}
        {hasChildren ? (
          <button
            type="button"
            onClick={() => setOpen((o) => !o)}
            aria-expanded={open}
            aria-label={node.name}
            className="flex h-4 w-4 shrink-0 items-center justify-center text-muted hover:text-ink"
          >
            <svg
              width="10"
              height="10"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              strokeWidth="3"
              strokeLinecap="round"
              strokeLinejoin="round"
              aria-hidden="true"
              className={open ? "rotate-90 transition" : "transition"}
            >
              <path d="M9 6l6 6-6 6" />
            </svg>
          </button>
        ) : (
          <span className="inline-block h-4 w-4 shrink-0" aria-hidden="true" />
        )}

        <button
          type="button"
          onClick={select}
          disabled={isPending}
          title={node.id}
          className="flex min-w-0 flex-1 items-center gap-2 text-left disabled:opacity-60"
        >
          <span className="truncate font-mono">{node.name}</span>
          {node.scale && <ScaleBadge scale={node.scale} i18n={i18n} />}
          {pct !== null && (
            <span className="ml-auto shrink-0 text-[11px] text-muted">
              {node.progress!.done}/{node.progress!.total} · {pct}%
            </span>
          )}
        </button>
      </div>

      {hasChildren && open && (
        <ul className="space-y-0.5">
          {node.children.map((c) => (
            <NodeRow key={c.id} node={c} i18n={i18n} activeId={activeId} />
          ))}
        </ul>
      )}
    </li>
  );
}

// #5 top-level 행을 dnd-kit sortable 로 감싸는 래퍼. li(=sortable node ref)에
// transform/transition 을 걸고, 드래그 핸들(GripVertical)을 NodeRow 에 주입한다.
// NodeRow 자신이 <li> 를 렌더하므로 중첩 li 를 피하려 내부를 list-none <ul> 로 감싼다.
// nested 자식 트리는 NodeRow 가 그대로 재귀 렌더(자식은 sortable 아님 — top-level 만).
function SortableNodeRow({
  node,
  i18n,
  activeId,
}: {
  node: TreeNode;
  i18n: DomainTreeI18n;
  activeId: string | null;
}) {
  const { attributes, listeners, setNodeRef, transform, transition, isDragging } =
    useSortable({ id: node.id });
  const style: React.CSSProperties = {
    transform: CSS.Transform.toString(transform),
    transition,
    opacity: isDragging ? 0.6 : 1,
  };
  const handle = (
    <span
      {...attributes}
      {...listeners}
      aria-label={i18n.reorder}
      title={i18n.reorder}
      role="button"
      tabIndex={0}
      className="flex h-4 w-4 shrink-0 cursor-grab touch-none items-center justify-center text-muted-soft hover:text-ink active:cursor-grabbing"
    >
      <GripVertical className="h-3 w-3" />
    </span>
  );
  return (
    <li ref={setNodeRef} style={style}>
      <ul className="list-none">
        <NodeRow node={node} i18n={i18n} activeId={activeId} dragHandle={handle} />
      </ul>
    </li>
  );
}

export function DomainTree({
  nodes,
  i18n,
  activeId = null,
}: {
  nodes: TreeNode[];
  i18n: DomainTreeI18n;
  activeId?: string | null;
}) {
  // 저장된 선호 순서 → 서버 트리에 적용한 표시용 순서(데이터 SSOT 불변).
  const [order, setOrder] = useState<string[]>([]);
  // Hydration-safe mount 가드: dnd-kit useSortable/DndContext 는 SSR 비결정
  // id(aria-describedby = `DndDescribedBy-N`, live-region id)를 모듈-레벨 카운터
  // (useUniqueId, not React useId)로 만들어 서버/클라 attribute 가 갈린다 →
  // "tree hydrated but some attributes ... didn't match" hydration mismatch.
  // 그래서 서버 + 첫 클라 렌더(hydration)는 dnd 없는 정적 <ul> 을 그리고, mount
  // 이후(클라 전용)에만 DndContext 를 켠다. 첫 트리에 dnd attribute 가 0 이므로
  // 불일치할 것이 없다. localStorage 선호 순서도 mount 후에만 적용(같은 가드).
  const [mounted, setMounted] = useState(false);
  useEffect(() => {
    setMounted(true);
    setOrder(loadOrder());
  }, []);

  const sensors = useSensors(
    useSensor(PointerSensor, { activationConstraint: { distance: 4 } }),
    useSensor(KeyboardSensor, { coordinateGetter: sortableKeyboardCoordinates }),
  );

  if (nodes.length === 0) {
    return (
      <p className="py-6 text-sm text-muted">
        {i18n.emptyTree}
      </p>
    );
  }

  const ordered = applyOrder(nodes, order);
  const ids = ordered.map((n) => n.id);

  // 서버 + hydration(첫 클라 렌더) — dnd 없는 정적 리스트. 드래그 핸들 미주입.
  // 표시·선택·확장 등 모든 기능은 동일하게 작동(드래그 정렬만 mount 후 활성).
  if (!mounted) {
    return (
      <ul className="space-y-0.5">
        {ordered.map((n) => (
          <NodeRow key={n.id} node={n} i18n={i18n} activeId={activeId} />
        ))}
      </ul>
    );
  }

  function onDragEnd(e: DragEndEvent): void {
    const { active, over } = e;
    if (!over || active.id === over.id) return;
    const from = ids.indexOf(String(active.id));
    const to = ids.indexOf(String(over.id));
    if (from < 0 || to < 0) return;
    const next = ids.slice();
    next.splice(to, 0, next.splice(from, 1)[0]);
    setOrder(next);
    saveOrder(next);
  }

  // mount 이후(클라 전용) — dnd 활성. hydration 이 끝났으므로 트리 교체 안전.
  return (
    <DndContext
      sensors={sensors}
      collisionDetection={closestCenter}
      modifiers={[restrictToVerticalAxis, restrictToParentElement]}
      onDragEnd={onDragEnd}
    >
      <SortableContext items={ids} strategy={verticalListSortingStrategy}>
        <ul className="space-y-0.5">
          {ordered.map((n) => (
            <SortableNodeRow key={n.id} node={n} i18n={i18n} activeId={activeId} />
          ))}
        </ul>
      </SortableContext>
    </DndContext>
  );
}
