//
//  MainView.swift
//  Gismeteo
//
//  Created by Constantin on 29.11.2023.
//

import UIKit

// MARK: - IMainView

protocol IMainView: UIView {
	var delegate: IMainViewDelegate? { get set }

	func reloadData(viewModel: MainModel.ViewModel)
}

// MARK: - IMainViewDelegate

protocol IMainViewDelegate: AnyObject {
	func fetchWeatherData()
	func tappedToFindScene()
	func tappedToAddScene()
	func tappedToGoBack()
}

// MARK: - MainView

final class MainView: UIView, IMainView {
	// MARK: - Internal properties

	let carouselView = Factory.shared.createCarouselView()
	let isMain: Bool
	weak var delegate: IMainViewDelegate?

	// MARK: - Private properties

	private let listButton = Factory.shared.createButton(L10n.SystemImage.list)
	private let plusButton = Factory.shared.createButton(L10n.SystemImage.plus)
	private let multiplyButton = Factory.shared.createButton(L10n.SystemImage.multiply)
	private let gradientLayer = Factory.shared.createGradientLayer()
	private var mainViews = [UIView]()
	private var weatherModels = [WeatherModel]()

	// MARK: - Life Cycle

	init(isMain: Bool) {
		self.isMain = isMain
		super.init(frame: .zero)
		setupView()
		hide()
	}

	required init?(coder _: NSCoder) {
		fatalError(L10n.FatalError.required)
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		gradientLayer.frame = bounds
	}

	// MARK: - Actions

	@objc func listButtonTapped() {
		delegate?.tappedToFindScene()
	}

	@objc func plusButtonTapped() {
		delegate?.tappedToAddScene()
	}

	@objc func multiplyButtonTapped() {
		delegate?.tappedToGoBack()
	}

	// MARK: - Internal methods

	func reloadData(viewModel: MainModel.ViewModel) {
		mainViews.removeAll()
		weatherModels.removeAll()

		viewModel.weatherModel.forEach { weatherModel in
			weatherModels.append(weatherModel)
		}

		DispatchQueue.main.async { [weak self] in
			self?.updateView()
		}
	}

	// MARK: - Private methods

	private func updateView() {
		weatherModels.forEach { weatherModel in
			mainViews.append(HomeView(weather: weatherModel))
		}
		carouselView.setViews(mainViews)
	}

	private func setupView() {
		layer.insertSublayer(gradientLayer, at: UInt32.zero)
		backgroundColor = Theme.backgroundColor

		listButton.addTarget(self, action: #selector(listButtonTapped), for: .touchUpInside)
		plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
		multiplyButton.addTarget(self, action: #selector(multiplyButtonTapped), for: .touchUpInside)

		addSubviews([
			carouselView,
			listButton,
			plusButton,
			multiplyButton
		])

		NSLayoutConstraint.activate([
			carouselView.leadingAnchor.constraint(equalTo: leadingAnchor),
			carouselView.trailingAnchor.constraint(equalTo: trailingAnchor),
			carouselView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			carouselView.bottomAnchor.constraint(equalTo: bottomAnchor),

			listButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Sizes.Medium.padding),
			listButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Sizes.Medium.padding),

			multiplyButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Sizes.Medium.padding),
			multiplyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.Medium.padding),

			plusButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Sizes.Medium.padding),
			plusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Sizes.Medium.padding)
		])

		updateView()
	}

	func hide() {
		listButton.isHidden = !isMain
		carouselView.setPageControlisHidden(isHidden: !isMain)

		plusButton.isHidden = isMain
		multiplyButton.isHidden = isMain

		if !isMain {
			let cities = Repository.shared.cities
			if let city = Repository.shared.city {
				plusButton.isHidden = cities.contains(city)
			}
		}
	}
}
