//
//  AppStyles.swift
//  EUCities
//
//  Created by Aleksander Popek on 10/11/2020.
//

import UIKit

class Style {
    static let colorWhite = UIColor.white

    static let colorPrimary = UIColor(red: 239/255, green: 0/255, blue: 0/255, alpha: 1.0)
    
    static let color40 = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1.0)
    static let color140 = UIColor(red: 140/255, green: 140/255, blue: 140/255, alpha: 1.0)
    static let colorSeparator = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
    
    static func fontRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Lato-Regular", size: size)!
    }
}
