//
//  FindPresenterSpy.swift
//  GismeteoTests
//
//  Created by Constantin on 13.12.2023.
//

@testable import Gismeteo

// MARK: - FindPresenterSpy

final class FindPresenterSpy: IFindPresenter {
	// MARK: - Private Properties

	private(set) var isCalledPresent = false

	// MARK: - Internal Methods

	func remove(index _: Int) {
		isCalledPresent = true
	}

	func routeToGoBack(index _: Int, weatherModels _: [WeatherModel]) {
		isCalledPresent = true
	}

	func routeCityData(response _: FindModel.Response) {
		isCalledPresent = true
	}

	func routeErrorData(response _: FindModel.Response) {
		isCalledPresent = true
	}
}
