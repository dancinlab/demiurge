// GateType — G7 taxonomy (ARCH.md §11.4) for *why* a cell's
// MeasurementGate is OPEN.
//
// `MeasurementGate` says *whether* a cell is open / closed-measured /
// failed; `GateType` says *why* it's open. The aura/ufo simulations
// (§11.1, §11.2) revealed that "install-gated" and "proprietary-
// mandatory" mix together in the current scope_caveats free-text,
// hiding the honest distinction between a substrate that can be
// installed locally vs one that requires a regulator-approved tool.
//
// Each Producer-side substrate emits this field alongside the
// MeasurementGate; the cockpit project-wide dashboard (G2) groups
// records by GateType so users see the real shape of the gap.
//
// D80 g_hexa_only — `hexaNativeAbsent` is a distinct GateType
// because even an `installGated` substrate that passes its own
// parity check is *still* hexa-native-absent until the kernel
// lands.
//
// D106 (P-⑩ ③ · RFC 013 §6.3) — `illustrativePhysics` is the
// third hexa-native dimension and is structurally distinct from
// the two port-blocked buckets (`hexaNativeAbsent` /
// `hexaNativeFuture`): a hexa-native kernel EXISTS and its
// substrate parity has PASSED, but the kernel is a *pattern-
// proof* (illustrative MC, single-energy-group, closed-form
// oracle), NOT a cell-level measured-oracle replacement. The
// canonical occupant is `mc_slab_demo` (FusionVerifyRecord, RFC
// 013 §4.2 pilot #2): even with substrate-parity PASS, the cell
// can NEVER flip `absorbed=true` from this kernel alone — it
// stays measurement-gated on OpenMC. The chip MUST paint a
// 4th tone (illustrative-physics), NOT the green absorbed tone
// (RFC 013 §6.3 anti-conflation).

import Foundation

public enum GateType: String, Codable, Sendable, CaseIterable {

    /// Substrate (Python / C++ tool) not installed locally — user
    /// can `brew install` or `pip install` to unblock.
    case installGated = "install-gated"

    /// Platform mismatch — substrate is Windows-only (FEMM via Wine),
    /// Linux-only (CARLA / Unreal), or otherwise platform-bound. User
    /// would need to switch hosts or use the wilson-pool.
    case platformGated = "platform-gated"

    /// Reference data missing — substrate is installed but a required
    /// dataset (ENDF/B-VIII.0 ~3GB, WebbPSF reference, …) is not
    /// downloaded. User can fetch the dataset to unblock.
    case dataGated = "data-gated"

    /// Regulatory-bound — verify path requires a regulator-approved
    /// tool (FDA Class III PMA, Sim4Life MDDT for MRI safety, …) and
    /// open replacement does not exist in the public surface (D1
    /// clean-room). User needs a regulated lab, not a software fix.
    case regulatoryGated = "regulatory-gated"

    /// Proprietary-only with no open equivalent — Cadence Virtuoso /
    /// Synopsys Sentaurus / Schrödinger LiveDesign / ANSYS Maxwell.
    /// Distinct from `regulatoryGated` (regulator forces specific
    /// proprietary tool) and `installGated` (open tool exists, just
    /// not installed).
    case proprietaryOnly = "proprietary-only"

    /// D80 — substrate is permanently nonportable (no hexa-native
    /// kernel will ever land — CARLA, Drake, Geant4, GMAT, FEMM
    /// proprietary stacks). Distinct from `hexaNativeFuture` (heavy-
    /// port but tractable). Marked permanent so the G2 dashboard
    /// stops re-asking "why hasn't X been absorbed?".
    ///
    /// Driven by `demiurge/domains/DEPENDENCIES.demi` rows where
    /// `portable_status = "nonportable"`. See `DependenciesLoader`.
    case hexaNativeAbsent = "hexa-native-absent"

    /// D80 — substrate has a multi-round port horizon (FFT, sparse
    /// FEM linear-algebra, autodiff, MGXS). Distinct from
    /// `hexaNativeAbsent` (permanent): the cell is provisionally
    /// `absorbed=true` on the transitional substrate AND tracked as
    /// future-portable so the G2 dashboard surfaces the port queue.
    ///
    /// Driven by `demiurge/domains/DEPENDENCIES.demi` rows where
    /// `portable_status = "heavy-port"`. See `DependenciesLoader`.
    case hexaNativeFuture = "hexa-native-future"

