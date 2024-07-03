//
//  WeatherURLFactoryTests.swift
//  WeatherTests
//
//  Created by Tarun Khurana on 2/21/24.
//

import XCTest
@testable import Weather

final class WeatherURLFactoryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_WeatherURLFactory_makeWeatherLatLonURLShouldMatch() async {
        // Given
        let lat = 32.7762719
        let lon = -96.7968559
        let urlString = WeatherAPI.baseURL + "/" + WeatherAPI.basePath + "?" + "\(WeatherAPI.latitude)\(lat)" + "&" + "\(WeatherAPI.longitude)\(lon)" + "&" + WeatherAPI.apiKey + "&" + "\(WeatherAPI.units)"
        let weatherFactory = WeatherURLFactory()

        // When
        let url = await weatherFactory.makeWeatherLatLonURL(lat, lon)

        // Then
        XCTAssertEqual(url?.absoluteString, urlString)
    }

    func test_WeatherURLFactory_makeWeatherLatLonURLDoesNotMatch() async {
        // Given
        let lat = 32.7762719
        let lon = -96.7968559
        let urlString = WeatherAPI.baseURL + "/" + WeatherAPI.basePath + "?" + "\(WeatherAPI.latitude)\(lat)" + "" + "\(WeatherAPI.longitude)\(lon)" + "&" + WeatherAPI.apiKey
        let weatherFactory = WeatherURLFactory()

        // When
        let url = await weatherFactory.makeWeatherLatLonURL(lat, lon)

        // Then
        XCTAssertNotEqual(url?.absoluteString, urlString)
    }
}
