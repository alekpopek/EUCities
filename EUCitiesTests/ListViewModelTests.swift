//
//  ListViewModelTests.swift
//  EUCitiesTests
//
//  Created by Aleksander Popek on 10/11/2020.
//

import XCTest
@testable import EUCities

class ListViewModelTests: XCTestCase {

    var sut:ListViewModel!
    var mockedAPIClient:MockedAPIClient<Cities>!
    var mockedFavoritesManager:MockedFavoritesManager!
    
    override func setUp() {
        super.setUp()

        mockedAPIClient = MockedAPIClient()
        mockedFavoritesManager = MockedFavoritesManager()
        sut = ListViewModel(apiClient: mockedAPIClient, favoritesManager: mockedFavoritesManager)
    }
    
    override func tearDown() {
        mockedAPIClient = nil
        sut = nil

        super.tearDown()
    }
    
    func testToggleFavorite() {
        /// Given
        sut.items = [
            City(identifier: 0, name: "Warsaw", country: "Poland", photoKey: "noKey", isFavorite: false),
            City(identifier: 1, name: "Vienna", country: "Austria", photoKey: "noKey", isFavorite: false),
            City(identifier: 2, name: "Madrid", country: "Spain", photoKey: "noKey", isFavorite: true),
        ]
        mockedFavoritesManager.favorites = [2]
        
        /// When
        sut.toggleFavorite(atIndex: 1)
        sut.toggleFavorite(atIndex: 2)

        /// Then
        XCTAssertEqual(1, mockedFavoritesManager.favorites.count)
        XCTAssertFalse(sut.items[0].isFavorite)
        XCTAssertTrue(sut.items[1].isFavorite)
        XCTAssertFalse(sut.items[2].isFavorite)
    }
    
    func testLoadCitiesSuccess() {
        /// Given
        mockedAPIClient.data = [
            City(identifier: 0, name: "Warsaw", country: "Poland", photoKey: "noKey"),
            City(identifier: 1, name: "Vienna", country: "Austria", photoKey: "noKey"),
        ]

        /// When
        let expectation = XCTestExpectation(description: "load cities")
        sut.loadCities {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
        /// Then
        XCTAssertEqual(2, sut.items.count)
        XCTAssertEqual(0, sut.items[0].identifier)
        XCTAssertEqual(1, sut.items[1].identifier)
    }

    func testLoadCitiesFailure() {
        /// Given
        mockedAPIClient.forcedError = .noDataError

        /// When
        let expectation = XCTestExpectation(description: "api error")
        sut.loadCities {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
        /// Then
        XCTAssertTrue(sut.items.isEmpty)
        XCTAssertEqual(sut.error, .noDataError)
    }
    
    func testCityAtIndex() {
        /// Given
        sut.items = [
            City(identifier: 0, name: "Warsaw", country: "Poland", photoKey: "noKey"),
            City(identifier: 1, name: "Vienna", country: "Austria", photoKey: "noKey"),
        ]

        /// When
        let city = sut.item(atIndex: 1)
        
        /// Then
        XCTAssertNotNil(city)
        XCTAssertEqual(1, city?.identifier)
        XCTAssertEqual("Vienna", city?.name)
        XCTAssertEqual("Austria", city?.country)
    }
    
    func testCityAtIndexNil() {
        /// Given
        sut.items = [
            City(identifier: 0, name: "Warsaw", country: "Poland", photoKey: "noKey"),
            City(identifier: 1, name: "Vienna", country: "Austria", photoKey: "noKey"),
        ]

        /// When
        let city = sut.item(atIndex: 2)
        
        /// Then
        XCTAssertNil(city)
    }

    func testCellConfigure() {
        /// Given
        let cell = CityTableViewCell()
        sut.items = [
            City(identifier: 0, name: "Warsaw", country: "Poland", photoKey: "noKey"),
            City(identifier: 1, name: "Vienna", country: "Austria", photoKey: "noKey"),
        ]

        /// When
        sut.configure(cell, atIndex: 1)
        
        /// Then
        XCTAssertEqual("VIENNA", cell.cityLabel.text)
        XCTAssertEqual("Austria", cell.countryLabel.text)
    }
}
