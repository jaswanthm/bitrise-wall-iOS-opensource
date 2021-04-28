// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let Build = try? newJSONDecoder().decode(Build.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.BuildTask(with: url) { Build, response, error in
//     if let Build = Build {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Build
struct BitriseBuild: Codable, Identifiable,Equatable {
    static func == (lhs: BitriseBuild, rhs: BitriseBuild) -> Bool {
        return lhs.buildNumber == rhs.buildNumber && lhs.slug == rhs.slug
    }
    
    let id = UUID()
    let triggeredAt, startedOnWorkerAt, environmentPrepareFinishedAt, finishedAt: Date?
    let slug: String
    let status: Int
    let statusText: String
    let abortReason: String?
    let isOnHold: Bool
    let branch: String
    let buildNumber: Int
    let commitHash, commitMessage: String?
    let tag: String?
    let triggeredWorkflow: String
    let triggeredBy: String
    let machineTypeID: String
    let stackIdentifier: String
    let originalBuildParams: OriginalBuildParams
    let pullRequestID: Int
    let pullRequestTargetBranch, pullRequestViewURL: String?
    let commitViewURL: String?

    enum CodingKeys: String, CodingKey {
        case triggeredAt = "triggered_at"
        case startedOnWorkerAt = "started_on_worker_at"
        case environmentPrepareFinishedAt = "environment_prepare_finished_at"
        case finishedAt = "finished_at"
        case slug, status
        case statusText = "status_text"
        case abortReason = "abort_reason"
        case isOnHold = "is_on_hold"
        case branch = "branch"
        case buildNumber = "build_number"
        case commitHash = "commit_hash"
        case commitMessage = "commit_message"
        case tag
        case triggeredWorkflow = "triggered_workflow"
        case triggeredBy = "triggered_by"
        case machineTypeID = "machine_type_id"
        case stackIdentifier = "stack_identifier"
        case originalBuildParams = "original_build_params"
        case pullRequestID = "pull_request_id"
        case pullRequestTargetBranch = "pull_request_target_branch"
        case pullRequestViewURL = "pull_request_view_url"
        case commitViewURL = "commit_view_url"
    }
}
