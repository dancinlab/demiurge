import { test, expect } from "@playwright/test";

// QA conformance e2e — closes the 2 ⚠️ findings from PR#22 QA.md:
//   1. visible/auth — /dashboard SSR redirect blocks curl conformance.
//      Inject session cookie via DEMIURGE_SESSION_COOKIE env var to verify
//      DashboardSummary mark renders for authenticated users.
//   2. Q13 mobile R3F — verify /structure/qubit renders data-scene marker
//      on mobile viewport (iPhone project picks up automatically).

test.describe("public surfaces (no auth)", () => {
  test("/library renders gallery + browse + fork buttons", async ({ page }) => {
    await page.goto("/library");
    await expect(page.getByRole("heading", { name: /공개 도메인/ })).toBeVisible();
    await expect(page.getByText(/👁 둘러보기/).first()).toBeVisible({ timeout: 10_000 });
  });

  test("/matter renders ledger header", async ({ page }) => {
    await page.goto("/matter");
    await expect(page.getByRole("heading", { name: /matter/ })).toBeVisible();
  });

  test("/structure/qubit slot has JosephsonScene marker", async ({ page }) => {
    await page.goto("/structure/qubit");
    const scene = page.locator('[data-scene="JosephsonScene"]');
    await expect(scene).toBeVisible();
    const mode = await scene.first().getAttribute("data-mode");
    expect(["r3f", "ssr-fallback"]).toContain(mode);
  });
});

test.describe("authenticated surface (gated)", () => {
  // Caller must export DEMIURGE_SESSION_COOKIE (httpOnly cookie value).
  // When missing, these specs are skipped — keeps CI green without secrets.
  const cookie = process.env.DEMIURGE_SESSION_COOKIE;

  test.beforeEach(async ({ context }) => {
    test.skip(!cookie, "DEMIURGE_SESSION_COOKIE not set");
    const url = new URL(process.env.PLAYWRIGHT_BASE_URL ?? "https://demiurge.dancinlab.org");
    await context.addCookies([
      {
        name: "demiurge_session",
        value: cookie!,
        domain: url.hostname,
        path: "/",
        httpOnly: true,
        secure: url.protocol === "https:",
        sameSite: "Lax",
      },
    ]);
  });

  test("/dashboard renders DashboardSummary category cards", async ({ page }) => {
    await page.goto("/dashboard");
    // PR#17 DashboardSummary renders "🗂 카테고리" heading.
    await expect(page.getByText(/카테고리/)).toBeVisible({ timeout: 10_000 });
  });
});
