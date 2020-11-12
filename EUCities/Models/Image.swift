//
//  Image.swift
//  EUCities
//
//  Created by Aleksander Popek on 10/11/2020.
//

import UIKit

struct Image: Codable {
    let imageData: Data
    
    var image: UIImage {
        return UIImage(data: imageData) ?? UIImage()
    }
}
