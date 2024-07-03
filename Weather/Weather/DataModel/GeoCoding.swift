//
//  GeoCoding.swift
//  Weather
//
//  Created by Tarun Khurana on 2/21/24.
//

import Foundation

struct GeoCoding: Decodable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String
}
