//
//  FindInteractor.swift
//  Gismeteo
//
//  Created by Constantin on 04.12.2023.
//

import Foundation

// MARK: - IFindInteractor

protocol IFindInteractor {
	func goBack(index: Int, weatherModels: [WeatherModel])
	func fetchCityData(request: FindModel.Request)
	func remove(index: Int)
}

// MARK: - FindInteractor

final class FindInteractor: IFindInteractor {
	// MARK: - Private properties

	private let presenter: IFindPresenter?
	private let networkService = DataFetcherService()

	// MARK: - Lifecycle

	init(presenter: IFindPresenter) {
		self.presenter = presenter
	}

	// MARK: - Internal methods

	func goBack(index: Int, weatherModels: [WeatherModel]) {
		presenter?.routeToGoBack(index: index, weatherModels: weatherModels)
	}

	func fetchCityData(request: FindModel.Request) {
		networkService.fetchCityData(city: request.findCity) { [weak self] city in
			guard let self, let city else { return }
			Repository.shared.cache(city: City(latitude: city.coord.lat, longitude: city.coord.lon))
			let response = FindModel.Response(city: CityModel(coord: city.coord))

			self.presenter?.routeCityData(response: response)
		}

		networkService.fetchErrorData(city: request.findCity) { [weak self] error in
			guard let self, let error else { return }
			let response = FindModel.Response(error: error)
			self.presenter?.routeErrorData(response: response)
		}
	}

	func remove(index: Int) {
		Repository.shared.remove(index: index)
		presenter?.remove(index: index)
	}
}
