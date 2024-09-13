//
//  GeocoderModel.swift
//  WeatherApp
//
//  Created by Pallavi Ashim on 9/12/24.
//

import Foundation

// MARK: - GeocoderModelElement
struct GeocoderModelElement: Codable {
    let name: String
    let localNames: [String: String]?
    let lat, lon: Double
    let country, state: String

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
    }
}

typealias GeocoderModel = [GeocoderModelElement]
