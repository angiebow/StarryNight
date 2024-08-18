//
//  CmeModel.swift
//  StarryNight
//
//  Created by Pelangi Masita Wati on 17/08/24.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct IdentifiableErrorCme: Identifiable {
    var id = UUID()
    var message: String
}

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let activityID, catalog, startTime: String
    let instruments: [Instrument]
    let sourceLocation: String
    let activeRegionNum: JSONNull?
    let note, submissionTime: String
    let versionID: Int
    let link: String
    let cmeAnalyses: [CmeAnalysis]
    let linkedEvents: JSONNull?

    enum CodingKeys: String, CodingKey {
        case activityID, catalog, startTime, instruments, sourceLocation, activeRegionNum, note, submissionTime
        case versionID = "versionId"
        case link, cmeAnalyses, linkedEvents
    }
}

// MARK: - CmeAnalysis
struct CmeAnalysis: Codable {
    let isMostAccurate: Bool
    let time215: String
    let latitude, longitude, halfAngle, speed: Int
    let type, featureCode: String
    let imageType: JSONNull?
    let measurementTechnique, note: String
    let levelOfData: Int
    let tilt, minorHalfWidth, speedMeasuredAtHeight: JSONNull?
    let submissionTime: String
    let link: String
    let enlilList: [EnlilList]?

    enum CodingKeys: String, CodingKey {
        case isMostAccurate
        case time215 = "time21_5"
        case latitude, longitude, halfAngle, speed, type, featureCode, imageType, measurementTechnique, note, levelOfData, tilt, minorHalfWidth, speedMeasuredAtHeight, submissionTime, link, enlilList
    }
}

// MARK: - EnlilList
struct EnlilList: Codable {
    let modelCompletionTime: String
    let au: Int
    let estimatedShockArrivalTime, estimatedDuration, rminRe, kp18: JSONNull?
    let kp90, kp135, kp180: JSONNull?
    let isEarthGB: Bool
    let link: String
    let impactList: [ImpactList]
    let cmeIDs: [String]

    enum CodingKeys: String, CodingKey {
        case modelCompletionTime, au, estimatedShockArrivalTime, estimatedDuration
        case rminRe = "rmin_re"
        case kp18 = "kp_18"
        case kp90 = "kp_90"
        case kp135 = "kp_135"
        case kp180 = "kp_180"
        case isEarthGB, link, impactList, cmeIDs
    }
}

// MARK: - ImpactList
struct ImpactList: Codable {
    let isGlancingBlow: Bool
    let location, arrivalTime: String
}

// MARK: - Instrument
struct Instrument: Codable {
    let displayName: String
}

typealias WelcomeCme = [WelcomeElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}
