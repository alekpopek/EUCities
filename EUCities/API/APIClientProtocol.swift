//
//  APIClientProtocol.swift
//  EUCities
//
//  Created by Aleksander Popek on 11/11/2020.
//

import Foundation

protocol APIClientProtocol {
    func request<T:Decodable>(target: APIService, type: T.Type, completion: @escaping (Result<T>) -> Void)
}
