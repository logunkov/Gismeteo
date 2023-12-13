//
//  MainViewSpy.swift
//  GismeteoTests
//
//  Created by Constantin on 12.12.2023.
//

import UIKit

// MARK: - MainViewSpy

final class MainViewSpy: UIView, IMainView {
	// MARK: - Internal properties

	var delegate: IMainViewDelegate?

	// MARK: - Private properties

	private(set) var isCalledLogin = false

	// MARK: - Internal methods

	func reloadData(viewModel _: MainModel.ViewModel) {
		isCalledLogin = true
	}
}
