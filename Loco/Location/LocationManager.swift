//
//  LocationManager.swift
//  Loco
//
//  Created by Hamid on 10/14/24.
//

import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, LocationService {
    private let locationManager = CLLocationManager()
    private let locationSubject = PassthroughSubject<CLLocation, LocationError>()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocation() -> AnyPublisher<CLLocation, LocationError> {
        let authorizationStatus = locationManager.authorizationStatus
        switch authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        case .denied:
            locationSubject.send(completion: .failure(.authorizationDenied))
        case .restricted:
            locationSubject.send(completion: .failure(.authorizationRestricted))
        default:
            locationSubject.send(completion: .failure(.unableToDetermine))
        }
        
        return locationSubject.eraseToAnyPublisher()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationSubject.send(location) // Send location
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationSubject.send(completion: .failure(.failedToGetLocation(error.localizedDescription))) // Send error
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let authorizationStatus = manager.authorizationStatus
        if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
            manager.requestLocation() // Request location once access is granted
        } else if authorizationStatus == .denied {
            locationSubject.send(completion: .failure(.authorizationDenied)) // Send authorization error
        } else if authorizationStatus == .restricted {
            locationSubject.send(completion: .failure(.authorizationRestricted)) // Send restriction error
        }
    }
}
