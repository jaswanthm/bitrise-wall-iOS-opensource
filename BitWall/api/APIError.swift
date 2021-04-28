//
//  APIError.swift
//  BitWall
//
//  Created by Jaswanth Manigundan on 4/5/20.
//  Copyright © 2020 Jaswanth Manigundan. All rights reserved.
//

import Foundation

    enum APIError: Error {
        case badResponse
        case badData
//        case statusCode(error: StatusCodeError)
        case invalidURL
    }
