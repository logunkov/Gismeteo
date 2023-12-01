//
//  DataFetcherService.swift
//  Gismeteo
//
//  Created by Constantin on 24.11.2023.
//

import CoreLocation

// MARK: - DataFetcherService

final class DataFetcherService {

	// MARK: - Private properties

	private let networkDataFetcher = NetworkDataFetcher()

	// MARK: - Internal methods

	func fetchWeatherData(
		latitude: CLLocationDegrees,
		longitude: CLLocationDegrees,
		completion: @escaping (WeatherModel?
		) -> Void
	) {
		let urlString = APIManager.shared.getLocationCurrentWeatherURL(latitude: latitude, longitude: longitude)

		networkDataFetcher.fetchData(urlString: urlString, completion: completion)
	}
}
