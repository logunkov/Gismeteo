//
//  MainPresenterSpy.swift
//  GismeteoTests
//
//  Created by Constantin on 13.12.2023.
//

@testable import Gismeteo

// MARK: - MAinPresenterSpy

final class MainPresenterSpy: IMainPresenter {
	// MARK: - Private Properties

	private(set) var isCalledPresent = false

	// MARK: - Internal Methods

	func present(response _: MainModel.Response) {
		isCalledPresent = true
	}

	func routeToFindScene() {
		isCalledPresent = true
	}

	func routeToGoBack() {
		isCalledPresent = true
	}

	func routeToGoBackWithWeatherModel() {
		isCalledPresent = true
	}
}
