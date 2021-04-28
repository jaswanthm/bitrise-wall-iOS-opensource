// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let commitPath = try? newJSONDecoder().decode(CommitPath.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.commitPathTask(with: url) { commitPath, response, error in
//     if let commitPath = commitPath {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - CommitPath
struct CommitPath: Codable {
    let added: [String]
    let removed: [String]
    let modified: [String]
}
