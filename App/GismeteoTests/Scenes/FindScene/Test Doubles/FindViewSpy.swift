//
//  FindViewSpy.swift
//  GismeteoTests
//
//  Created by Constantin on 13.12.2023.
//

import UIKit

// MARK: - MainViewSpy

final class FindViewSpy: UIView, IFindView {
	// MARK: - Internal properties

	var delegate: IFindViewDelegate?

	// MARK: - Private properties

	private(set) var isCalledLogin = false

	// MARK: - Internal methods

	func reloadData(weatherModel _: [WeatherModel]) {
		isCalledLogin = true
	}
}
