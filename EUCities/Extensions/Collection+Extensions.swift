//
//  Collection+Extensions.swift
//  EUCities
//
//  Created by Aleksander Popek on 11/11/2020.
//

import Foundation

extension Collection {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
