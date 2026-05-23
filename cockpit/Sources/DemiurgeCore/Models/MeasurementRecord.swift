// MeasurementRecord — Tier 3 (measurement ingest) typed record.
//
// RTSC.md §8.7 Tier 3: external instruments emit measurement data; demiurge
// ingests typed records describing *what* was measured. SSOT for the §8.4
// 9-test characterization matrix (R(T) · Meissner χ(T,B) · AC susceptibility ·
// Cp(T) · Jc(B,T,θ) · Hc2(T) · isotope effect · STM vortex lattice · DFT band).
//
// Honest g3 (RTSC.md §8.7 → §8.8):
//   - replicationCount=1 for first ingest — even vendor datasheets are not
//     absorbed=true on first sight.
//   - absorbed=false 영원히 for vendor-datasheet origin unless cross-validated
//     by independent measurement (replicationCount ≥ 2 across labs).
//   - citations + provenance.sourceUrl are mandatory; missing → REJECTED.
//
// Codable pattern mirrors F1F2Record / HtsVerifyRecord — camelCase Swift
// surface + explicit CodingKeys → snake_case JSON wire form. Reuses the
// F1F2Record.MeasurementGate enum (the SSOT for gate state across the cockpit).

import Foundation

public struct MeasurementRecord: Codable, Equatable, Sendable {
    public let domain: String
    public let verb: String
    public let kind: String
    public let stamp: String
    public let sampleId: String
    public let testFamily: String
    public let testCompound: String
    public let instrument: Instrument
    public let operator_: String?
    public let sampleProvenance: SampleProvenance?
    public let rawDataHash: String?
    public let dataPoints: [DataPoint]
    public let headline: Headline
    public let measurementGate: F1F2Record.MeasurementGate
    public let replicationCount: Int
    public let absorbed: Bool
    public let gateType: String?
    public let provisional: Bool?
    public let provenance: Provenance
    public let scopeCaveats: [String]
    public let citations: [String]

    public struct Instrument: Codable, Equatable, Sendable {
        public let model: String
        public let vendor: String
        public let calibrationDate: String?

        enum CodingKeys: String, CodingKey {
            case model
            case vendor
            case calibrationDate = "calibration_date"
        }
    }

    public struct SampleProvenance: Codable, Equatable, Sendable {
        public let synthesisRecipeRecordId: String?
        public let vendor: String?
        public let batchLot: String?

        enum CodingKeys: String, CodingKey {
            case synthesisRecipeRecordId = "synthesis_recipe_record_id"
            case vendor
            case batchLot = "batch_lot"
        }
    }

    public struct DataPoint: Codable, Equatable, Sendable {
        public let independentVarName: String
        public let independentVarValue: Double
        public let independentVarUnit: String
        public let dependentVarName: String
        public let dependentVarValue: Double
        public let dependentVarUnit: String

        enum CodingKeys: String, CodingKey {
            case independentVarName = "independent_var_name"
            case independentVarValue = "independent_var_value"
            case independentVarUnit = "independent_var_unit"
            case dependentVarName = "dependent_var_name"
            case dependentVarValue = "dependent_var_value"
            case dependentVarUnit = "dependent_var_unit"
        }
    }

    /// One or two scalar takeaways. For Jc(B,θ): peakJcAm2 + fieldT + tempK.
    /// For R(T): tcK. For Cp(T): deltaCpOverGammaTc. Fields are optional so
    /// one struct serves all §8.4 9-test rows.
    public struct Headline: Codable, Equatable, Sendable {
        public let peakJcAm2: Double?
        public let fieldT: Double?
        public let tempK: Double?
        public let tcK: Double?
        public let deltaCpOverGammaTc: Double?
        public let hc2T: Double?
        public let chiVolumetric: Double?

        public init(
            peakJcAm2: Double? = nil,
            fieldT: Double? = nil,
            tempK: Double? = nil,
            tcK: Double? = nil,
            deltaCpOverGammaTc: Double? = nil,
            hc2T: Double? = nil,
            chiVolumetric: Double? = nil
        ) {
            self.peakJcAm2 = peakJcAm2
            self.fieldT = fieldT
            self.tempK = tempK
            self.tcK = tcK
            self.deltaCpOverGammaTc = deltaCpOverGammaTc
            self.hc2T = hc2T
            self.chiVolumetric = chiVolumetric
        }

        enum CodingKeys: String, CodingKey {
            case peakJcAm2 = "peak_jc_a_per_m2"
            case fieldT = "field_t"
            case tempK = "temp_k"
            case tcK = "tc_k"
            case deltaCpOverGammaTc = "delta_cp_over_gamma_tc"
            case hc2T = "hc2_t"
            case chiVolumetric = "chi_volumetric"
        }
    }

    public struct Provenance: Codable, Equatable, Sendable {
        public let sourceUrl: String
        public let sourceCitation: String
        public let vendorDatasheetUrl: String?

        enum CodingKeys: String, CodingKey {
            case sourceUrl = "source_url"
            case sourceCitation = "source_citation"
            case vendorDatasheetUrl = "vendor_datasheet_url"
        }
    }

    enum CodingKeys: String, CodingKey {
        case domain, verb, kind, stamp
        case sampleId = "sample_id"
        case testFamily = "test_family"
        case testCompound = "test_compound"
        case instrument
        case operator_ = "operator"
        case sampleProvenance = "sample_provenance"
        case rawDataHash = "raw_data_hash"
        case dataPoints = "data_points"
        case headline
        case measurementGate = "measurement_gate"
        case replicationCount = "replication_count"
        case absorbed
        case gateType = "gate_type"
        case provisional
        case provenance
        case scopeCaveats = "scope_caveats"
        case citations
    }
}
