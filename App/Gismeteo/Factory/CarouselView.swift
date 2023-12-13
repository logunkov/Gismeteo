//
//  CarouselView.swift
//  Gismeteo
//
//  Created by Constantin on 29.11.2023.
//

import UIKit

// MARK: - CarouselView

final class CarouselView: UIView {
	// MARK: - Private properties

	private let carouselBounds = UIScreen.main.bounds
	private let pageControl = Factory.shared.createPageControl()
	private let scrollView = Factory.shared.createScrollView()
	private var carouselViews = [UIView]()

	// MARK: - Life Cycle

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder _: NSCoder) {
		fatalError(L10n.FatalError.required)
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		let imageWidth: CGFloat = carouselBounds.width
		let imageHeight: CGFloat = carouselBounds.height * Sizes.CarouselView.screenMultiplier

		for (index, imageView) in carouselViews.enumerated() {
			let xPosition = imageWidth * CGFloat(index)
			imageView.frame = CGRect(x: xPosition, y: .zero, width: imageWidth, height: imageHeight)
		}

		scrollView.frame = carouselBounds
		scrollView.contentSize = CGSize(width: imageWidth * CGFloat(carouselViews.count), height: imageHeight)
	}

	// MARK: - Internal methods

	func setViews(_ views: [UIView]) {
		for carouselView in carouselViews {
			carouselView.removeFromSuperview()
		}
		carouselViews.removeAll()

		for view in views {
			carouselViews.append(view)
			scrollView.addSubview(view)
		}

		pageControl.numberOfPages = views.count
		if pageControl.numberOfPages != Int.zero {
			pageControl.setIndicatorImage(UIImage(systemName: L10n.SystemImage.location), forPage: Int.zero)
		}

		layoutSubviews()
	}

	func setContentOffset(index: Int) {
		let pageWidth = carouselBounds.width
		let contentOffset = CGPoint(x: pageWidth * CGFloat(index), y: CGFloat.zero)
		scrollView.setContentOffset(contentOffset, animated: true)
		scrollViewDidScroll(scrollView)
	}

	func setPageControlisHidden(isHidden: Bool) {
		pageControl.isHidden = isHidden
	}

	// MARK: - Private methods

	private func setupView() {
		scrollView.delegate = self

		addSubviews([
			scrollView,
			pageControl
		])

		NSLayoutConstraint.activate([
			pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Sizes.Medium.padding),
			pageControl.centerXAnchor.constraint(equalTo: centerXAnchor)
		])
	}
}

// MARK: UIScrollViewDelegate

extension CarouselView: UIScrollViewDelegate {
	// MARK: - Internal methods

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let pageIndex = round(scrollView.contentOffset.x / carouselBounds.width)
		pageControl.currentPage = Int(pageIndex)
	}
}
