//
//  AppConfiguration.swift
//  EUCities
//
//  Created by Aleksander Popek on 10/11/2020.
//

import Foundation
 
class Config {
    
    /// Returns API Url string
    static var APIBaseUrl:String {
        return "https://run.mocky.io/v3/"
    }

    /// Returns Unsplash service API Url string for fetching images
    static var ImagesBaseUrl:String {
        return "https://source.unsplash.com/"
    }
}
