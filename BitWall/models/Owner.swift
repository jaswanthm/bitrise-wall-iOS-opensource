
// Owner.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let owner = try? newJSONDecoder().decode(Owner.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.ownerTask(with: url) { owner, response, error in
//     if let owner = owner {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Owner
struct Owner: Codable {
    let accountType, name, slug: String

    enum CodingKeys: String, CodingKey {
        case accountType = "account_type"
        case name, slug
    }
}

// Paging.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let paging = try? newJSONDecoder().decode(Paging.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.pagingTask(with: url) { paging, response, error in
//     if let paging = paging {
//       ...
//     }
//   }
//   task.resume()
