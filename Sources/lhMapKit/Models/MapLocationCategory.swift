//
//  File.swift
//  
//
//  Created by Nicolas Le Gorrec on 5/19/24.
//

import Foundation

public enum MapLocationCategory {
    case brewery
    case cafe
    case fitnessCenter
    case hotel
    case nightlife
    case restaurant
    case stadium
    case theater
    case winery
    case unknown

    var prettyString: String {
        switch self {
        case .brewery: return "Brewery"
        case .cafe: return "Cafe"
        case .fitnessCenter: return "Fitness Center"
        case .hotel: return "Hotel"
        case .nightlife: return "Nightlife"
        case .restaurant: return "Restaurant"
        case .stadium: return "Stadium"
        case .theater: return "Theatre"
        case .winery: return "Winery"
        case .unknown: return "General"
        }
    }
}
