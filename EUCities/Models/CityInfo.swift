//
//  CityInfo.swift
//  EUCities
//
//  Created by Aleksander Popek on 11/11/2020.
//

import Foundation

struct CityInfo: Codable {

    let about:String
    
    private enum CodingKeys: String, CodingKey {
        case about = "details"
    }
}
