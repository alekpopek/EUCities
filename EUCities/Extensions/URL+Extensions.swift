//
//  URL+Extensions.swift
//  EUCities
//
//  Created by Aleksander Popek on 10/11/2020.
//

import Foundation

extension URL {
    /// Initialize URL from `APIProtocol`.
    init<T: APIServiceProtocol>(target: T) {
        if target.path.isEmpty {
            guard let url = URL(string: target.baseURL) else {
                fatalError("You didn't set baseURL properly")
            }
            self = url

        } else {
            guard let url = URL(string: target.baseURL + target.path) else {
                fatalError("You didn't set baseURL properly")
            }
            self = url
        }
    }
}


