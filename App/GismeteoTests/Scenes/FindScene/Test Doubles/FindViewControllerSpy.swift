//
//  FindViewControllerSpy.swift
//  GismeteoTests
//
//  Created by Constantin on 13.12.2023.
//

@testable import Gismeteo

// MARK: - FindViewControllerSpy

final class FindViewControllerSpy: IFindViewController {
	// MARK: - Private Properties

	private(set) var isCalledRender = false

	// MARK: - Internal Methods

	func removeWeatherModel(index _: Int) {
		isCalledRender = true
	}

	func routeToGoBack(index _: Int, weatherModels _: [WeatherModel]) {
		isCalledRender = true
	}

	func routeToCityScene() {
		isCalledRender = true
	}

	func routeToAlert(viewModel _: FindModel.ViewModel) {
		isCalledRender = true
	}
}
