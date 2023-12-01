//
//  HeaderView.swift
//  Gismeteo
//
//  Created by Constantin on 24.11.2023.
//

import UIKit

// MARK: - HeaderView

final class HeaderView: UIView {
	// MARK: - Private properties

	private let locationNameLabel = Factory.shared.createLabel(.largeTitle)
	private let descriptionLabel = Factory.shared.createLabel(.headline)
	private let currentTempLabel = Factory.shared.createLabel(.largeTitle)
	private let lowTempLabel = Factory.shared.createLabel(.headline)
	private let highTempLabel = Factory.shared.createLabel(.headline)
	private var weather: WeatherModel?

	// MARK: - Lifecycle

	init(weather: WeatherModel?) {
		super.init(frame: .zero)
		self.weather = weather

		setupView()
		upgradeView()
	}

	required init?(coder _: NSCoder) {
		fatalError(L10n.FatalError.required)
	}

	// MARK: - Private methods

	private func setupView() {
		currentTempLabel.font = UIFont.systemFont(ofSize: Sizes.Font.headerView)
		let mainStackView = Factory.shared.createVerticalStackView()
		let stackView = Factory.shared.createHorizontalStackView()

		addSubview(mainStackView)
		mainStackView.addArrangedSubviews([
			locationNameLabel,
			currentTempLabel,
			descriptionLabel,
			stackView
		])

		stackView.addArrangedSubviews([
			highTempLabel,
			lowTempLabel
		])

		NSLayoutConstraint.activate([
			mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			mainStackView.topAnchor.constraint(equalTo: topAnchor),
			mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}

	private func upgradeView() {
		guard let weather else { return }

		guard let currentWeather = weather.current.weather.first,
		      let dailytWeather = weather.daily.first else { return }

		locationNameLabel.text = weather
			.timezone.deletingPrefix()
			.replacingOccurrences(of: L10n.StringS.replacing, with: L10n.StringS.space)

		currentTempLabel.text = String(format: L10n.StringS.format, weather.current.temp) + L10n.StringS.scale
		descriptionLabel.text = currentWeather.description.firstCapitalized
		lowTempLabel.text = L10n.StringS.min
			+ String(format: L10n.StringS.format, dailytWeather.temp.min)
			+ L10n.StringS.scale

		highTempLabel.text = L10n.StringS.max
			+ String(format: L10n.StringS.format, dailytWeather.temp.max)
			+ L10n.StringS.scalePlus
	}
}
