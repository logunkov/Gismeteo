//
//  UIStackView+Extension.swift
//  Gismeteo
//
//  Created by Constantin on 24.11.2023.
//

import UIKit

// MARK: - UIStackView

extension UIStackView {
	// MARK: - Internal methods

	func addArrangedSubviews(_ views: [UIView]) {
		views.forEach { addArrangedSubview($0) }
	}
}
