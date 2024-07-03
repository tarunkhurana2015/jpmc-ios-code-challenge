//
//  WeatherServiceProtocol.swift
//  Weather
//
//  Created by Tarun Khurana on 2/21/24.
//

import Foundation

protocol WeatherServiceProtocol {
    func getWeather(_ lat: Double, lon: Double) async throws -> Weather
    func getGeoCoding(_ text: String) async throws -> [GeoCoding]
}
