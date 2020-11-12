//
//  UIView+Extensions.swift
//  EUCities
//
//  Created by Aleksander Popek on 10/11/2020.
//

import UIKit

extension UIView {
    func roundedCorners(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
