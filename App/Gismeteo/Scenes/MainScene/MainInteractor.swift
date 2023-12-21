//
//  MainInteractor.swift
//  Gismeteo
//
//  Created by Constantin on 29.11.2023.
//

import Foundation

// MARK: - IMainInteractor

protocol IMainInteractor {
	func fetchWeatherData(request: MainModel.Request)
	func tappedToFindScene()
	func tappedToAddScene()
	func tappedToGoBack()
}

// MARK: - MainInteractor

final class MainInteractor: IMainInteractor {
	// MARK: - Private properties

	private let networkService: IDataFetcherService?
	private let dispatchGroup = DispatchGroup()
	private let presenter: IMainPresenter?
	private var weatherModel = [WeatherModel]()

	// MARK: - Lifecycle

	init(presenter: IMainPresenter, networkService: IDataFetcherService) {
		self.presenter = presenter
		self.networkService = networkService
	}

	// MARK: - Internal methods

	func fetchWeatherData(request: MainModel.Request) {
		request.cities.forEach { [weak self] city in
			guard let self else { return }
			dispatchGroup.enter()
			self.networkService?.fetchWeatherData(latitude: city.latitude, longitude: city.longitude) { [weak self] weather in
				guard let self, let weather else { return }
				self.weatherModel.append(weather)
				self.dispatchGroup.leave()
			}
		}

		dispatchGroup.notify(queue: .main) { [weak self] in
			guard let self else { return }
			let unsortedWeatherModel = self.weatherModel
			let uncertainty = Sizes.Coord.uncertainty

			request.cities.enumerated().forEach { index, city in
				unsortedWeatherModel.forEach { weather in
					let coordCity = Coord(
						lon: round(city.longitude * uncertainty) / uncertainty,
						lat: round(city.latitude * uncertainty) / uncertainty
					)

					let coordFindCity = Coord(
						lon: round(weather.lon * uncertainty) / uncertainty,
						lat: round(weather.lat * uncertainty) / uncertainty
					)

					if coordCity == coordFindCity {
						self.weatherModel[index] = weather
					}
				}
			}

			let response = MainModel.Response(weatherModel: self.weatherModel)
			self.presenter?.present(response: response)
		}
	}

	func tappedToFindScene() {
		presenter?.routeToFindScene()
	}

	func tappedToAddScene() {
		guard let city = Repository.shared.city else { return }
		Repository.shared.append(city: city)
		presenter?.routeToGoBackWithWeatherModel()
	}

	func tappedToGoBack() {
		presenter?.routeToGoBack()
	}
}
