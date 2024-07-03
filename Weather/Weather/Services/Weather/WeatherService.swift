//
//  WeatherService.swift
//  Weather
//
//  Created by Tarun Khurana on 2/21/24.
//

import Foundation

enum WeatherServiceError: Error {
    case urlError
    case jsonDecodingError
    case apiConnectionError
}

final class WeatherService: WeatherServiceProtocol {

    let urlFactory: WeatherURLFactoryProtocol

    init(urlFactory: WeatherURLFactoryProtocol) {
        self.urlFactory = urlFactory
    }

    func getWeather(_ lat: Double, lon: Double) async throws -> Weather {
        guard let url = await urlFactory.makeWeatherLatLonURL(lat, lon) else {
            throw WeatherServiceError.urlError
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let weather = try decoder.decode(Weather.self, from: data)
                return weather
            } catch {
                throw WeatherServiceError.jsonDecodingError
            }
        } catch {
            throw WeatherServiceError.apiConnectionError
        }
    }

    func getGeoCoding(_ text: String) async throws -> [GeoCoding] {
        guard let url = await urlFactory.makeWeatherGeoCodingURL(text) else {
            throw WeatherServiceError.urlError
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let geoCoding = try decoder.decode([GeoCoding].self, from: data)
                return geoCoding
            } catch {
                throw WeatherServiceError.jsonDecodingError
            }
        } catch {
            throw WeatherServiceError.apiConnectionError
        }
    }
}
