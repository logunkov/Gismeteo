//
//  FindInteractorTests.swift
//  GismeteoTests
//
//  Created by Constantin on 12.12.2023.
//

import XCTest
@testable import Gismeteo

// MARK: - FindInteractorTests

final class FindInteractorTests: XCTestCase {
	// MARK: - Private Properties

	private let presenter = FindPresenterSpy()
	private let networkService = DataFetcherService()

	// MARK: - Internal Methods

	func test_goBack() {
		let sut = makeSut()
		sut.goBack(index: 0, weatherModels: [])
		XCTAssertTrue(presenter.isCalledPresent, "Не вызван  presenter.goBack(:)")
	}
}

// MARK: - Private Methods

private extension FindInteractorTests {
	func makeSut() -> FindInteractor {
		FindInteractor(presenter: presenter, networkService: networkService)
	}
}
