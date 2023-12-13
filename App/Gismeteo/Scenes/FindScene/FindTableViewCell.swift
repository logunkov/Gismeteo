//
//  FindTableViewCell.swift
//  Gismeteo
//
//  Created by Constantin on 04.12.2023.
//

import UIKit

// MARK: - FindTableViewCell

final class FindTableViewCell: UITableViewCell {
	// MARK: - Private properties

	private let locationNameLabel = Factory.shared.createLabel(.largeTitle)
	private let descriptionLabel = Factory.shared.createLabel(.headline)
	private let currentTempLabel = Factory.shared.createLabel(.largeTitle)
	private let lowTempLabel = Factory.shared.createLabel(.headline)
	private let highTempLabel = Factory.shared.createLabel(.headline)
	private var weatherModel: WeatherModel?

	// MARK: - Life Cycle

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupView()
		setupConstraint()
	}

	required init?(coder _: NSCoder) {
		fatalError(L10n.FatalError.required)
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = Sizes.Medium.cornerRadius
	}

	// MARK: - Internal methods

	func upgradeView(weather: WeatherModel) {
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

	// MARK: - Private methods

	private func setupView() {
		layer.cornerRadius = Sizes.Medium.cornerRadius
		selectionStyle = .none
		backgroundColor = Theme.backgroundColor
	}

	private func setupConstraint() {
		let stackView = Factory.shared.createHorizontalStackView()
		addSubviews([
			locationNameLabel,
			descriptionLabel,
			currentTempLabel,
			stackView
		])

		stackView.addArrangedSubviews([
			highTempLabel,
			lowTempLabel
		])

		NSLayoutConstraint.activate([
			locationNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.Medium.halfPadding),
			locationNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Sizes.Medium.halfPadding),

			descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.Medium.halfPadding),
			descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Sizes.Medium.halfPadding),

			currentTempLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Sizes.Medium.halfPadding),
			currentTempLabel.topAnchor.constraint(equalTo: topAnchor, constant: Sizes.Medium.halfPadding),

			stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Sizes.Medium.halfPadding),
			stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Sizes.Medium.halfPadding)
		])
	}
}
