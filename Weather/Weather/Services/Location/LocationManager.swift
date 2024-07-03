//
//  LocationService.swift
//  Weather
//
//  Created by Tarun Khurana on 2/20/24.
//

import Foundation
import CoreLocation

@Observable
final class LocationManager: NSObject, ObservableObject {

    private let locaionManager = CLLocationManager()
    var isAuthorized: Bool = false
    var isError: Bool = false
    private var continuation: CheckedContinuation<CLLocation, Error>?

    override init() {
        super.init()
        locaionManager.delegate = self
    }

    var currentLocation: CLLocation {
        get async throws {
            return try await withCheckedThrowingContinuation { contiuation in
                self.continuation = contiuation
                locaionManager.requestLocation()
            }
        }
    }
}

extension LocationManager {
    func checkAuthorization() async  {
        switch locaionManager.authorizationStatus {
        case .notDetermined:
            locaionManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            isAuthorized = true
        case .denied:
            Log.info("Should promt the user to enable the location tracking")
            isError = true
        default:
            return
        }
    }
}

//MARK: CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let lastLocation = locations.last {
                self.continuation?.resume(returning: lastLocation)
                self.continuation = nil
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Log.error("\(error.localizedDescription)")
        continuation?.resume(throwing: error)
        continuation = nil
        isError = true
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        isAuthorized = [.authorizedWhenInUse, .authorizedAlways].contains(manager.authorizationStatus)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isError = [.denied].contains(manager.authorizationStatus)
        }
    }
}
