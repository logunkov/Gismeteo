//
//  FindView.swift
//  Gismeteo
//
//  Created by Constantin on 04.12.2023.
//

import UIKit

// MARK: - IFindView

protocol IFindView: UIView {
	var delegate: IFindViewDelegate? { get set }

	func reloadData(weatherModel: [WeatherModel])
}

// MARK: - IFindViewDelegate

protocol IFindViewDelegate: AnyObject {
	func goBack(index: Int, weatherModels: [WeatherModel])
	func fetchCityData(city: String)
	func remove(index: Int)
}

// MARK: - FindView

final class FindView: UIView {
	// MARK: - Internal properties

	weak var delegate: IFindViewDelegate?

	// MARK: - Private properties

	private let gradientLayer = Factory.shared.createGradientLayer()
	private let textField = Factory.shared.createTextField()
	private let tableView = Factory.shared.createTableView()
	private var weatherModels = [WeatherModel]()

	// MARK: - Life Cycle

	init() {
		super.init(frame: .zero)
		setupView()
		setupConstraint()
	}

	required init?(coder _: NSCoder) {
		fatalError(L10n.FatalError.required)
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		gradientLayer.frame = bounds
	}

	// MARK: - Private methods

	private func setupView() {
		backgroundColor = Theme.backgroundColor
		layer.insertSublayer(gradientLayer, at: UInt32.zero)

		textField.delegate = self

		tableView.backgroundColor = .clear
		tableView.allowsSelection = true
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(
			FindTableViewCell.self,
			forCellReuseIdentifier: L10n.Cell.findTableView
		)
		tableView.isScrollEnabled = true
		tableView.sectionHeaderHeight = Sizes.Table.sectionHeaderHeight
		tableView.sectionFooterHeight = Sizes.Table.sectionFooterHeight
		tableView.separatorStyle = .none
	}

	private func setupConstraint() {
		addSubviews([
			textField,
			tableView
		])

		NSLayoutConstraint.activate([
			textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Sizes.Medium.padding),
			textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Sizes.Medium.padding),
			textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Sizes.Medium.padding),
			textField.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -Sizes.Medium.padding),

			tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Sizes.Medium.padding),
			tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Sizes.Medium.padding),
			tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Sizes.Medium.padding)
		])
	}
}

// MARK: IFindView

extension FindView: IFindView {
	// MARK: - Internal methods

	func reloadData(weatherModel: [WeatherModel]) {
		weatherModels.removeAll()

		weatherModel.forEach { weatherModel in
			weatherModels.append(weatherModel)
		}

		DispatchQueue.main.async { [weak self] in
			self?.tableView.reloadData()
		}
	}
}

// MARK: UITableViewDataSource

extension FindView: UITableViewDataSource {
	// MARK: - Internal methods

	func numberOfSections(in _: UITableView) -> Int {
		weatherModels.count
	}

	func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
		Sizes.Table.section
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: L10n.Cell.findTableView,
			for: indexPath
		) as? FindTableViewCell
		else {
			fatalError(L10n.FatalError.cell)
		}
		cell.upgradeView(weather: weatherModels[indexPath.section])
		return cell
	}

	func tableView(_: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		indexPath.section != Int.zero
	}
}

// MARK: UITableViewDelegate

extension FindView: UITableViewDelegate {
	// MARK: - Internal methods

	func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
		Sizes.Table.heightsection
	}

	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
		-> UISwipeActionsConfiguration? {
		let deleteAction = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, _ in
			guard let self else { return }
			let index = indexPath.section
			self.weatherModels.remove(at: index)
			self.delegate?.remove(index: index)
			tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
		}

		let largeConfig = UIImage.SymbolConfiguration(pointSize: Sizes.Font.action, weight: .bold, scale: .large)
		deleteAction.image = UIImage(
			systemName: L10n.SystemImage.trash,
			withConfiguration: largeConfig
		)?.withTintColor(Theme.white, renderingMode: .alwaysTemplate)
			.addBackgroundCircle(Theme.red)
		deleteAction.backgroundColor = Theme.red.withAlphaComponent(CGFloat.zero)
		let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
		return configuration
	}

	func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
		delegate?.goBack(index: indexPath.section, weatherModels: weatherModels)
	}
}

// MARK: UITextFieldDelegate

extension FindView: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.endEditing(true)
		return true
	}

	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		if textField.text != L10n.StringS.empty {
			return true
		} else {
			return false
		}
	}

	func textFieldDidEndEditing(_ textField: UITextField) {
		if let findCity = textField.text {
			delegate?.fetchCityData(city: findCity)
			textField.text = L10n.StringS.empty
		}
	}
}
