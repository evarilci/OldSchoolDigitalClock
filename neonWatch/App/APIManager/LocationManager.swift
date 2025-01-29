//
//  LocationManager.swift
//  neonWatch
//
//  Created by Eymen Varilci on 29.01.2025.
//


import SwiftUI
import CoreLocation

@MainActor
class LocationManager: NSObject, ObservableObject, @preconcurrency CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    @Published var cityName: String = ""
    @Published var errorMessage: String?
    
    override init() {
        super.init()
        manager.delegate = self
        // Request permission for location
        manager.requestWhenInUseAuthorization()
        // Start updating location (if granted)
        manager.startUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // If permission granted, we can start updating location
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.startUpdatingLocation()
        } else if status == .denied || status == .restricted {
            errorMessage = "Location permission denied"
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        // Stop updating if you only want the first fix:
         manager.stopUpdatingLocation()
        
        // Reverse geocode to get city name
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }
            if let error = error {
                self.errorMessage = "Geocode error: \(error.localizedDescription)"
                return
            }
            
            if let placemark = placemarks?.first {
                // Attempt to get the city name from the placemark
                if let city = placemark.locality {
                    self.cityName = city
                } else {
                    self.errorMessage = "City not found"
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        errorMessage = "Location error: \(error.localizedDescription)"
    }
}
