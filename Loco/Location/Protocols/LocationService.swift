//
//  LocationService.swift
//  Loco
//
//  Created by Hamid on 10/14/24.
//

import CoreLocation
import Combine

protocol LocationService {
    func requestLocation() -> AnyPublisher<CLLocation, LocationError>
}
