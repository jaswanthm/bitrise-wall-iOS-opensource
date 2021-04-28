// Datum.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let datum = try? newJSONDecoder().decode(Datum.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.datumTask(with: url) { datum, response, error in
//     if let datum = datum {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Datum
struct Datum: Codable, Identifiable {
    let id = UUID()
    let slug, title, projectType, provider: String
    let repoOwner, repoURL, repoSlug: String
    let isDisabled: Bool
    let status: Int
    let isPublic: Bool
    let owner: Owner
    let avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case slug, title
        case projectType = "project_type"
        case provider
        case repoOwner = "repo_owner"
        case repoURL = "repo_url"
        case repoSlug = "repo_slug"
        case isDisabled = "is_disabled"
        case status
        case isPublic = "is_public"
        case owner
        case avatarURL = "avatar_url"
    }
}
