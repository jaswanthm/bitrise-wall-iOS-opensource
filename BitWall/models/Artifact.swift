
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let datum = try? newJSONDecoder().decode(Datum.self, from: jsonData)

import Foundation

// MARK: - Datum
struct Artifact: Codable, Identifiable {
    let id = UUID()
    let title: String
    let artifactType: String?
    let isPublicPageEnabled: Bool
    let slug: String
    let fileSizeBytes: Int

    enum CodingKeys: String, CodingKey {
        case title
        case artifactType = "artifact_type"
        case isPublicPageEnabled = "is_public_page_enabled"
        case slug
        case fileSizeBytes = "file_size_bytes"
    }
}
