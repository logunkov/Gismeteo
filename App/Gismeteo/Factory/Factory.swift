//
//  Factory.swift
//  Gismeteo
//
//  Created by Constantin on 24.11.2023.
//

import UIKit

// MARK: - Factory

final class Factory {

	// MARK: - Internal properties

	static let shared = Factory()

	// MARK: - Lifecycle

	private init() {}

	// MARK: - Internal methods

	func createGradientLayer() -> CAGradientLayer {
		let gradientLayer = CAGradientLayer()
		gradientLayer.colors = [Theme.Gradient.startColor.cgColor, Theme.Gradient.endColor.cgColor]
		gradientLayer.startPoint = Sizes.Gradient.startPoint
		gradientLayer.endPoint = Sizes.Gradient.endPoint

		return gradientLayer
	}

	func createImageView() -> UIImageView {
		let imageView = UIImageView()
		imageView.backgroundColor = .gray // ??
		imageView.clipsToBounds = true
		imageView.translatesAutoresizingMaskIntoConstraints = false

		return imageView
	}

	func createLabel(_ textStyle: UIFont.TextStyle) -> UILabel {
		let label = UILabel()
		label.textColor = Theme.white
		label.font = UIFont.preferredFont(forTextStyle: textStyle)
		label.translatesAutoresizingMaskIntoConstraints = false

		return label
	}

	func createVerticalStackView() -> UIStackView {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.spacing = Sizes.Medium.halfPadding
		stackView.translatesAutoresizingMaskIntoConstraints = false

		return stackView
	}

	func createHorizontalStackView() -> UIStackView {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .center
		stackView.spacing = Sizes.Medium.halfPadding
		stackView.translatesAutoresizingMaskIntoConstraints = false

		return stackView
	}

	func createScrollView() -> UIScrollView {
		let scrollView = UIScrollView(frame: .zero)
		scrollView.bounces = false
		scrollView.isPagingEnabled = true
		scrollView.showsVerticalScrollIndicator = false
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.translatesAutoresizingMaskIntoConstraints = false

		return scrollView
	}

	func createTableView() -> UITableView {
		let tableView = UITableView(frame: .zero, style: .grouped)
		tableView.contentInset = Sizes.Table.contentInset
		tableView.backgroundColor = Theme.backgroundColor
		tableView.layer.cornerRadius = Sizes.Medium.cornerRadius
		tableView.isScrollEnabled = false
		tableView.allowsSelection = false
		tableView.translatesAutoresizingMaskIntoConstraints = false

		return tableView
	}

	func createLayout() -> UICollectionViewFlowLayout {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = Sizes.Table.spacing
		layout.minimumInteritemSpacing = Sizes.Table.spacing
		layout.sectionInsetReference = .fromContentInset

		return layout
	}

	func createCollectionView(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) -> UICollectionView {
		let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
		collectionView.backgroundColor = Theme.backgroundColor
		collectionView.layer.cornerRadius = Sizes.Medium.cornerRadius
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.translatesAutoresizingMaskIntoConstraints = false

		return collectionView
	}

	func createPageControl() -> UIPageControl {
		let pageControl = UIPageControl()
		pageControl.pageIndicatorTintColor = Theme.gray
		pageControl.currentPageIndicatorTintColor = Theme.black
		pageControl.backgroundColor = Theme.white
		pageControl.alpha = Sizes.PageControl.alpha
		pageControl.layer.cornerRadius = Sizes.PageControl.cornerRadius
		pageControl.translatesAutoresizingMaskIntoConstraints = false

		return pageControl
	}
}
