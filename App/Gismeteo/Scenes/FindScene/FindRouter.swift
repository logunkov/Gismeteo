//
//  FindRouter.swift
//  Gismeteo
//
//  Created by Constantin on 21.12.2023.
//

import UIKit

// MARK: - IFindRouter

protocol IFindRouter {
	func routeToGoBack(index: Int, weatherModels: [WeatherModel], delegate: IFindViewControllerDelegate)
	func routeToCityScene(viewController: UIViewController)
	func routeToAlert(viewModel: FindModel.ViewModel)
}

// MARK: - FindRouter

final class FindRouter: IFindRouter {
	// MARK: - Private properties

	private let viewController: UIViewController

	// MARK: - Lifecycle

	init(mainViewController: UIViewController) {
		viewController = mainViewController
	}

	// MARK: - Internal methods

	func routeToGoBack(index: Int, weatherModels: [WeatherModel], delegate: IFindViewControllerDelegate) {
		viewController.dismiss(animated: true) {
			delegate.didCloseToFindScene(index: index, weatherModels: weatherModels)
		}
	}

	func routeToCityScene(viewController: UIViewController) {
		self.viewController.present(viewController, animated: true)
	}

	func routeToAlert(viewModel: FindModel.ViewModel) {
		guard let message = viewModel.error?.message else { return }
		let alert = Factory.shared.createAlert(message: message.firstCapitalized)
		viewController.present(alert, animated: true, completion: nil)
	}
}
