//
//  LocationError.swift
//  Loco
//
//  Created by Hamid on 10/14/24.
//

import Foundation

enum LocationError: Error {
    case authorizationDenied
    case authorizationRestricted
    case unableToDetermine
    case failedToGetLocation(String)
}
