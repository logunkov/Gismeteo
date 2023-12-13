//
//  MainPresenterTests.swift
//  GismeteoTests
//
//  Created by Constantin on 12.12.2023.
//

import XCTest
@testable import Gismeteo

// MARK: - MainPresenterTests

final class MainPresenterTests: XCTestCase {
	// MARK: - Private Properties

	private let viewController = MainViewControllerSpy()

	// MARK: - Internal Methods

	func test_present() {
		let sut = makeSut()
		let response = MainModel.Response(weatherModel: [])
		sut.present(response: response)
		XCTAssertTrue(viewController.isCalledRender, "Не вызван viewController.present(:)")
	}

	func test_routeToFindScene() {
		let sut = makeSut()
		sut.routeToFindScene()
		XCTAssertTrue(viewController.isCalledRender, "Не вызван viewController.routeToFindScene(:)")
	}

	func test_routeToGoBack() {
		let sut = makeSut()
		sut.routeToGoBack()
		XCTAssertTrue(viewController.isCalledRender, "Не вызван viewController.routeToGoBack(:)")
	}

	func test_routeToGoBackWithWeatherModel() {
		let sut = makeSut()
		sut.routeToGoBackWithWeatherModel()
		XCTAssertTrue(viewController.isCalledRender, "Не вызван viewController.routeToGoBackWithWeatherModel(:)")
	}
}

// MARK: - Private Methods

private extension MainPresenterTests {
	func makeSut() -> MainPresenter {
		MainPresenter(viewController: viewController)
	}
}
