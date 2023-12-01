//
//  HourlyCollectionViewCell.swift
//  Gismeteo
//
//  Created by Constantin on 28.11.2023.
//

import UIKit

// MARK: - HourlyCollectionViewCellViewModel

struct HourlyCollectionViewCellViewModel {
	let timeLabelString: String?
	let tempLabelString: String?
	let urlString: String?
	let iconImage: UIImage?
}

// MARK: - HourlyCollectionViewCell

final class HourlyCollectionViewCell: UICollectionViewCell {
	// MARK: - Private properties

	private let stackView = Factory.shared.createVerticalStackView()
	private let tempLabel = Factory.shared.createLabel(.headline)
	private let timeLabel = Factory.shared.createLabel(.headline)
	private let iconImageView = Factory.shared.createImageView()
	private var weatherModel: WeatherModel?

	// MARK: - Life Cycle

	override init(frame: CGRect) {
		super.init(frame: frame)
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

	func setupCell(_ viewModel: HourlyCollectionViewCellViewModel) {
		if viewModel.timeLabelString == L10n.StringS.now {
			timeLabel.text = L10n.StringS.now
			tempLabel.text = viewModel.tempLabelString
		} else {
			timeLabel.text = viewModel.timeLabelString
			tempLabel.text = viewModel.tempLabelString
		}

		if viewModel.iconImage != nil {
			iconImageView.image = viewModel.iconImage
		} else {
			iconImageView.downloaded(from: viewModel.urlString ?? L10n.StringS.space)
		}
	}

	func configure(model: WeatherModel) {
		weatherModel = model
	}

	func configureCollectionCellViewModelFor(_ index: Int) -> HourlyCollectionViewCellViewModel {
		var tempLabelString: String?
		var timeLabelString: String?
		var iconImage: UIImage?
		var urlStringForImage: String?

		if let weatherModel = weatherModel {
			let hourlyModel = weatherModel.hourly[index]
			let hourForDate = Date(timeIntervalSince1970: Double(hourlyModel.dt)).getHourForDate()
			let nextHourForDate = Date(timeIntervalSince1970: Double(weatherModel.hourly[index + 1].dt)).getTimeForDate()
			let timeForDate = Date(timeIntervalSince1970: Double(hourlyModel.dt)).getTimeForDate()
			let sunset = Date(timeIntervalSince1970: Double(weatherModel.current.sunset)).getTimeForDate()
			let sunrise = Date(timeIntervalSince1970: Double(weatherModel.current.sunrise)).getTimeForDate()
			urlStringForImage = L10n.WeatherAPI.hostImage + (hourlyModel.weather[0].icon) + L10n.WeatherAPI.image

			if index == Int.zero {
				timeLabelString = L10n.StringS.now
				iconImage = nil
				tempLabelString = String(format: L10n.StringS.format, weatherModel.hourly[index].temp) + L10n.StringS.scale
			} else {
				if sunset >= timeForDate && sunset < nextHourForDate {
					tempLabelString = L10n.StringS.sunset
					iconImage = Asset.Sun.sunset.image
					timeLabelString = sunset
				} else if sunrise >= timeForDate && sunrise < nextHourForDate {
					tempLabelString = L10n.StringS.sunrise
					iconImage = Asset.Sun.sunrise.image
					timeLabelString = sunrise
				} else {
					iconImage = nil
					tempLabelString = String(format: L10n.StringS.format, weatherModel.hourly[index].temp) + L10n.StringS.scale
					timeLabelString = hourForDate
				}
			}
		}
		return HourlyCollectionViewCellViewModel(
			timeLabelString: timeLabelString,
			tempLabelString: tempLabelString,
			urlString: urlStringForImage,
			iconImage: iconImage
		)
	}

	// MARK: - Private methods

	private func setupView() {
		backgroundColor = Theme.backgroundColor

		stackView.spacing = CGFloat.zero
		stackView.distribution = .equalSpacing

		contentView.addSubview(stackView)
		stackView.addArrangedSubviews([
			timeLabel,
			iconImageView,
			tempLabel
		])

		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
			stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}
}
