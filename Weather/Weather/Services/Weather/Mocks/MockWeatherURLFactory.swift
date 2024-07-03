//
//  MockWeatherURLFactory.swift
//  Weather
//
//  Created by Tarun Khurana on 2/21/24.
//

import Foundation

final class MockWeatherURLFactory: WeatherURLFactoryProtocol {
    func makeWeatherLatLonURL(_ lat: Double, _ lon: Double) async -> URL? {
        nil
    }

    func makeWeatherCityURL() async -> URL? {
        nil
    }

    func makeWeatherGeoCodingURL(_ text: String) async -> URL? {
        nil
    }

}
