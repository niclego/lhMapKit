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

extension MapKitLocation {
    static let mock: MapKitLocation = .init(
        id: "test",
        name: "Test Place",
        countryCode: "US",
        administrativeArea: "Test",
        locality: "Test",
        thoroughfare: "Test",
        category: "Brewery",
        location: .init(latitude: 0, longitude: 0)
    )
}
