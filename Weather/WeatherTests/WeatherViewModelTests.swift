//
//  WeatherViewModelTests.swift
//  WeatherTests
//
//  Created by Tarun Khurana on 2/21/24.
//

import XCTest
@testable import Weather

final class WeatherViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Integration_WeatherModel_fetchWeatherSuccess() async throws {

        // Given
        let city = "Dallas"
        let lat = 32.7762719
        let lon = -96.7968559

        // When
        let viewmodel = WeatherViewModel(weatherService: WeatherService(urlFactory: WeatherURLFactory()))
        try await viewmodel.fetchWeather(lat, lon: lon)

        // Then
        XCTAssertEqual(viewmodel.weather?.name, city)
        XCTAssertEqual(viewmodel.weather!.coordinate.lat, lat, accuracy: 0.01)
        XCTAssertEqual(viewmodel.weather!.coordinate.lon, lon, accuracy: 0.01)
    }

    func test_Integration_WeatherModel_fetchWeatherForSearchSuccess() async throws {

        // Given
        let city = "Dallas"
        let lat = 32.7762719
        let lon = -96.7968559

        // When
        let viewmodel = WeatherViewModel(weatherService: WeatherService(urlFactory: WeatherURLFactory()))
        viewmodel.searchText = city
        try await viewmodel.fetchWeatherForSearch()

        // Then
        XCTAssertEqual(viewmodel.weather?.name, city)
        XCTAssertEqual(viewmodel.weather!.coordinate.lat, lat, accuracy: 0.01)
        XCTAssertEqual(viewmodel.weather!.coordinate.lon, lon, accuracy: 0.01)
    }

}
