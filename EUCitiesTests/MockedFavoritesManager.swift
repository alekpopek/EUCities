//
//  MockedFavoritesManager.swift
//  EUCitiesTests
//
//  Created by Aleksander Popek on 11/11/2020.
//

import Foundation
@testable import EUCities

class MockedFavoritesManager: FavoritesManagerProtocol {

    var favorites:[Int] = []
    
    func toggleFavorite(_ identifier:Int) {
        if favorites.contains(identifier) {
            if let index = favorites.firstIndex(of: identifier) {
                favorites.remove(at: index)
            }
        } else {
            favorites.append(identifier)
        }
    }
}
