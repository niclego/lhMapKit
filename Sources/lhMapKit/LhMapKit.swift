//
//  LhMapKit.swift
//
//
//  Created by Nicolas Le Gorrec on 5/19/24.
//

import MapKit

public struct LhMapKit: LhMapKitable {
    public init() {}

    public func searchNearbyLocations(for searchTerm: String, from deviceLocation: CLLocation) async throws -> [MapKitLocation] {
        let req = MKLocalSearch.Request()
        req.naturalLanguageQuery = searchTerm
        req.resultTypes = .pointOfInterest
        req.region = .init(center: deviceLocation.coordinate, latitudinalMeters: 300, longitudinalMeters: 300)

        let items = try await MKLocalSearch(request: req).start()
            .mapItems
            .compactMap { $0.toMapKitLocation() }
            .removeDuplicateMapKitLocations()
            .sortedByDistance(from: deviceLocation)

        return items
    }

    public func getAllNearbyLocations(from deviceLocation: CLLocation) async throws -> [MapKitLocation] {
        let coordinate = deviceLocation.coordinate

        let venueRequest = MKLocalPointsOfInterestRequest(center: coordinate, radius: 2000)
        venueRequest.pointOfInterestFilter = .init(including: [
            .bakery,
            .brewery,
            .cafe,
            .nightlife,
            .restaurant,
            .stadium,
            .theater,
            .winery
        ])

        async let localspots = MKLocalSearch(request: venueRequest).start().mapItems
        let items = try await [
            localspots
        ]
        .flatMap { $0 }
        .compactMap { $0.toMapKitLocation() }
        .removeDuplicateMapKitLocations()
        .sortedByDistance(from: deviceLocation)

        return items
    }
}

extension LhMapKit: Sendable {}

extension MKMapItem {
    fileprivate func toMapKitLocation() -> MapKitLocation? {
        let tempSelf = self
        let location = CLLocation(latitude: tempSelf.placemark.coordinate.latitude, longitude: tempSelf.placemark.coordinate.longitude)
        return MapKitLocation(
            id: mapKitLocationId,
            name: tempSelf.name,
            countryCode: tempSelf.placemark.countryCode,
            administrativeArea: tempSelf.placemark.administrativeArea,
            locality: tempSelf.placemark.locality,
            thoroughfare: tempSelf.placemark.thoroughfare,
            category: tempSelf.pointOfInterestCategory?.category ?? .unknown,
            location: location
        )
    }

    fileprivate var mapKitLocationId: String {
        return "\(self.placemark.coordinate.latitude),\(self.placemark.coordinate.longitude),\(self.name ?? "")"
    }
}

extension MKPointOfInterestCategory {
    fileprivate var category: MapLocationCategory {
        if self == .brewery { return .brewery }
        else if self == .cafe { return .cafe }
        else if self == .fitnessCenter { return .fitnessCenter }
        else if self == .hotel { return .hotel }
        else if self == .nightlife { return .nightlife }
        else if self == .restaurant { return .restaurant }
        else if self == .stadium { return .stadium }
        else if self == .theater { return .theater }
        else if self == .winery { return .winery }
        else {  return .unknown }
    }
}

extension Array where Element == MapKitLocation {
    fileprivate func removeDuplicateMapKitLocations() -> [MapKitLocation] {
        var items = [String: MapKitLocation]()

        for value in self {
            items[value.id] = value
        }

        return  items.values.map { $0 }
    }

    public func sortedByDistance(from location: CLLocation) -> Self {
        return self.sorted { closestDistanceSort(from: location, locationB: $0.location, locationC: $1.location) }
    }

    private func closestDistanceSort(from locationA: CLLocation, locationB: CLLocation, locationC: CLLocation) -> Bool {
        let distance1 = locationA.distance(from: locationB)
        let distance2 = locationA.distance(from: locationC)

        return distance1 < distance2
    }
}