    /// D106 (P-⑩ ③ · RFC 013 §6.3) — substrate-parity PASS *exists*
    /// for the linked hexa-native kernel, but the kernel itself is
    /// illustrative-physics (pattern-proof / single-energy-group /
    /// closed-form analytic oracle), NOT a cell-level measured-oracle
    /// replacement. Distinct from the two port-blocked buckets:
    /// `hexaNativeAbsent` (no port will land) and `hexaNativeFuture`
    /// (port queued but not landed); here the port is LANDED and
    /// PASSING, yet measurement parity still rides the external
    /// oracle (e.g. OpenMC for `mc_slab_demo`). The cockpit chip
    /// paints a 4th tone for this case — it MUST NOT collapse to
    /// the green absorbed tone (RFC 013 §6.3 anti-conflation).
    ///
    /// Canonical occupant: `FusionVerifyRecord` with
    /// `hexaNativeParity` pointing at
    /// `stdlib/kernels/mc_transport/mc_slab_demo.hexa` (RFC 013
    /// §4.2 pilot #2). Cell-level `absorbed=true` requires a
    /// measured oracle for the cell's own outputs — substrate
    /// parity PASS on an illustrative kernel does NOT meet that bar.
    case illustrativePhysics = "illustrative-physics"

    /// Substrate spec exists but no producer has been wired yet
    /// (cell is "honest-gap LLM fallback path"). Counts under "still
    /// to build" rather than "still to install".
    case producerAbsent = "producer-absent"

    /// Catch-all for cells that don't yet declare a GateType. Should
    /// be rare; G2 dashboard flags these for review.
    case unspecified = "unspecified"
}

/// Convenience grouping for the G2 dashboard.
public extension GateType {
    /// True when the gate could be resolved by the *user* doing an
    /// install or download (no demiurge-side code change needed).
    var userResolvable: Bool {
        switch self {
        case .installGated, .platformGated, .dataGated: return true
        case .regulatoryGated, .proprietaryOnly,
             .hexaNativeAbsent, .hexaNativeFuture,
             .illustrativePhysics,
             .producerAbsent, .unspecified: return false
        }
    }

    /// True when the gate requires a demiurge-side hexa-native port
    /// to flip from provisional → non-provisional absorbed=true.
    /// Covers both the permanent (`hexaNativeAbsent`) and the
    /// future-portable (`hexaNativeFuture`) buckets.
    ///
    /// D106 — `illustrativePhysics` is INTENTIONALLY excluded: the
    /// port is landed and parity-passing; the blocker is the
    /// cell-level measured oracle, NOT the port. Conflating the
    /// two would mask the honest gap (RFC 013 §6.3 anti-conflation).
    var hexaNativeBlocked: Bool {
        self == .hexaNativeAbsent || self == .hexaNativeFuture
    }

    /// D106 (P-⑩ ③ · RFC 013 §6.3) — True when the gate signals that
    /// substrate parity has PASSED on an illustrative-physics kernel,
    /// so the cell's measurement parity still rides an external
    /// oracle. UI MUST NOT paint this as the green absorbed tone;
    /// callers (chip / dashboard) branch on this predicate to render
    /// the 4th tone.
    var isIllustrativePhysics: Bool {
        self == .illustrativePhysics
    }

    /// Korean label for the cockpit ProvenanceBanner and G2 dashboard.
    var label: String {
        switch self {
        case .installGated:      return "설치 필요"
        case .platformGated:     return "플랫폼 제한"
        case .dataGated:         return "데이터 누락"
        case .regulatoryGated:   return "규제 인증 필요"
        case .proprietaryOnly:   return "상용 전용 (오픈 부재)"
        case .hexaNativeAbsent:  return "hexa-native 포트 부재 (영구)"
        case .hexaNativeFuture:  return "hexa-native 포트 예정 (heavy-port)"
        case .illustrativePhysics:
            return "illustrative-physics (substrate parity PASS · 측정 oracle 부재)"
        case .producerAbsent:    return "producer 미작성"
        case .unspecified:       return "분류 안 됨"
        }
    }
}
