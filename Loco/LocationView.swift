//
//  LocationView.swift
//  Loco
//
//  Created by Hamid on 10/14/24.
//

import SwiftUI
import CoreLocation

struct LocationView: View {
    @StateObject var viewModel: LocationViewModel

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            }
            
            if let location = viewModel.currentLocation {
                Text("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage) // Display error message
                    .foregroundColor(.red)
                    .padding()
            } else {
                Text("Location not available")
            }

            Button("Get Location") {
                viewModel.requestLocation()
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    LocationView(viewModel: LocationViewModel(locationService: PreviewLocationManager()))
}
