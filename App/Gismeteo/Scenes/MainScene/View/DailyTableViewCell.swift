//
//  DailyTableViewCell.swift
//  Gismeteo
//
//  Created by Constantin on 25.11.2023.
//

import UIKit

// MARK: - DailyTableViewCellViewModel

struct DailyTableViewCellViewModel {
	let dayLabelString: String?
	let highTempLabelString: String?
	let lowTempLabelString: String?
	let urlString: String?
	let iconImage: UIImage?
}

// MARK: - DailyTableViewCell

final class DailyTableViewCell: UITableViewCell {
	// MARK: - Private properties

	private let stackView = Factory.shared.createHorizontalStackView()
	private let dayLabel = Factory.shared.createLabel(.headline)
	private let iconImageView = Factory.shared.createImageView()
	private let highTempLabel = Factory.shared.createLabel(.headline)
	private let lowTempLabel = Factory.shared.createLabel(.headline)
	private var weatherModel: WeatherModel?

	// MARK: - Life Cycle

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupView()
	}

	required init?(coder _: NSCoder) {
		fatalError(L10n.FatalError.required)
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		iconImageView.image = nil
	}

	// MARK: - Internal methods

	func configure(model: WeatherModel) {
		weatherModel = model
	}

	func configureTableViewCellViewModelFor(_ index: Int) -> DailyTableViewCellViewModel {
		var dayLabelString: String?
		var highTempLabelString: String?
		var lowTempLabelString: String?
		let iconImage = UIImage()
		var urlString: String?

		if let weatherModel = weatherModel {
			let dailyModel = weatherModel.daily[index + 1]
			dayLabelString = Date(timeIntervalSince1970: Double(dailyModel.dt)).getDayForDate()
			highTempLabelString =
				L10n.StringS.max
					+ String(format: L10n.StringS.format, dailyModel.temp.max)
					+ L10n.StringS.scalePlus

			lowTempLabelString =
				L10n.StringS.min
					+ String(format: L10n.StringS.format, dailyModel.temp.min)
					+ L10n.StringS.scale

			urlString = L10n.WeatherAPI.urlString + dailyModel.weather[0].icon + L10n.WeatherAPI.image
			iconImageView.downloaded(from: urlString ?? L10n.StringS.space)
		}
		return DailyTableViewCellViewModel(
			dayLabelString: dayLabelString,
			highTempLabelString: highTempLabelString,
			lowTempLabelString: lowTempLabelString,
			urlString: urlString,
			iconImage: iconImage
		)
	}

	func setupCell(_ viewModel: DailyTableViewCellViewModel) {
		dayLabel.text = viewModel.dayLabelString
		highTempLabel.text = viewModel.highTempLabelString
		lowTempLabel.text = viewModel.lowTempLabelString
		iconImageView.image = viewModel.iconImage
	}

	// MARK: - Private methods

	private func setupView() {
		backgroundColor = Theme.backgroundColor

		addSubviews([
			dayLabel,
			iconImageView,
			highTempLabel,
			lowTempLabel
		])

		let width = UIScreen.main.bounds.width
		let height = UIScreen.main.bounds.height

		NSLayoutConstraint.activate([
			dayLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.Medium.padding),

			iconImageView.centerXAnchor.constraint(equalTo: leadingAnchor, constant: width * Sizes.Screen.iconImageView),
			iconImageView.heightAnchor.constraint(equalToConstant: height / Sizes.Screen.heightCell),

			highTempLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			highTempLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: width * Sizes.Screen.highTempLabel),

			lowTempLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			lowTempLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: width * Sizes.Screen.lowTempLabel)
		])
	}
}
