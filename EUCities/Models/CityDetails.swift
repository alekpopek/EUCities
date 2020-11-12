//
//  CityDetails.swift
//  EUCities
//
//  Created by Aleksander Popek on 11/11/2020.
//

import Foundation

struct CityDetails: Codable {

    let population:String
    let timeZone:String
    let area:String
    
    private enum CodingKeys: String, CodingKey {
        case population = "population"
        case timeZone = "tz"
        case area = "area"
    }
}
