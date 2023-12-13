//
//  FindAssembler.swift
//  Gismeteo
//
//  Created by Constantin on 04.12.2023.
//

import UIKit

// MARK: - FindAssembler

final class FindAssembler {
	// MARK: - Internal methods

	func assembly(weatherModel: [WeatherModel]) -> UIViewController {
		let view = FindView()
		let viewController = FindViewController(findView: view, weatherModel: weatherModel)
		viewController.modalPresentationStyle = .overFullScreen
		let presenter = FindPresenter(viewController: viewController)
		let interactor = FindInteractor(presenter: presenter)
		viewController.interactor = interactor
		return viewController
	}
}
