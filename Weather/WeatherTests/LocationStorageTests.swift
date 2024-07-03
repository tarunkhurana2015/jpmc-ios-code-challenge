//
//  LocationStorageTests.swift
//  WeatherTests
//
//  Created by Tarun Khurana on 2/22/24.
//

import XCTest
@testable import Weather

final class LocationStorageTests: XCTestCase {

    override func setUpWithError() throws {
        LocationStorage.clearStorage()
    }

    override func tearDownWithError() throws {

    }

    func test_LocalStorage_storeLocationStoreSuccess() throws {
        // Given
        let coordinate = Coordinate(lat: 32.7762719, lon: -96.7968559)

        // When
        LocationStorage.storeLocation(coordinate: coordinate)


        // Then
        let newCordinate = LocationStorage.getLocation()
        XCTAssertEqual(newCordinate?.lat, coordinate.lat)
        XCTAssertEqual(newCordinate?.lon, coordinate.lon)
    }

    func test_LocalStorage_storeLocationGetSuccess() throws {
        // Given
        let coordinate = Coordinate(lat: 32.7762719, lon: -96.7968559)

        // When


        // Then
        let newCordinate = LocationStorage.getLocation()
        XCTAssertNotEqual(newCordinate?.lat, coordinate.lat)
        XCTAssertNotEqual(newCordinate?.lon, coordinate.lon)
    }

    func test_LocalStorage_storeLocationCleanSuccess() throws {
        // Given
        let coordinate = Coordinate(lat: 32.7762719, lon: -96.7968559)

        // When
        LocationStorage.storeLocation(coordinate: coordinate)
        LocationStorage.clearStorage()

        // Then
        let newCordinate = LocationStorage.getLocation()
        XCTAssertNotEqual(newCordinate?.lat, coordinate.lat)
        XCTAssertNotEqual(newCordinate?.lon, coordinate.lon)
    }

}
