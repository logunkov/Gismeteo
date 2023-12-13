//
//  FindInteractorSpy.swift
//  GismeteoTests
//
//  Created by Constantin on 13.12.2023.
//

@testable import Gismeteo

// MARK: - FindInteractorSpy

final class FindInteractorSpy: IFindInteractor {
	// MARK: - Private Properties

	private(set) var isCalledLogin = false

	// MARK: - Internal Methods

	func goBack(index _: Int, weatherModels _: [WeatherModel]) {
		isCalledLogin = true
	}

	func fetchCityData(request _: FindModel.Request) {
		isCalledLogin = true
	}

	func remove(index _: Int) {
		isCalledLogin = true
	}
}
