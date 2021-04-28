// DataClass.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let dataClass = try? newJSONDecoder().decode(DataClass.self, from: jsonData)

import Foundation

// MARK: - DataClass
struct DataClass: Codable {
    let title, artifactType: String
    let expiringDownloadURL: String
    let isPublicPageEnabled: Bool
    let slug: String
    let publicInstallPageURL: String
    let fileSizeBytes: Int

    enum CodingKeys: String, CodingKey {
        case title
        case artifactType = "artifact_type"
        case expiringDownloadURL = "expiring_download_url"
        case isPublicPageEnabled = "is_public_page_enabled"
        case slug
        case publicInstallPageURL = "public_install_page_url"
        case fileSizeBytes = "file_size_bytes"
    }
}
