//
//  MapKitManageable.swift
//  
//
//  Created by Nicolas Le Gorrec on 5/19/24.
//

import Foundation
import CoreLocation

public protocol LhMapKitable {
    func nearbyLocation(for searchTerm: String, from location: CLLocation) async throws -> [MapKitLocation]
    func nearbyAllLocations(from location: CLLocation) async throws -> [MapKitLocation]
}
