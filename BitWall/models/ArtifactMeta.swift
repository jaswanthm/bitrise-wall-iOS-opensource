
// ArtifactMeta.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let artifactMeta = try? newJSONDecoder().decode(ArtifactMeta.self, from: jsonData)

import Foundation

// MARK: - ArtifactMeta
struct ArtifactMeta: Codable {
    let infoTypeID: String?
    let fileSizeBytes: String
    let module, productFlavour, buildType, include: String?
    let universal, aab, apk, split: String?
    let appInfo: AppInfo

    enum CodingKeys: String, CodingKey {
        case infoTypeID = "info_type_id"
        case fileSizeBytes = "file_size_bytes"
        case module
        case productFlavour = "product_flavour"
        case buildType = "build_type"
        case include, universal, aab, apk, split
        case appInfo = "app_info"
    }
}
