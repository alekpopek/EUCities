//
//  City.swift
//  EUCities
//
//  Created by Aleksander Popek on 10/11/2020.
//

import Foundation

typealias Cities = [City]

struct City: Codable {
    let identifier:Int
    let name:String
    let country:String
    let photoKey:String
    
    var isFavorite:Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name = "city"
        case country = "country"
        case photoKey = "photo"
    }
}
