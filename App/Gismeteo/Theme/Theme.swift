//
//  Theme.swift
//  Gismeteo
//
//  Created by Constantin on 24.11.2023.
//

import UIKit

// MARK: - Theme

enum Theme {
	// MARK: - Internal properties

	static let backgroundColor = UIColor.systemBlue
	static let white = UIColor.white
	static let black = UIColor.black
	static let gray = UIColor.systemGray
	static let red = UIColor.systemRed

	// MARK: - Gradient

	enum Gradient {
		static let startColor = UIColor.white.withAlphaComponent(0.5)
		static let endColor = UIColor.white.withAlphaComponent(0.1)
	}
}
