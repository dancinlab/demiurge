// ArtifactStub — minimal identity + path tuple for everything the LEFT
// Artifacts tab (D33) can list. Phase β (rfc_011 §10) introduces this
// abstraction so the sidebar can populate uniformly across 4 artifact
// kinds; phase γ later promotes selected stubs into full `Artifact`
// instances with their own card / inspector views.
//
// `$<id>` token format per D32:
//   $R<n>       — F1F2 record (n = load-order index, 1-based)
//   $D<n>       — design.md Decision (n = exact D-number)
//   $RFC<n>     — proposals/rfc_<n>_*.md (n = exact RFC number)
//   $DOM:<name> — domains/<name>.md (name = filename stem)

import Foundation

public enum ArtifactKind: String, CaseIterable, Identifiable, Hashable {
    case f1f2     = "Records"
    case decision = "Decisions"
    case rfc      = "RFCs"
    case domain   = "Domains"

    public var id: String { rawValue }

    public var prefix: String {
        switch self {
        case .f1f2:     return "$R"
        case .decision: return "$D"
        case .rfc:      return "$RFC"
        case .domain:   return "$DOM:"
        }
    }
}

public struct ArtifactID: Hashable, Identifiable {
    public let kind: ArtifactKind
    public let key: String                   // "12", "29", "9", "chip" etc.
    public init(kind: ArtifactKind, key: String) {
        self.kind = kind
        self.key  = key
    }
    public var id: String       { "\(kind.prefix)\(key)" }   // "$R12", "$D29"
    public var display: String  { id }
}

public struct ArtifactStub: Identifiable, Hashable {
    public let id: ArtifactID
    public let title: String                  // short human label for sidebar row
    public let path: String                   // absolute filesystem path (or pseudo-path for Decisions)
    public init(id: ArtifactID, title: String, path: String) {
        self.id    = id
        self.title = title
        self.path  = path
    }
}
