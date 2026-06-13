// /library — guest-viewable public domain gallery (Q18).
// Members may fork; guests are prompted to sign in.

import { LibraryGallery } from "@/components/LibraryGallery";

export const dynamic = "force-dynamic";

export default function LibraryPage() {
  return (
    <main className="mx-auto max-w-5xl px-6 py-10">
      <header className="mb-6">
        <h1 className="text-2xl font-bold">📖 공개 도메인 라이브러리</h1>
        <p className="mt-1 text-sm text-neutral-500">
          founder 가 등록한 무료 공개 도메인 · 회원은 fork 해서 내 방향으로 자유롭게.
        </p>
      </header>
      <LibraryGallery />
    </main>
  );
}
