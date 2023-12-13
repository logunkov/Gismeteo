//
//  Repository.swift
//  Gismeteo
//
//  Created by Constantin on 03.12.2023.
//

import CoreLocation

// MARK: - Repository

final class Repository {
	// MARK: - Internal properties

	static let shared: Repository = .init()

	// MARK: - Private properties

	private(set) var cities = [City]()
	private(set) var city: City?
	private let citiesData = FileManager.default.urls(
		for: .documentDirectory,
		in: .userDomainMask
	)[Int.zero]
		.appendingPathComponent(L10n.Api.citiesData)

	// MARK: - Lifecycle

	private init() {}

	// MARK: - Location

	func setLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
		let currentCity = City(latitude: latitude, longitude: longitude)

		if !cities.isEmpty {
			cities[Int.zero] = currentCity
		} else {
			cities.append(currentCity)
		}
	}

	// MARK: - Backup

	func saveBackup() {
		if let data = try? PropertyListEncoder().encode(cities) {
			try? data.write(to: citiesData)
		}
	}

	func loadBackup() {
		guard let citiesData = try? Data(contentsOf: citiesData)
		else { return }

		if let backup = try? PropertyListDecoder().decode([City].self, from: citiesData) {
			cities = backup
		}
	}

	// MARK: - Array

	func append(city: City) {
		if let index = cities.firstIndex(of: city) {
			cities[index] = city
		} else {
			cities.append(city)
		}

		saveBackup()
	}

	func remove(index: Int) {
		cities.remove(at: index)
		saveBackup()
	}

	func cache(city: City) {
		self.city = city
	}
}
