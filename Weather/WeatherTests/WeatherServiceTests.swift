//
//  WeatherServiceTests.swift
//  WeatherTests
//
//  Created by Tarun Khurana on 2/21/24.
//

import XCTest
@testable import Weather

final class WeatherServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Integration_WeatherService_fetchWeatherLatLonSuccess() async {
        // Given
        let lat = 32.7762719
        let lon = -96.7968559
        let weatherFactory = WeatherURLFactory()
        let weatherService = WeatherService(urlFactory: weatherFactory)
        let expectation = XCTestExpectation(description: #function)

        // When
        do {
            let weather = try await weatherService.getWeather(lat, lon: lon)
            expectation.fulfill()
            XCTAssertEqual(weather.coordinate.lat, lat, accuracy: 0.01)
            XCTAssertEqual(weather.coordinate.lon, lon, accuracy: 0.01)
        } catch {

        }

        wait(for: [expectation], timeout: 5)
    }

    func test_WeatherService_fetchWeatherLatLonError() async {
        // Given
        let lat = 32.7762719
        let lon = -96.7968559
        let weatherFactory = MockWeatherURLFactory()
        let weatherService = WeatherService(urlFactory: weatherFactory)
        let expectation = XCTestExpectation(description: #function)

        // When
        do {
            _ = try await weatherService.getWeather(lat, lon: lon)
        } catch {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

    func test_Integration_WeatherService_getGeoCodingSuccess() async {
        // Given
        let city = "Dallas"
        let lat = 32.7762719
        let lon = -96.7968559
        let weatherFactory = WeatherURLFactory()
        let weatherService = WeatherService(urlFactory: weatherFactory)
        let expectation = XCTestExpectation(description: #function)

        // When
        do {
            let geoCoding = try await weatherService.getGeoCoding(city)
            expectation.fulfill()
            XCTAssertEqual(geoCoding.first?.name, city)
            XCTAssertEqual(geoCoding.first?.lat, lat)
            XCTAssertEqual(geoCoding.first?.lon, lon)
        } catch {

        }

        wait(for: [expectation], timeout: 5)
    }

}
