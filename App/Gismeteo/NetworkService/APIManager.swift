//
//  APIManager.swift
//  Gismeteo
//
//  Created by Constantin on 24.11.2023.
//

import CoreLocation

// MARK: - APIManager

final class APIManager {

	// MARK: - Internal properties

	static let shared = APIManager()

	// MARK: - Lifecycle

	private init() {}

	// MARK: - Internal methods

	func getLocationCurrentWeatherURL(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> String {
		var components = URLComponents()
		components.scheme = OpenWeatherAPI.scheme
		components.host = OpenWeatherAPI.host
		components.path = OpenWeatherAPI.path + L10n.Api.path
		components.queryItems =
			[
				URLQueryItem(name: L10n.Api.lat, value: String(latitude)),
				URLQueryItem(name: L10n.Api.lon, value: String(longitude)),
				URLQueryItem(name: L10n.Api.exclude, value: L10n.Api.minutely),
				URLQueryItem(name: L10n.Api.units, value: L10n.Api.metric),
				URLQueryItem(name: L10n.Api.appid, value: OpenWeatherAPI.key)
			]
		guard let componentsString = components.string else { return L10n.StringS.space }
		return componentsString
	}
}
