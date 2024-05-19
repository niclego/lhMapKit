//
//  MapKitManageable.swift
//  
//
//  Created by Nicolas Le Gorrec on 5/19/24.
//

import Foundation
import CoreLocation

public protocol LhMapKitable {
    func searchNearbyLocations(for searchTerm: String, from deviceLocation: CLLocation) async throws -> [MapKitLocation]
    func getAllNearbyLocations(from deviceLocation: CLLocation) async throws -> [MapKitLocation]
}
