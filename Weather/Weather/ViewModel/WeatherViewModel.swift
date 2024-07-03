//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Tarun Khurana on 2/20/24.
//

import Foundation

@Observable
final class WeatherViewModel {
    
    let weatherService: WeatherService

    var weather: Weather?
    var searchText = ""
    
    init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
}

extension WeatherViewModel {

    func fetchWeather(_ lat: Double, lon: Double) async throws {
        weather = try await weatherService.getWeather(lat, lon: lon)
        LocationStorage.storeLocation(coordinate: Coordinate(lat: lat, lon: lon))
    }

    func fetchWeatherForSearch() async throws {
        let geoCodings = try await weatherService.getGeoCoding(searchText)
        let lat = geoCodings.first?.lat ?? 0.0
        let lon = geoCodings.first?.lon ?? 0.0
        weather = try await weatherService.getWeather(lat, lon: lon)
        LocationStorage.storeLocation(coordinate: Coordinate(lat: lat, lon: lon))
    }
}
