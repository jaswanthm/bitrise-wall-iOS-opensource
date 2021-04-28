
import Foundation

// MARK: - Paging
struct Paging: Codable {
    let totalItemCount, pageItemLimit: Int
    let next : String?

    enum CodingKeys: String, CodingKey {
        case totalItemCount = "total_item_count"
        case pageItemLimit = "page_item_limit"
        case next
    }
}
