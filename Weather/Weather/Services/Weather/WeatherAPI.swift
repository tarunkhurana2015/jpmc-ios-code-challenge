//
//  WeatherServiceConstants.swift
//  Weather
//
//  Created by Tarun Khurana on 2/21/24.
//

import Foundation

enum WeatherAPI {
    static let baseURL = "https://api.openweathermap.org"
    static let basePath = "data/2.5/weather"
    static let searchQuery = "q="
    static let apiKey = "appid=7ecccecca3172a4a7653ed085a077655"
    static let latitude = "lat="
    static let longitude = "lon="
    static let units = "units=metric"
    static let geoCodingPath = "geo/1.0/direct"

    static let baseImageUrl = "https://openweathermap.org/img/wn"
}

// https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=7ecccecca3172a4a7653ed085a077655
// https://api.openweathermap.org/data/2.5/weather?q=Dallas&appid=7ecccecca3172a4a7653ed085a077655

// http://api.openweathermap.org/geo/1.0/direct?q={city name},{state code},{country code}&limit={limit}&appid={API key}
