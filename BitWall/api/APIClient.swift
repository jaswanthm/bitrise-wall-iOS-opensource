//
//  APIClient.swift
//  BitWall
//
//  Created by Jaswanth Manigundan on 4/5/20.
//  Copyright © 2020 Jaswanth Manigundan. All rights reserved.
//

// TODO: Not complete yet
import Foundation
import Combine

struct APIClient {

    struct Response<T> { // 1
        let value: T
        let response: URLResponse
    }
    
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> { // 2
        return URLSession.shared
            .dataTaskPublisher(for: request) // 3
            .tryMap { result -> Response<T> in
                let value = try JSONDecoder().decode(T.self, from: result.data) // 4
                return Response(value: value, response: result.response) // 5
            }
            .receive(on: DispatchQueue.main) // 6
            .eraseToAnyPublisher() // 7
    }
    
    public func tryMapApiErrors(_ output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse else {
            throw APIError.badResponse
        }
        // FIXME: Need to confirm this is the only Success Status Code we should expect.
        guard response.statusCode == 200 else {
            throw APIError.badData
            //throw APIError.statusCode(error: StatusCodeError(statusCode: response.statusCode, data: output.data))
        }
        guard !output.data.isEmpty else {
            throw APIError.badData
        }
        return output.data
    }
}
