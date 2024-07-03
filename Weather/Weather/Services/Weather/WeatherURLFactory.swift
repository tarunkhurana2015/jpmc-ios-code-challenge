//
//  WeatherURLFactory.swift
//  Weather
//
//  Created by Tarun Khurana on 2/21/24.
//

import Foundation

final class WeatherURLFactory: WeatherURLFactoryProtocol {
    func makeWeatherLatLonURL(_ lat: Double, _ lon: Double) async -> URL? {
        let base = WeatherAPI.baseURL + "/" + WeatherAPI.basePath
        let query = "?" + "\(WeatherAPI.latitude)\(lat)" + "&" + "\(WeatherAPI.longitude)\(lon)" + "&" + WeatherAPI.apiKey +  "&" + WeatherAPI.units
        return URL(string: base + query)
    }
    
    func makeWeatherCityURL() async -> URL? {
        URL(string: WeatherAPI.baseURL)
    }
    
    func makeWeatherGeoCodingURL(_ text: String) async -> URL? {
        let base = WeatherAPI.baseURL + "/" + WeatherAPI.geoCodingPath
        let query = "?" + WeatherAPI.searchQuery +  text + "&" + WeatherAPI.apiKey
        return URL(string: base + query)
    }

}
// http://api.openweathermap.org/geo/1.0/direct?q={city name},{state code},{country code}&limit={limit}&appid={API key}
// https://api.openweathermap.org/geo/1.0/direct?q=Dallas&appid=7ecccecca3172a4a7653ed085a077655
