//
//  MainAssembler.swift
//  Gismeteo
//
//  Created by Constantin on 29.11.2023.
//

import UIKit

// MARK: - MainAssembler

final class MainAssembler {
	// MARK: - Internal methods

	func assembly(isMain: Bool) -> UIViewController {
		let view = MainView(isMain: isMain)
		let viewController = MainViewController(mainView: view, isMain: isMain)
		let router = MainRouter(mainViewController: viewController)
		viewController.router = router
		let presenter = MainPresenter(viewController: viewController)
		let dataFetcherService = DataFetcherService()
		let interactor = MainInteractor(presenter: presenter, networkService: dataFetcherService)
		viewController.interactor = interactor
		return viewController
	}
}
