//
//  PreviewLocationManager.swift
//  Loco
//
//  Created by Hamid on 10/14/24.
//

import CoreLocation
import Combine

class PreviewLocationManager: LocationService {
    private let locationSubject = PassthroughSubject<CLLocation, LocationError>()

    func requestLocation() -> AnyPublisher<CLLocation, LocationError> {
        // Simulate a delay before returning a mock location
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let mockLocation = CLLocation(latitude: 37.7749, longitude: -122.4194) // San Francisco
            self.locationSubject.send(mockLocation) // Send mock location
            // Uncomment to simulate an error:
            // self.locationSubject.send(completion: .failure(.failedToGetLocation("Mock error message")))
        }
        
        return locationSubject.eraseToAnyPublisher()
    }
}
