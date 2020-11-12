//
//  APIServiceProtocol.swift
//  EUCities
//
//  Created by Aleksander Popek on 10/11/2020.
//

import Foundation

/// The expected remote response type
enum ResponseType {
    case json
    case image
}

/// The protocol used to define the specifications necessary for a APIService.
protocol APIServiceProtocol {
    
    /// API baseURL.
    var baseURL: String { get }

    /// The path that will be appended to API's base URL.
    var path: String { get }

    /// The HTTP method.
    var method: String { get }

    /// The expected responseType.
    var responseType: ResponseType { get }
}
