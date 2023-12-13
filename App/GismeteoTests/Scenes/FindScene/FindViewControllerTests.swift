//
//  FindViewControllerTests.swift
//  GismeteoTests
//
//  Created by Constantin on 12.12.2023.
//

import XCTest
@testable import Gismeteo

// MARK: - FindViewControllerTests

final class FindViewControllerTests: XCTestCase {
	// MARK: - Private Properties

	private var interactor: FindInteractorSpy! // swiftlint:disable:this implicitly_unwrapped_optional

	// MARK: - Internal methods

	func test_goBack() {
		let sut = makeSut()
		sut.goBack(index: 0, weatherModels: [])
		XCTAssertTrue(interactor.isCalledLogin, "Не вызван interactor.goBack(:)")
	}

	func test_fetchCityData() {
		let sut = makeSut()
		sut.fetchCityData(city: "London")
		XCTAssertTrue(interactor.isCalledLogin, "Не вызван interactor.fetchCityData(:)")
	}

	func test_remove() {
		let sut = makeSut()
		sut.remove(index: 0)
		XCTAssertTrue(interactor.isCalledLogin, "Не вызван interactor.remove(:)")
	}
}

// MARK: - Private Methods

private extension FindViewControllerTests {
	func makeSut() -> FindViewController {
		let mainView = FindViewSpy()
		let viewController = FindViewController(findView: mainView, weatherModel: [])
		interactor = FindInteractorSpy()
		viewController.interactor = interactor
		return viewController
	}
}
