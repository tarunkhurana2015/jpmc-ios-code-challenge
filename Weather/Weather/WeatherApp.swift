//
//  WeatherApp.swift
//  Weather
//
//  Created by Tarun Khurana on 2/20/24.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView(viewModel: WeatherViewModel(weatherService: WeatherService(urlFactory: WeatherURLFactory())))
        }
    }
}
