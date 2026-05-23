// SynthesisRecipeRecord — RTSC.md §8.7 Tier 2 (recipe-as-record). Typed JSON
// describing how a material is supposed to be synthesised. demiurge does NOT
// execute synthesis — the SSOT here is the recipe + citation only.
//
// Family axis mirrors RTSC.md §8.2 (LTS · MgB₂ · FeSC · HTS Cuprate · Heavy
// hydride · TBG · claim-only hypothetical · hexa-rtsc n=6). Kind axis mirrors
// §8.3 synthesis routes (solid_state_reaction · diamond_anvil_cell · mocvd ·
// single_crystal_growth · twisted_exfoliation · sol_gel_sinter · pit_wire).
//
// g3 (RTSC.md §8.8) — honest stance:
//   • A recipe without provenance is rejected — `provenance` is non-optional.
//   • `replicatedByIndependentLabs == 0` ⇒ claim-only territory; absorbed=false
//     永遠. The schema does not gate this — the producer / loader must.
//   • RTSC-class claims (hexa-rtsc n=6 closed-form, any claim-only family)
//     never reach absorbed=true even if the recipe ingests cleanly.
//     Tier 4 falsifier dispatch decides that.
//
// Style: mirrors HtsVerifyRecord.swift — camelCase properties + explicit
// CodingKeys mapping to snake_case JSON. Sub-structs are nested for tight
// coupling to the parent record. All members `public` so DemiurgeCLI and
// CockpitApp can both decode.

import Foundation

public struct SynthesisRecipeRecord: Codable, Equatable, Sendable {
    public let domain: String
    public let verb: String
    public let kind: String
    public let stamp: String
    public let family: String
    public let targetCompound: String
    public let reagents: [Reagent]
    public let conditions: Conditions
    public let replicatedByIndependentLabs: Int
    public let measurementGate: F1F2Record.MeasurementGate
    public let absorbed: Bool
    public let gateType: String?
    public let provisional: Bool?
    public let provenance: Provenance
    public let scopeCaveats: [String]
    public let citations: [String]

    public struct Reagent: Codable, Equatable, Sendable {
        public let compound: String
        public let molRatio: Double
        public let supplier: String?
        public let gradePurity: String?

        enum CodingKeys: String, CodingKey {
            case compound
            case molRatio = "mol_ratio"
            case supplier
            case gradePurity = "grade_purity"
        }
    }

    public struct TemperatureStep: Codable, Equatable, Sendable {
        public let timeMin: Double
        public let tempC: Double

        enum CodingKeys: String, CodingKey {
            case timeMin = "time_min"
            case tempC = "temp_c"
        }
    }

    public struct Conditions: Codable, Equatable, Sendable {
        public let temperatureProfileC: [TemperatureStep]
        public let atmosphereGas: String
        public let atmospherePressureBar: Double
        public let durationHours: Double

        enum CodingKeys: String, CodingKey {
            case temperatureProfileC = "temperature_profile_c"
            case atmosphereGas = "atmosphere_gas"
            case atmospherePressureBar = "atmosphere_pressure_bar"
            case durationHours = "duration_hours"
        }
    }

    public struct Provenance: Codable, Equatable, Sendable {
        public let sourceUrl: String
        public let sourcePaperArxivId: String?
        public let sourceCitation: String

        enum CodingKeys: String, CodingKey {
            case sourceUrl = "source_url"
            case sourcePaperArxivId = "source_paper_arxiv_id"
            case sourceCitation = "source_citation"
        }
    }

    enum CodingKeys: String, CodingKey {
        case domain, verb, kind, stamp, family
        case targetCompound = "target_compound"
        case reagents, conditions
        case replicatedByIndependentLabs = "replicated_by_independent_labs"
        case measurementGate = "measurement_gate"
        case absorbed
        case gateType = "gate_type"
        case provisional, provenance
        case scopeCaveats = "scope_caveats"
        case citations
    }
}
