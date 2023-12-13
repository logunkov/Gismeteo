//
//  CityModel.swift
//  Gismeteo
//
//  Created by Constantin on 04.12.2023.
//

import CoreLocation

// MARK: - City

struct City: Codable, Equatable {
	let latitude: CLLocationDegrees
	let longitude: CLLocationDegrees
}

// MARK: - CityModel

struct CityModel: Codable {
	let coord: Coord
}

// MARK: - Coord

struct Coord: Codable, Equatable {
	let lon: Double
	let lat: Double
}
