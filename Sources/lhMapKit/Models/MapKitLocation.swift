//
//  File.swift
//  
//
//  Created by Nicolas Le Gorrec on 5/19/24.
//

import Foundation
import CoreLocation

public struct MapKitLocation {
    public let id: String
    let name: String
    let countryCode: String
    let administrativeArea: String
    let locality: String
    let thoroughfare: String
    let category: String
    let location: CLLocation

    init(
        id: String,
        name: String,
        countryCode: String,
        administrativeArea: String,
        locality: String,
        thoroughfare: String,
        category: String,
        location: CLLocation
    ) {
        self.name = name
        self.id = id
        self.countryCode = countryCode
        self.administrativeArea = administrativeArea
        self.locality = locality
        self.thoroughfare = thoroughfare
        self.category = category
        self.location = location
    }

    init?(
        id: String,
        name: String?,
        countryCode: String?,
        administrativeArea: String?,
        locality: String?,
        thoroughfare: String?,
        category: MapLocationCategory?,
        location: CLLocation
    ) {
        guard
            let name = name,
            let countryCode = countryCode,
            let administrativeArea = administrativeArea,
            let locality = locality,
            let thoroughfare = thoroughfare,
            let category = category
        else { return nil }

        self.name = name
        self.id = id
        self.countryCode = countryCode
        self.administrativeArea = administrativeArea
        self.locality = locality
        self.thoroughfare = thoroughfare
        self.category = category.prettyString
        self.location = location
    }
}

extension MapKitLocation: Identifiable {}

extension MapKitLocation {
    static let pinned = MapKitLocation(
        id: "###test###",
        name: "pinned",
        countryCode: "US",
        administrativeArea: "NY",
        locality: "BK",
        thoroughfare: "1109 Halsey St",
        category: "Food",
        location: .init(latitude: 0, longitude: 0)
    )
}

extension MapKitLocation: Equatable {}
