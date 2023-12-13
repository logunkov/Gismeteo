//
//  MainInteractorSpy.swift
//  GismeteoTests
//
//  Created by Constantin on 12.12.2023.
//

@testable import Gismeteo

// MARK: - MainInteractorSpy

final class MainInteractorSpy: IMainInteractor {
	// MARK: - Private Properties

	private(set) var isCalledLogin = false

	// MARK: - Internal Methods

	func fetchWeatherData(request _: MainModel.Request) {
		isCalledLogin = true
	}

	func tappedToFindScene() {
		isCalledLogin = true
	}

	func tappedToAddScene() {
		isCalledLogin = true
	}

	func tappedToGoBack() {
		isCalledLogin = true
	}
}
