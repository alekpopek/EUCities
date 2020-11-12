//
//  DetailsViewModelTests.swift
//  EUCitiesTests
//
//  Created by Aleksander Popek on 11/11/2020.
//

import XCTest
@testable import EUCities

class DetailsViewModelTests: XCTestCase {

    var sut:DetailsViewModel!
    var mockedAPIClient:MockedAPIClient<CityDetails>!
    
    override func setUp() {
        super.setUp()

        let city = City(identifier: 0, name: "Test", country: "Test", photoKey: "noKey")
        
        mockedAPIClient = MockedAPIClient()
        sut = DetailsViewModel(city: city, apiClient: mockedAPIClient)
    }
    
    override func tearDown() {
        mockedAPIClient = nil
        sut = nil

        super.tearDown()
    }
    
    func testLoadDetailsSuccess() {
        /// Given
        mockedAPIClient.data = CityDetails(population: "100", timeZone: "UTC", area: "500")

        /// When
        let expectation = XCTestExpectation(description: "load details")
        sut.loadDetails {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
        /// Then
        XCTAssertNotNil(sut.details)
        XCTAssertEqual("100", sut.details?.population)
        XCTAssertEqual("UTC", sut.details?.timeZone)
        XCTAssertEqual("500", sut.details?.area)
    }
    
    func testLoadDetailsFailure() {
        /// Given
        mockedAPIClient.forcedError = .noDataError

        /// When
        let expectation = XCTestExpectation(description: "api error")
        sut.loadDetails {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
        /// Then
        XCTAssertNil(sut.details)
        XCTAssertEqual(sut.error, .noDataError)
    }


}
