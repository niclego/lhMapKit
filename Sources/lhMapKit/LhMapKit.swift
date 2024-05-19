//
//  LhMapKit.swift
//
//
//  Created by Nicolas Le Gorrec on 5/19/24.
//

import MapKit

public struct LhMapKit: LhMapKitable {
    public func nearbyLocation(for searchTerm: String, from location: CLLocation) async throws -> [MapKitLocation] {
        let req = MKLocalSearch.Request()
        req.naturalLanguageQuery = searchTerm
        req.resultTypes = .pointOfInterest
        req.region = .init(center: location.coordinate, latitudinalMeters: 150, longitudinalMeters: 150)

        let items = try await MKLocalSearch(request: req).start()
            .mapItems
            .compactMap { $0.toMapKitLocation() }
            .removeDuplicateMapKitLocations()
            .sortedByDistance(from: location)

        return items
    }

    public func nearbyAllLocations(from location: CLLocation) async throws -> [MapKitLocation] {
        let coordinate = location.coordinate

        let reqBrewery = MKLocalSearch.Request()
        reqBrewery.naturalLanguageQuery = "Brewery"
        reqBrewery.resultTypes = .pointOfInterest
        reqBrewery.region = .init(center: coordinate, latitudinalMeters: 150, longitudinalMeters: 150)

        let reqCafes = MKLocalSearch.Request()
        reqCafes.naturalLanguageQuery = "Cafe"
        reqCafes.resultTypes = .pointOfInterest
        reqCafes.region = .init(center: coordinate, latitudinalMeters: 150, longitudinalMeters: 150)

        let reqFitnesscenter = MKLocalSearch.Request()
        reqFitnesscenter.naturalLanguageQuery = "Fitness Center"
        reqFitnesscenter.resultTypes = .pointOfInterest
        reqFitnesscenter.region = .init(center: coordinate, latitudinalMeters: 150, longitudinalMeters: 150)

        let reqHotel = MKLocalSearch.Request()
        reqHotel.naturalLanguageQuery = "Hotel"
        reqHotel.resultTypes = .pointOfInterest
        reqHotel.region = .init(center: coordinate, latitudinalMeters: 150, longitudinalMeters: 150)

        let reqNightlife = MKLocalSearch.Request()
        reqNightlife.naturalLanguageQuery = "Nightlife"
        reqNightlife.resultTypes = .pointOfInterest
        reqNightlife.region = .init(center: coordinate, latitudinalMeters: 150, longitudinalMeters: 150)

        let reqRestaurant = MKLocalSearch.Request()
        reqRestaurant.naturalLanguageQuery = "Restaurant"
        reqRestaurant.resultTypes = .pointOfInterest
        reqRestaurant.region = .init(center: coordinate, latitudinalMeters: 150, longitudinalMeters: 150)

        let reqStadium = MKLocalSearch.Request()
        reqStadium.naturalLanguageQuery = "Stadium"
        reqStadium.resultTypes = .pointOfInterest
        reqStadium.region = .init(center: coordinate, latitudinalMeters: 150, longitudinalMeters: 150)

        let reqTheater = MKLocalSearch.Request()
        reqTheater.naturalLanguageQuery = "Theater"
        reqTheater.resultTypes = .pointOfInterest
        reqTheater.region = .init(center: coordinate, latitudinalMeters: 150, longitudinalMeters: 150)

        let reqWinery = MKLocalSearch.Request()
        reqWinery.naturalLanguageQuery = "Winery"
        reqWinery.resultTypes = .pointOfInterest
        reqWinery.region = .init(center: coordinate, latitudinalMeters: 150, longitudinalMeters: 150)

        async let breweries = MKLocalSearch(request: reqBrewery).start().mapItems
        async let cafes = MKLocalSearch(request: reqCafes).start().mapItems
        async let fitnessCenters = MKLocalSearch(request: reqFitnesscenter).start().mapItems
        async let hotels = MKLocalSearch(request: reqHotel).start().mapItems
        async let nightlife = MKLocalSearch(request: reqNightlife).start().mapItems
        async let restaurants = MKLocalSearch(request: reqRestaurant).start().mapItems
        async let stadiums = MKLocalSearch(request: reqStadium).start().mapItems
        async let theaters = MKLocalSearch(request: reqTheater).start().mapItems
        async let wineries = MKLocalSearch(request: reqWinery).start().mapItems

        let items = try await [
            breweries,
            cafes,
            fitnessCenters,
            hotels,
            nightlife,
            restaurants,
            stadiums,
            theaters,
            stadiums,
            wineries
        ]
        .flatMap { $0 }
        .compactMap { $0.toMapKitLocation() }
        .removeDuplicateMapKitLocations()
        .sortedByDistance(from: location)

        return items
    }
}

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
            category: tempSelf.pointOfInterestCategory?.category,
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

    fileprivate func sortedByDistance(from location: CLLocation) -> Self {
        return self.sorted { closestDistanceSort(from: location, locationB: $0.location, locationC: $1.location) }
    }

    private func closestDistanceSort(from locationA: CLLocation, locationB: CLLocation, locationC: CLLocation) -> Bool {
        let coordinatesA = locationA.coordinate
        let coordinatesB = locationB.coordinate
        let coordinatesC = locationC.coordinate
        let distance1 = locationA.distance(from: locationB)
        let distance2 = locationA.distance(from: locationC)

        return distance1 < distance2
    }
}
