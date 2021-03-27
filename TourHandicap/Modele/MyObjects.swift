// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let nhits: Int
    let parameters: Parameters
    let records: [RecordBis]
    let facetGroups: [FacetGroup]

    enum CodingKeys: String, CodingKey {
        case nhits, parameters, records
        case facetGroups = "facet_groups"
    }
}

// MARK: - FacetGroup
struct FacetGroup: Codable {
    let facets: [Facet]
    let name: String
}

// MARK: - Facet
struct Facet: Codable {
    let count: Int
    let path, state, name: String
}

// MARK: - Parameters
struct Parameters: Codable {
    let dataset: String
    let refine: Refine
    let timezone: String
    let rows, start: Int
    let format: String
}

// MARK: - Refine
struct Refine: Codable {
    let handicapAuditif: String

    enum CodingKeys: String, CodingKey {
        case handicapAuditif = "handicap_auditif"
    }
}

// MARK: - Record
struct RecordBis: Codable {
    let datasetid, recordid: String
    let fields: FieldsBis
    let geometry: GeometryBis
    let recordTimestamp: String

    enum CodingKeys: String, CodingKey {
        case datasetid, recordid, fields, geometry
        case recordTimestamp = "record_timestamp"
    }
}

// MARK: - Fields
struct FieldsBis: Codable {
    let departement, ville, reseau, activit: String
    let siteweb: String
    let handicapVisuel, region, etablissement, adresse: String
    let telephone, handicapAuditif, handicapMoteur: String
    let codepostal: Int
    let handicaps: String
    let geo: [Double]
    let reference, handicapMental: String
    let fax: String?

    enum CodingKeys: String, CodingKey {
        case departement, ville, reseau, activit, siteweb
        case handicapVisuel = "handicap_visuel"
        case region, etablissement, adresse, telephone
        case handicapAuditif = "handicap_auditif"
        case handicapMoteur = "handicap_moteur"
        case codepostal, handicaps, geo, reference
        case handicapMental = "handicap_mental"
        case fax
    }
}

// MARK: - Geometry
struct GeometryBis: Codable {
    let type: String
    let coordinates: [Double]
}
