//
//  Sizes.swift
//  Gismeteo
//
//  Created by Constantin on 24.11.2023.
//

import UIKit

// MARK: - Sizes

enum Sizes {

	// MARK: - Medium

	enum Medium {
		static let halfPadding: CGFloat = 8
		static let padding: CGFloat = 16
		static let cornerRadius: CGFloat = 16
	}

	// MARK: - Table

	enum Table {
		static let contentInset = UIEdgeInsets(top: -35, left: 0, bottom: 0, right: 0)
		static let week: CGFloat = 7
		static let spacing: CGFloat = 1
	}

	// MARK: - Gradient

	enum Gradient {
		static let startPoint = CGPoint(x: 0.5, y: 0)
		static let endPoint = CGPoint(x: 0.5, y: 1)
	}

	// MARK: - PageControl

	enum PageControl {
		static let alpha: CGFloat = 0.5
		static let cornerRadius: CGFloat = 12
	}

	// MARK: - CarouselView

	enum CarouselView {
		static let screenMultiplier: CGFloat = 0.9
	}
}
