//
//  MainViewControllerSpy.swift
//  GismeteoTests
//
//  Created by Constantin on 13.12.2023.
//

@testable import Gismeteo

// MARK: - MainViewControllerSpy

final class MainViewControllerSpy: IMainViewController {
	// MARK: - Private Properties

	private(set) var isCalledRender = false

	// MARK: - Internal Methods

	func render(viewModel _: MainModel.ViewModel) {
		isCalledRender = true
	}

	func routeToFindScene() {
		isCalledRender = true
	}

	func routeToGoBack() {
		isCalledRender = true
	}

	func routeToGoBackWithWeatherModel() {
		isCalledRender = true
	}
}
