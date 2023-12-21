//
//  MainRouter.swift
//  Gismeteo
//
//  Created by Constantin on 21.12.2023.
//

import UIKit

// MARK: - IMainRouter

protocol IMainRouter {
	func routeToFindScene(viewController: UIViewController)
	func routeToGoBack()
	func routeToGoBackWithWeatherModel(weatherModel: WeatherModel, delegate: IMainViewControllerDelegate)
}

// MARK: - MainRouter

final class MainRouter: IMainRouter {
	// MARK: - Private properties

	private let viewController: UIViewController

	// MARK: - Lifecycle

	init(mainViewController: UIViewController) {
		viewController = mainViewController
	}

	// MARK: - Internal methods

	func routeToFindScene(viewController: UIViewController) {
		self.viewController.present(viewController, animated: true)
	}

	func routeToGoBack() {
		viewController.dismiss(animated: true)
	}

	func routeToGoBackWithWeatherModel(weatherModel: WeatherModel, delegate: IMainViewControllerDelegate) {
		viewController.dismiss(animated: true) {
			delegate.didCloseToCityScene(weatherModel: weatherModel)
		}
	}
}
