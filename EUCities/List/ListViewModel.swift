//
//  ListViewModel.swift
//  EUCities
//
//  Created by Aleksander Popek on 10/11/2020.
//

import Foundation

class ListViewModel {
    
    private let apiClient:APIClientProtocol
    private let favoritesManager:FavoritesManagerProtocol
    
    var items:Cities = [] {
        didSet {
            for (index, city) in items.enumerated() {
                if favoritesManager.favorites.contains(city.identifier) {
                    items[index].isFavorite = true
                }
            }
        }
    }
    
    var showFavorites:Bool = false
    
    var error: APIError? {
        didSet {
            /// TODO: present error message
        }
    }

    var numberOfRows:Int {
        if showFavorites {
            return items.filter({ $0.isFavorite }).count
        }
        return items.count
    }
    
    init(apiClient:APIClientProtocol = APIClient(), favoritesManager:FavoritesManagerProtocol = FavoritesManager()) {
        self.apiClient = apiClient
        self.favoritesManager = favoritesManager
    }
    
    func item(atIndex index:Int) -> City? {
        if showFavorites {
            return items.filter({ $0.isFavorite })[safe: index]
        }
        return items[safe: index]
    }

    func configure(_ cell: CityTableViewCell, atIndex index:Int) {
        if let city = item(atIndex: index) {
            cell.mainImageView.loadImage(withKey: city.photoKey)
            cell.cityLabel.text = city.name.uppercased()
            cell.countryLabel.text = city.country
            cell.isFavorite = city.isFavorite
        }
    }
    
    func toggleFavorite(atIndex index:Int) {
        if let city = item(atIndex: index) {
            /// Update local storage
            favoritesManager.toggleFavorite(city.identifier)
            
            var updatedCity = city
            updatedCity.isFavorite = !updatedCity.isFavorite
            if let updatedItemIndex = items.firstIndex(where: { $0.identifier == city.identifier }) {
                items[updatedItemIndex] = updatedCity
            }
        }
    }
}

// MARK: - API calls

extension ListViewModel {
    func loadCities(_ completion:@escaping () -> Void) {
        apiClient.request(
            target: .getCities,
            type: [City].self
        ) { [weak self] (result) in
            switch result {
            case .success(let items):
                self?.items = items
                
            case .failure(let error):
                self?.error = error
            }
            completion()
        }
    }
}
