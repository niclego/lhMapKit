//
//  LhMapKit+CLLocationManagerDelegate.swift
//
//
//  Created by Nicolas Le Gorrec on 5/19/24.
//

import CoreLocation
import Foundation

//extension LhMapKit: CLLocationManagerDelegate {
//private let locationManager = CLLocationManager()
//var isAuthorizedToGatherLocation = false
//var currentDeviceLocation: CLLocation? = nil
//
//func requestUserAuthorization() {
//    locationManager.requestWhenInUseAuthorization()
//}
//
//func requestLocation() {
//    locationManager.requestLocation()
//}
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.first else { return }
//        self.currentDeviceLocation = location
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Failed to find user's location: \(error.localizedDescription)")
//    }
//
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        switch manager.authorizationStatus {
//        case .authorizedAlways:
//            self.isAuthorizedToGatherLocation = true
//        case .authorizedWhenInUse:
//            self.isAuthorizedToGatherLocation = true
//        case .authorized:
//            self.isAuthorizedToGatherLocation = true
//        default:
//            return
//        }
//    }
//}
