//
//  BitriseBuildLogResponse.swift
//  BitWall
//
//  Created by Jaswanth Manigundan on 5/8/20.
//  Copyright © 2020 jaswanth.xyz. All rights reserved.
//

import Foundation

// MARK: - BitriseBuildLogResponse
struct BitriseBuildLogResponse:  Codable, Identifiable  {
    let id = UUID()
    let expiringRawLogURL: String
    let generatedLogChunksNum: Int
    let isArchived: Bool
    let logChunks: [LogChunk]
    

    enum CodingKeys: String, CodingKey {
        case expiringRawLogURL = "expiring_raw_log_url"
        case generatedLogChunksNum = "generated_log_chunks_num"
        case isArchived = "is_archived"
        case logChunks = "log_chunks"
    }
}
