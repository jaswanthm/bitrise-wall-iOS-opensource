// BuildLog.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let buildLog = try? newJSONDecoder().decode(BuildLog.self, from: jsonData)

import Foundation

// MARK: - BuildLog
struct BuildLog: Codable {
    let expiringRawLogURL: String
    let generatedLogChunksNum: Int
    let isArchived: Bool
    let logChunks: [LogChunk]
    let timestamp: String?

    enum CodingKeys: String, CodingKey {
        case expiringRawLogURL = "expiring_raw_log_url"
        case generatedLogChunksNum = "generated_log_chunks_num"
        case isArchived = "is_archived"
        case logChunks = "log_chunks"
        case timestamp
    }
}
