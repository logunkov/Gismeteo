//
//  MainInteractorTests.swift
//  GismeteoTests
//
//  Created by Constantin on 12.12.2023.
//

import XCTest
@testable import Gismeteo

// MARK: - MainInteractorTests

final class MainInteractorTests: XCTestCase {
	// MARK: - Private Properties

	private let presenter = MainPresenterSpy()

	// MARK: - Internal Methods

	func test_tappedToFindScene() {
		let sut = makeSut()
		sut.tappedToFindScene()
		XCTAssertTrue(presenter.isCalledPresent, "Не вызван  presenter.tappedToFindScene(:)")
	}

	func test_tappedToGoBack() {
		let sut = makeSut()
		sut.tappedToGoBack()
		XCTAssertTrue(presenter.isCalledPresent, "Не вызван  presenter.tappedToGoBack(:)")
	}
}

// MARK: - Private Methods

private extension MainInteractorTests {
	func makeSut() -> MainInteractor {
		MainInteractor(presenter: presenter)
	}
}
