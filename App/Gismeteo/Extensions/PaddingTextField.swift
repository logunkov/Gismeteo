//
//  PaddingTextField.swift
//  Gismeteo
//
//  Created by Constantin on 04.12.2023.
//

import UIKit

// MARK: - TextFieldWithPadding

final class TextFieldWithPadding: UITextField {
	// MARK: - Internal properties

	var textPadding = UIEdgeInsets(
		top: 8,
		left: 8,
		bottom: 8,
		right: 8
	)

	// MARK: - Lifecycle

	override func textRect(forBounds bounds: CGRect) -> CGRect {
		let rect = super.textRect(forBounds: bounds)
		return rect.inset(by: textPadding)
	}

	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		let rect = super.editingRect(forBounds: bounds)
		return rect.inset(by: textPadding)
	}
}
