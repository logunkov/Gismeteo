//
//  FindPresenterTests.swift
//  GismeteoTests
//
//  Created by Constantin on 12.12.2023.
//

import XCTest
@testable import Gismeteo

// MARK: - FindPresenterTests

final class FindPresenterTests: XCTestCase {
	// MARK: - Private Properties

	private let viewController = FindViewControllerSpy()

	// MARK: - Internal Methods

	func test_remove() {
		let sut = makeSut()
		sut.remove(index: 0)
		XCTAssertTrue(viewController.isCalledRender, "Не вызван viewController.remove(:)")
	}

	func test_routeToGoBack() {
		let sut = makeSut()
		sut.routeToGoBack(index: 0, weatherModels: [])
		XCTAssertTrue(viewController.isCalledRender, "Не вызван viewController.routeToGoBack(:)")
	}

	func test_routeCityData() {
		let sut = makeSut()
		let response = FindModel.Response()
		sut.routeCityData(response: response)
		XCTAssertTrue(viewController.isCalledRender, "Не вызван viewController.routeCityData(:)")
	}

	func test_routeErrorData() {
		let sut = makeSut()
		let response = FindModel.Response()
		sut.routeErrorData(response: response)
		XCTAssertTrue(viewController.isCalledRender, "Не вызван viewController.routeErrorData(:)")
	}
}

// MARK: - Private Methods

private extension FindPresenterTests {
	func makeSut() -> FindPresenter {
		FindPresenter(viewController: viewController)
	}
}
