//
//  LocationErrorMapper.swift
//  Loco
//
//  Created by Hamid on 10/14/24.
//

import Foundation

struct LocationErrorMapper {

    // MARK: - Context
    enum Context {
        case homePage
        case settings
    }

    // MARK: - Properties
    let error: LocationError
    let context: Context

    // MARK: - Public API
    var message: String {
        switch error {
        case .authorizationDenied:
            return "Location access has been denied. Please enable location permissions in your settings."
        case .authorizationRestricted:
            return "Location access is restricted."
        case .failedToGetLocation(let errorMessage):
            return "Failed to get location: \(errorMessage)"
        case .unableToDetermine:
            return "Unable to determine location authorization status."
        }
    }
}
