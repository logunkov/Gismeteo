//
//  WeatherModel.swift
//  Gismeteo
//
//  Created by Constantin on 24.11.2023.
//

import CoreLocation

// MARK: - WeatherModel

struct WeatherModel: Codable {
	let lat: CLLocationDegrees
	let lon: CLLocationDegrees
	let timezone: String
	let current: Current
	let hourly: [Hourly]
	let daily: [Daily]
}

// MARK: - Current

struct Current: Codable {
	let dt: Int
	let sunrise: Int
	let sunset: Int
	let temp: Double
	let weather: [Weather]
}

// MARK: - Weather

struct Weather: Codable {
	let id: Int
	let description: String
	let icon: String
}

// MARK: - Hourly

struct Hourly: Codable {
	let dt: Int
	let temp: Double
	let weather: [Weather]
}

// MARK: - Daily

struct Daily: Codable {
	let dt: Int
	let temp: Temp
	let weather: [Weather]
}

// MARK: - Temp

struct Temp: Codable {
	let min: Double
	let max: Double
}
