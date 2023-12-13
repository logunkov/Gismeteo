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
		static let halfCornerRadius: CGFloat = 8
		static let cornerRadius: CGFloat = 16
	}

	// MARK: - Font

	enum Font {
		static let headerView: CGFloat = 90
		static let action: CGFloat = 16
	}

	// MARK: - Collection

	enum Collection {
		static let hoursDay = 24
		static let widthtMultiplier: CGFloat = 0.7
		static let heightMultiplier: CGFloat = 0.9
	}

	// MARK: - Table

	enum Table {
		static let contentInset = UIEdgeInsets(top: -35, left: 0, bottom: 0, right: 0)
		static let spacing: CGFloat = 1
		static let section = 1
		static let heightsection: CGFloat = 100
		static let sectionHeaderHeight: CGFloat = 4
		static let sectionFooterHeight: CGFloat = 4
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

	// MARK: - Coord

	enum Coord {
		static let uncertainty: Double = 100
	}

	// MARK: - Screen

	enum Screen {
		static let half: CGFloat = 2
		static let week: CGFloat = 7
		static let heightCell: CGFloat = half * week
		static let collectionView: CGFloat = 8
		static let iconImageView: CGFloat = 0.35
		static let highTempLabel: CGFloat = 0.5
		static let lowTempLabel: CGFloat = 0.75
	}
}
