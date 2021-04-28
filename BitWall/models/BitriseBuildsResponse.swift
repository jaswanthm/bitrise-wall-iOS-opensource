// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let bitriseBuildsResponse = try? newJSONDecoder().decode(BitriseBuildsResponse.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.bitriseBuildsResponseTask(with: url) { bitriseBuildsResponse, response, error in
//     if let bitriseBuildsResponse = bitriseBuildsResponse {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - BitriseBuildsResponse
struct BitriseBuildsResponse: Codable {
    let data: [BitriseBuild]
    let paging: Paging
}
