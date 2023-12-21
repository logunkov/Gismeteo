//
//  FindPresenter.swift
//  Gismeteo
//
//  Created by Constantin on 04.12.2023.
//

// MARK: - IFindPresenter

protocol IFindPresenter {
	func remove(index: Int)
	func routeToGoBack(index: Int, weatherModels: [WeatherModel])
	func routeCityData(response: FindModel.Response)
	func routeErrorData(response: FindModel.Response)
}

// MARK: - FindPresenter

final class FindPresenter: IFindPresenter {
	// MARK: - Private properties

	private weak var viewController: IFindViewController?

	// MARK: - Lifecycle

	init(viewController: IFindViewController?) {
		self.viewController = viewController
	}

	// MARK: - Internal methods

	func remove(index: Int) {
		viewController?.removeWeatherModel(index: index)
	}

	func routeToGoBack(index: Int, weatherModels: [WeatherModel]) {
		viewController?.routeToGoBack(index: index, weatherModels: weatherModels)
	}

	func routeCityData(response _: FindModel.Response) {
		viewController?.routeToCityScene()
	}

	func routeErrorData(response: FindModel.Response) {
		let viewModel = FindModel.ViewModel(error: response.error)
		viewController?.routeToAlert(viewModel: viewModel)
	}
}
