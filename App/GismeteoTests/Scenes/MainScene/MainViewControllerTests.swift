//
//  MainViewControllerTests.swift
//  GismeteoTests
//
//  Created by Constantin on 12.12.2023.
//

import XCTest
@testable import Gismeteo

// MARK: - MainViewControllerTests

final class MainViewControllerTests: XCTestCase {
	// MARK: - Private Properties

	private var interactor: MainInteractorSpy! // swiftlint:disable:this implicitly_unwrapped_optional

	// MARK: - Internal methods

	func test_fetchWeatherData() {
		let sut = makeSut()
		sut.fetchWeatherData()
		XCTAssertTrue(interactor.isCalledLogin, "Не вызван interactor.fetchWeatherData(:)")
	}

	func test_tappedToFindScene() {
		let sut = makeSut()
		sut.tappedToFindScene()
		XCTAssertTrue(interactor.isCalledLogin, "Не вызван interactor.tappedToFindScene(:)")
	}

	func test_tappedToAddScene() {
		let sut = makeSut()
		sut.tappedToAddScene()
		XCTAssertTrue(interactor.isCalledLogin, "Не вызван interactor.tappedToAddScen(:)")
	}

	func test_tappedToGoBack() {
		let sut = makeSut()
		sut.tappedToGoBack()
		XCTAssertTrue(interactor.isCalledLogin, "Не вызван interactor.tappedToGoBack(:)")
	}
}

// MARK: - Private Methods

private extension MainViewControllerTests {
	func makeSut() -> MainViewController {
		let mainView = MainViewSpy()
		let viewController = MainViewController(mainView: mainView, isMain: true)
		interactor = MainInteractorSpy()
		viewController.interactor = interactor
		return viewController
	}
}
