//
//  MainPresenter.swift
//  Gismeteo
//
//  Created by Constantin on 29.11.2023.
//

// MARK: - IMainPresenter

protocol IMainPresenter {
	func present(response: MainModel.Response)
	func routeToFindScene()
	func routeToGoBack()
	func routeToGoBackWithWeatherModel()
}

// MARK: - MainPresenter

final class MainPresenter: IMainPresenter {
	// MARK: - Private properties

	private weak var viewController: IMainViewController?

	// MARK: - Lifecycle

	init(viewController: IMainViewController?) {
		self.viewController = viewController
	}

	// MARK: - Internal methods

	func present(response: MainModel.Response) {
		viewController?.render(viewModel: MainModel.ViewModel(weatherModel: response.weatherModel))
	}

	func routeToFindScene() {
		viewController?.routeToFindScene()
	}

	func routeToGoBack() {
		viewController?.routeToGoBack()
	}

	func routeToGoBackWithWeatherModel() {
		viewController?.routeToGoBackWithWeatherModel()
	}
}
