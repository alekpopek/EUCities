//
//  UIImageView+Extensions.swift
//  EUCities
//
//  Created by Aleksander Popek on 10/11/2020.
//

import UIKit

extension UIImageView {
    func loadImage(withKey key:String) {
        
        if let cachedImage = ImageCache.shared.image(forKey: key) {
            self.image = cachedImage
            return
        }
        
        APIClient().request(
            target: .getImage(
                key: key
            ),
            type: Image.self
        ) { [weak self] (result) in

            switch result {
            case .success(let image):
                self?.image = image.image
                
                ImageCache.shared.save(image: image.image, forKey: key)
                
            case .failure(_):
                /// FIXME: add placeholder image in case of error
                self?.image = UIImage()
            }
        }
    }
}
