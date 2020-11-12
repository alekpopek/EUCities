//
//  FavoritesManagerProtocol.swift
//  EUCities
//
//  Created by Aleksander Popek on 11/11/2020.
//

import Foundation

protocol FavoritesManagerProtocol {
    var favorites:[Int] { get }
    func toggleFavorite(_ identifier:Int)
}
