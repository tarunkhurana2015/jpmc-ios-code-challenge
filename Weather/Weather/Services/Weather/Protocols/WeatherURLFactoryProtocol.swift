//
//  WeatherURL.swift
//  Weather
//
//  Created by Tarun Khurana on 2/21/24.
//

import Foundation

protocol WeatherURLFactoryProtocol {
    /// Generates a complete URL for fetching the weather.
    /// - returns: Optional URL for service request.
    func makeWeatherLatLonURL(_ lat: Double, _ lon: Double) async -> URL?
    func makeWeatherGeoCodingURL(_ text: String) async -> URL?
}
