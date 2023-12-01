//
//  UIView+Extension.swift
//  Gismeteo
//
//  Created by Constantin on 28.11.2023.
//

import UIKit

// MARK: - UIView

extension UIView {

	// MARK: - Internal methods

	func addSubviews(_ views: [UIView]) {
		views.forEach { addSubview($0) }
	}
}
