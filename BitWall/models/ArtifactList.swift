// ArtifactList.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let artifactList = try? newJSONDecoder().decode(ArtifactList.self, from: jsonData)

import Foundation

// MARK: - ArtifactList
struct ArtifactList: Codable {
    let data: [Artifact]
    let paging: Paging
}
