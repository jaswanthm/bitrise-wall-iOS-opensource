// BitriseAppListResponse.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let bitriseAppListResponse = try? newJSONDecoder().decode(BitriseAppListResponse.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.bitriseAppListResponseTask(with: url) { bitriseAppListResponse, response, error in
//     if let bitriseAppListResponse = bitriseAppListResponse {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - BitriseAppListResponse
struct BitriseAppListResponse: Codable {
    let data: [Datum]
    let paging: Paging
}
