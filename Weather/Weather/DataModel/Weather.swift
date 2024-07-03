//
//  Weather.swift
//  Weather
//
//  Created by Tarun Khurana on 2/21/24.
//

import Foundation

struct Weather: Decodable {
    let id: Int
    let name: String
    let timezone: Int
    let coordinate: Coordinate
    let weather: [WeatherArray]
    let main: WeatherMain
    let wind: WeatherWind
    let clouds: WeatherClouds

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case timezone
        case coordinate = "coord"
        case weather
        case main
        case wind
        case clouds
    }
}

struct Coordinate: Codable {
    let lat: Double
    let lon: Double
}

struct WeatherArray: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherMain: Decodable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Double
    let humidity: Double
}
struct WeatherWind: Decodable {
    let speed: Double
    let deg: Double
}
struct WeatherClouds: Decodable {
    let all: Double
}
