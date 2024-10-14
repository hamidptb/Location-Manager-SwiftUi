//
//  LocationViewModel.swift
//  Loco
//
//  Created by Hamid on 10/14/24.
//

import Combine
import CoreLocation

class LocationViewModel: ObservableObject {
    @Published var currentLocation: CLLocation?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false

    private var locationService: LocationService
    private var cancellables = Set<AnyCancellable>()

    init(locationService: LocationService) {
        self.locationService = locationService
    }

    func requestLocation() {
        isLoading = true
        
        locationService.requestLocation()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                
                if case .failure(let error) = completion {
                    self?.errorMessage = LocationErrorMapper(
                        error: error,
                        context: .homePage
                    ).message
                }
            }, receiveValue: { [weak self] location in
                self?.currentLocation = location
                self?.errorMessage = nil
                self?.isLoading = false
            })
            .store(in: &cancellables)
    }
}
