//
//  MockedAPIClient.swift
//  EUCitiesTests
//
//  Created by Aleksander Popek on 11/11/2020.
//

import Foundation
@testable import EUCities

class MockedAPIClient<T:Decodable>: APIClientProtocol {
    
    var forcedError:APIError?
    var data:T? = nil

    func request<T>(target: APIService, type: T.Type, completion: @escaping (Result<T>) -> Void) {
        if let error = forcedError {
            completion(.failure(error))
        } else {
            completion(.success(data as! T))
        }
    }
}
