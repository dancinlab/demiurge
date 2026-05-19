// RtscGeometry — minimal SSOT for the rtsc HTS solenoid coil.
//
// Captures the few dimensions the 3D viewer + future USD exporter need
// to draw an HTS coil cross-section: outer cryostat radius, HTS coil
// radial thickness, bore radius, axial length, plus a turn count for
// later helix visualization. Real HTS designs are far more detailed
// (REBCO tape stacks, joints, current leads, voltage taps) — this is
// the κ-? test-window geometry, NOT a measured coil.
//
// HONEST (g3): bundled `htsSolenoidProxy` is PROCEDURAL PLACEHOLDER
// — typical lab-scale HTS solenoid dimensions, NOT calibrated to any
// published coil. Anything emitted from it carries `measurement_gate`
// GATE_OPEN / absorbed=false. Real coil design lives in the rtsc
// domain expert track (κ-? FEMM + GetDP measurements).

import Foundation

/// One concentric ring of an `RtscGeometry` — drawn as a cylinder
/// of the given radial extent and length.
public struct RtscRing: Codable, Equatable, Sendable, Identifiable {
    public var id: String { name }
    /// Canonical (expert) name, e.g. "Cryostat OVC".
    public let name: String
    /// Plain-language name shown in the cockpit chat layer list.
    public let plainName: String
    /// Material description, e.g. "REBCO HTS tape + Hastelloy".
    public let material: String
    /// Inner radius in mm.
    public let innerRadiusMM: Double
    /// Outer radius in mm.
    public let outerRadiusMM: Double
    /// `#RRGGBB` color.
    public let colorHex: String
    /// `0...1` opacity — translucent for cryostat shells.
    public let opacity: Double

    public init(name: String, plainName: String, material: String,
                innerRadiusMM: Double, outerRadiusMM: Double,
                colorHex: String, opacity: Double) {
        self.name = name
        self.plainName = plainName
        self.material = material
        self.innerRadiusMM = innerRadiusMM
        self.outerRadiusMM = outerRadiusMM
        self.colorHex = colorHex
        self.opacity = opacity
    }
}

public struct RtscGeometry: Codable, Equatable, Sendable {
    public let id: String
    public let displayName: String
    /// Axial length of the solenoid in mm.
    public let lengthMM: Double
    /// Number of turns (for future helix render).
    public let turns: Int
    /// Concentric rings, ordered inside → outside.
    public let rings: [RtscRing]

    public init(id: String, displayName: String, lengthMM: Double,
                turns: Int, rings: [RtscRing]) {
        self.id = id
        self.displayName = displayName
        self.lengthMM = lengthMM
        self.turns = turns
        self.rings = rings
    }

    /// Procedural lab-scale HTS solenoid preset.
    /// Honest scope: typical numbers from open HTS-coil literature, not
    /// a measured / sourced coil design.
    public static let htsSolenoidProxy: RtscGeometry = RtscGeometry(
        id: "hts_solenoid_proxy_v1",
        displayName: "HTS Solenoid Proxy (lab-scale)",
        lengthMM: 200.0,
        turns: 120,
        rings: [
            RtscRing(
                name: "Bore",
                plainName: "Sample bore",
                material: "vacuum / sample volume",
                innerRadiusMM: 0.0, outerRadiusMM: 25.0,
                colorHex: "#2A2A2A", opacity: 0.15),
            RtscRing(
                name: "Cold Mass Support",
                plainName: "Inner support",
                material: "G10 / stainless",
                innerRadiusMM: 25.0, outerRadiusMM: 30.0,
                colorHex: "#7A7A7A", opacity: 1.0),
            RtscRing(
                name: "HTS Coil",
                plainName: "Superconducting coil",
                material: "REBCO HTS tape + Hastelloy",
                innerRadiusMM: 30.0, outerRadiusMM: 55.0,
                colorHex: "#D4A53A", opacity: 1.0),
            RtscRing(
                name: "Cold Mass Jacket",
                plainName: "Coil jacket",
                material: "copper former",
                innerRadiusMM: 55.0, outerRadiusMM: 60.0,
                colorHex: "#B87333", opacity: 1.0),
            RtscRing(
                name: "Radiation Shield",
                plainName: "Heat shield",
                material: "aluminized mylar / MLI",
                innerRadiusMM: 60.0, outerRadiusMM: 75.0,
                colorHex: "#C0C0C0", opacity: 0.45),
            RtscRing(
                name: "Cryostat OVC",
                plainName: "Outer vacuum vessel",
                material: "304L stainless steel",
                innerRadiusMM: 75.0, outerRadiusMM: 90.0,
                colorHex: "#5C7A99", opacity: 0.25),
        ])
}
