// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let originalBuildParams = try? newJSONDecoder().decode(OriginalBuildParams.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.originalBuildParamsTask(with: url) { originalBuildParams, response, error in
//     if let originalBuildParams = originalBuildParams {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - OriginalBuildParams
struct OriginalBuildParams: Codable {
    let commitHash, commitMessage: String?
    let branch: String
    let diffURL: String?
    let commitPaths: [CommitPath]?
    let workflowID: String?

    enum CodingKeys: String, CodingKey {
        case commitHash = "commit_hash"
        case commitMessage = "commit_message"
        case branch = "branch"
        case diffURL = "diff_url"
        case commitPaths = "commit_paths"
        case workflowID = "workflow_id"
    }
}
