//
//  LocationStorage.swift
//  Weather
//
//  Created by Tarun Khurana on 2/22/24.
//

import Foundation
import CoreLocation


enum LocationStorage {

    static func storeLocation(coordinate: Coordinate) {
        if let encoded = try? JSONEncoder().encode(coordinate) {
            UserDefaults.standard.set(encoded, forKey: "location")
        }
    }

    static func getLocation() -> Coordinate? {
        if let data = UserDefaults.standard.object(forKey: "location") as? Data,
           let coordinate = try? JSONDecoder().decode(Coordinate.self, from: data) {
            return coordinate
        }
        return nil
    }

    static func clearStorage() {
        UserDefaults.standard.removeObject(forKey: "location")
    }
}
