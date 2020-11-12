//
//  DetailsViewModel.swift
//  EUCities
//
//  Created by Aleksander Popek on 10/11/2020.
//

import Foundation

enum CellType {
    case cityCellType
    case detailsCellType
}

class DetailsViewModel {
    
    private let apiClient:APIClientProtocol
    private let favoritesManager:FavoritesManager
    
    private var city:City
    
    var details:CityDetails?
    var info:CityInfo?

    var cells:[CellType] {
        guard info != nil else { return [.cityCellType] }
        return [.cityCellType, .detailsCellType, .detailsCellType, .detailsCellType]
    }

    var error: APIError? {
        didSet {
            /// TODO: present error message
        }
    }
    
    var numberOfRows:Int {
        return cells.count
    }

    var name:String {
        return city.name
    }
    
    var mainPhotoKey:String {
        return city.photoKey
    }
    
    init(city:City, apiClient:APIClientProtocol = APIClient(), favoritesManager:FavoritesManager = FavoritesManager()) {
        self.city = city
        self.apiClient = apiClient
        self.favoritesManager = favoritesManager
    }
    
    func cellType(forIndexPath indexPath:IndexPath) -> CellType {
        return cells[indexPath.row]
    }
    
    func configureCityCell(_ cell: CityTableViewCell, atIndex index:Int) {
        cell.mainImageView.loadImage(withKey: city.photoKey)
        cell.cityLabel.text = city.name.uppercased()
        cell.countryLabel.text = city.country
        cell.isFavorite = city.isFavorite
    }
    
    func configureDetailsCell(_ cell: DetailsTableViewCell, atIndex index:Int) {
        if let details = details {
            switch index {
            case 1:
                cell.leftLabel.text = Strings.area
                cell.rightLabel.text = details.area
            case 2:
                cell.leftLabel.text = Strings.population
                cell.rightLabel.text = details.population
            default:
                cell.leftLabel.text = Strings.timeZone
                cell.rightLabel.text = details.timeZone
            }
        }
    }

    func toggleFavorite(atIndex index:Int) {
        /// Update local storage
        favoritesManager.toggleFavorite(city.identifier)
    }
}

// MARK: - API calls

extension DetailsViewModel {
    
    func loadAllData(_ completion:@escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        loadDetails {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        loadMoreInfo {
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    func loadDetails(_ completion:@escaping () -> Void) {
        apiClient.request(
            target: .getDetails,
            type: CityDetails.self
        ) { [weak self] (result) in
            switch result {
            case .success(let details):
                self?.details = details
            case .failure(let error):
                self?.error = error
            }
            completion()
        }
    }

    func loadMoreInfo(_ completion:@escaping () -> Void) {
        apiClient.request(
            target: .getMoreInfo,
            type: CityInfo.self
        ) { [weak self] (result) in
            switch result {
            case .success(let info):
                self?.info = info
            case .failure(let error):
                self?.error = error
            }
            completion()
        }
    }
}
