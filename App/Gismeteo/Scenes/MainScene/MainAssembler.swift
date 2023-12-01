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
		let presenter = MainPresenter(viewController: viewController)
		let interactor = MainInteractor(presenter: presenter)
		viewController.interactor = interactor
		return viewController
	}
}
