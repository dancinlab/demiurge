// Domain — single source of truth for per-domain metadata.
//
// SSOT rule (AGENTS.tape g_ssot_single_source): the domain key list,
// display labels, canvas-mode mapping, and free-text inference
// keywords all live HERE — cockpit and CLI both consume DomainCatalog
// rather than each carrying its own `switch` over domain strings.
//
// DemiurgeCore stays pure Foundation (Package.swift contract).

import Foundation

/// Which ② work-zone canvas mode a domain renders in (rfc_011 §7).
/// The mapping is data; the cockpit turns a mode into a SwiftUI view.
public enum CanvasMode: String, Sendable {
    case chip, component, matter, cohort
}

/// One demiurge domain's metadata.
public struct Domain: Identifiable, Sendable {
    /// Domain key — "chip", "component", … (matches Project.domain).
    public let id: String
    /// Plain-language display label (rfc_012 §4).
    public let label: String
    /// Canvas mode for the ② work zone (rfc_011 §7).
    public let canvasMode: CanvasMode
    /// Free-text inference hints (rfc_012 §3 / D44).
    public let keywords: [String]

    public init(id: String, label: String, canvasMode: CanvasMode, keywords: [String]) {
        self.id = id
        self.label = label
        self.canvasMode = canvasMode
        self.keywords = keywords
    }

    /// Cross-repo sibling — every demiurge domain has a `hexa-<id>`
    /// sibling repo under `~/core/` (like hexa-lang / hexa-matter).
    /// rfc_012 §7 (D45) keeps the cockpit isolated; the sibling is
    /// just a pointer the workbench surfaces, never written to.
    public var siblingRepoPath: String { "~/core/hexa-\(id)" }

    /// Does the sibling repo exist on disk? FileManager check is pure
    /// Foundation — OK in DemiurgeCore.
    public var siblingRepoExists: Bool {
        let expanded = (siblingRepoPath as NSString).expandingTildeInPath
        return FileManager.default.fileExists(atPath: expanded)
    }
}

/// The domain catalog — the one place domain metadata is defined.
public enum DomainCatalog {
    /// One row per domain. The id matches `domains/<id>.md` (the §6
    /// design-options source) — except `chip` (covered by rfc_001..003,
    /// no domain map) and `matter` (a D17 pointer, `domains/matter/`).
    public static let all: [Domain] = [
        Domain(id: "chip", label: "칩 설계", canvasMode: .chip,
               keywords: ["칩", "반도체", "chip", "soc", "asic", "프로세서", "cpu", "gpu", "noc"]),
        Domain(id: "component", label: "부품 설계", canvasMode: .component,
               keywords: ["부품", "component", "기구", "케이스", "enclosure", "패키지", "heatsink", "방열"]),
        Domain(id: "matter", label: "물질·재료", canvasMode: .matter,
               keywords: ["물질", "재료", "material", "합금", "분자", "matter", "소재"]),
        Domain(id: "antimatter", label: "반물질·트랩", canvasMode: .cohort,
               keywords: ["반물질", "antimatter", "positron", "penning", "트랩", "pet"]),
        Domain(id: "aura", label: "청각 웨어러블", canvasMode: .cohort,
               keywords: ["청각", "귀", "이어", "aura", "eeg", "웨어러블", "보청"]),
        Domain(id: "bot", label: "로봇", canvasMode: .cohort,
               keywords: ["로봇", "robot", "bot", "매니퓰레이터", "구동", "actuator"]),
        Domain(id: "brain", label: "뇌·신경", canvasMode: .cohort,
               keywords: ["뇌", "brain", "신경", "neuro", "인지", "bci", "전극"]),
        Domain(id: "cern", label: "가속기·입자", canvasMode: .cohort,
               keywords: ["가속기", "cern", "입자", "빔", "beamline", "lattice"]),
        Domain(id: "energy", label: "에너지", canvasMode: .cohort,
               keywords: ["에너지", "배터리", "energy", "태양", "solar", "전력", "발전", "원자로"]),
        Domain(id: "fusion", label: "핵융합", canvasMode: .cohort,
               keywords: ["핵융합", "fusion", "플라즈마", "토카막", "plasma", "tokamak"]),
        Domain(id: "grid", label: "AI 데이터센터", canvasMode: .cohort,
               keywords: ["데이터센터", "grid", "데이터", "서버", "랙", "fabric"]),
        Domain(id: "mobility", label: "자율주행", canvasMode: .cohort,
               keywords: ["자율주행", "mobility", "자동차", "차량", "자율", "운전"]),
        Domain(id: "rtsc", label: "초전도 코일", canvasMode: .cohort,
               keywords: ["초전도", "rtsc", "코일", "권선", "rebco"]),
        Domain(id: "scope", label: "망원경·광학", canvasMode: .cohort,
               keywords: ["망원경", "scope", "거울", "광학", "telescope"]),
        Domain(id: "space", label: "우주·항공", canvasMode: .cohort,
               keywords: ["우주", "위성", "space", "로켓", "궤도", "satellite", "항공"]),
        Domain(id: "sscb", label: "솔리드스테이트 차단기", canvasMode: .cohort,
               keywords: ["차단기", "sscb", "interrupter", "차단"]),
    ]

    /// Domain for a key — a synthetic "general" cohort domain when the
    /// key is not in the catalog (so callers never crash on an unknown
    /// domain; the user can correct it via the §3 confirm step).
    public static func domain(for key: String) -> Domain {
        if let known = all.first(where: { $0.id == key }) {
            return known
        }
        return Domain(
            id: key,
            label: key == "general" ? "일반 공학" : key,
            canvasMode: .cohort,
            keywords: [])
    }

    /// Free-text → best-effort domain key (rfc_012 §3, D44 option C).
    /// "general" when nothing matches — the confirm step lets the user
    /// correct it, so the AI infers but never finalizes (g3).
    public static func infer(from target: String) -> String {
        let t = target.lowercased()
        for domain in all where domain.keywords.contains(where: { t.contains($0) }) {
            return domain.id
        }
        return "general"
    }
}
