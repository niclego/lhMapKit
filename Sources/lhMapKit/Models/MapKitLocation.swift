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
    public let name: String
    public let countryCode: String
    public let administrativeArea: String
    public let locality: String
    public let thoroughfare: String
    public let category: String
    public let location: CLLocation

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
    public static let pinnedId = "###PINNED###"
    public static func pinned(at location: CLLocation) -> MapKitLocation {
        return MapKitLocation(
            id: "###PINNED###",
            name: "pinned",
            countryCode: "NA",
            administrativeArea: "NA",
            locality: "NA",
            thoroughfare: "NA",
            category: "NA",
            location: location
        )
    }

    public var isPinned: Bool { id == Self.pinnedId }
}

extension MapKitLocation {
    public static let mock: MapKitLocation = .init(
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

extension MapKitLocation: Equatable {}
