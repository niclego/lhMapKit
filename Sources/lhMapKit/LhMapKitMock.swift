//
//  File.swift
//  
//
//  Created by Nicolas Le Gorrec on 5/19/24.
//

import Foundation
import CoreLocation

public struct LhMapKitMock: LhMapKitable {
    public init() {}

    public func searchNearbyLocations(for searchTerm: String, from location: CLLocation) async throws -> [MapKitLocation] {
        [.mock]
    }

    public func getAllNearbyLocations(from location: CLLocation) async throws -> [MapKitLocation] {
        [.mock]
    }
}
