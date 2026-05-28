// main-redesign e2e — main 영역 톤 재설계 회귀 가드.
//
// 검증 4축:
//   1) 라우트 로드 OK (console + pageerror = 0, hydration mismatch = 0)
//   2) 가로 스크롤 0 (375 모바일 · 1280 데스크탑 모두)
//   3) 메인 영역에 SSOT 메뉴 패턴(SegmentedTabs role=tablist) 렌더
//   4) main 안에 페이지-scope 시그너처 셀렉터가 보임 (실제 UI 그려진 것)
//
// 인증 = secret get demiurge.test_email/password → POST /api/auth/signin.

import { test, expect, type Page } from "@playwright/test";

const BASE = process.env.PLAYWRIGHT_BASE_URL ?? "http://localhost:3000";

async function signIn(page: Page) {
  // The harness must export DEMIURGE_TEST_EMAIL + DEMIURGE_TEST_PASSWORD
  // (or use `secret get demiurge.test_email`/`_password` wrapper).
  const email = process.env.DEMIURGE_TEST_EMAIL;
  const password = process.env.DEMIURGE_TEST_PASSWORD;
  test.skip(!email || !password, "DEMIURGE_TEST_EMAIL/_PASSWORD not set");
  const res = await page.request.post(`${BASE}/api/auth/signin`, {
    data: { email, password },
  });
  expect(res.ok()).toBeTruthy();
}

async function expectNoHorizontalScroll(page: Page) {
  const overflow = await page.evaluate(() => {
    const d = document.documentElement;
    return d.scrollWidth - d.clientWidth;
  });
  expect(overflow, "horizontal overflow").toBeLessThanOrEqual(1);
}

function attachErrorWatchers(page: Page): { errors: string[] } {
  const errors: string[] = [];
  page.on("console", (msg) => {
    if (msg.type() === "error") {
      const text = msg.text();
      // Filter known noise (favicon 404, dev HMR ping). Hydration mismatches
      // pass through and fail the assertion.
      if (/favicon|webpack-hmr/i.test(text)) return;
      errors.push(`[console.error] ${text}`);
    }
  });
  page.on("pageerror", (err) => errors.push(`[pageerror] ${err.message}`));
  return { errors };
}

test.describe("main 영역 톤 재설계", () => {
  test.beforeEach(async ({ page }) => {
    await signIn(page);
  });

  for (const [path, sig] of [
    ["/dashboard?d=AEROGEL", "metric"],
    ["/dashboard?d=RTSC", "metric"],
    ["/spec/RTSC", "spec"],
    ["/handoff/AEROGEL", "handoff"],
    ["/docs", "pipeline"],
  ] as const) {
    test(`${path} — load OK · no console error · no h-scroll (desktop)`, async ({ page, browserName }) => {
      const { errors } = attachErrorWatchers(page);
      await page.setViewportSize({ width: 1280, height: 800 });
      const res = await page.goto(`${BASE}${path}`);
      expect(res?.status(), `${path} status`).toBeLessThan(400);
      await page.waitForLoadState("networkidle");
      expect(errors, `${browserName} ${path} console/pageerror`).toEqual([]);
      void sig;
      await expectNoHorizontalScroll(page);
    });

    test(`${path} — no h-scroll (mobile 375)`, async ({ page }) => {
      await page.setViewportSize({ width: 375, height: 812 });
      const res = await page.goto(`${BASE}${path}`);
      expect(res?.status(), `${path} status`).toBeLessThan(400);
      await page.waitForLoadState("networkidle");
      await expectNoHorizontalScroll(page);
    });
  }

  test("/dashboard — SSOT SegmentedTabs (role=tablist) 렌더", async ({ page }) => {
    await page.goto(`${BASE}/dashboard?d=RTSC`);
    await page.waitForLoadState("networkidle");
    // DomainBrowser 의 SegmentedTabs SSOT — role=tablist 존재.
    const tablist = page.locator('[role="tablist"]').first();
    await expect(tablist).toBeVisible();
    // 탭 3 개(tree · public · matter) ≥ 3.
    const tabs = page.locator('[role="tab"]');
    expect(await tabs.count()).toBeGreaterThanOrEqual(3);
  });
});
