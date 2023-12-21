//
//  DataFetcherService.swift
//  Gismeteo
//
//  Created by Constantin on 24.11.2023.
//

import CoreLocation

// MARK: - IDataFetcherService

protocol IDataFetcherService {
	func fetchWeatherData(
		latitude: CLLocationDegrees,
		longitude: CLLocationDegrees,
		completion: @escaping (WeatherModel?
		) -> Void
	)

	func fetchCityData(
		city: String,
		completion: @escaping (CityModel?
		) -> Void
	)

	func fetchErrorData(
		city: String,
		completion: @escaping (ErrorModel?
		) -> Void
	)
}

// MARK: - DataFetcherService

final class DataFetcherService: IDataFetcherService {
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

	func fetchCityData(
		city: String,
		completion: @escaping (CityModel?
		) -> Void
	) {
		let urlString = APIManager.shared.getCityURL(city: city)
		networkDataFetcher.fetchData(urlString: urlString, completion: completion)
	}

	func fetchErrorData(
		city: String,
		completion: @escaping (ErrorModel?
		) -> Void
	) {
		let urlString = APIManager.shared.getCityURL(city: city)
		networkDataFetcher.fetchData(urlString: urlString, completion: completion)
	}
}
