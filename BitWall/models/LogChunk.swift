// LogChunk.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let logChunk = try? newJSONDecoder().decode(LogChunk.self, from: jsonData)

import Foundation

// MARK: - LogChunk
struct LogChunk: Codable {
    let chunk: String
    let position: Int
}
