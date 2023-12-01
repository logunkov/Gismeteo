//
//  HomeView.swift
//  Gismeteo
//
//  Created by Constantin on 25.11.2023.
//

import UIKit

// MARK: - HomeView

final class HomeView: UIView {
	// MARK: - Private properties

	private let headerView: HeaderView
	private let screen = UIScreen.main.bounds
	private let layout = Factory.shared.createLayout()
	private let tableView = Factory.shared.createTableView()
	private let scrollView = Factory.shared.createScrollView()
	private let mainStackView = Factory.shared.createVerticalStackView()
	private var weatherModel: WeatherModel?
	private lazy var tableCellHieght = screen.height / Sizes.Screen.heightCell

	private lazy var tableHieght = tableCellHieght * Sizes.Screen.week

	private lazy var collectionView = Factory.shared.createCollectionView(frame: bounds, collectionViewLayout: layout)

	// MARK: - Life Cycle

	init(weather: WeatherModel?) {
		weatherModel = weather
		headerView = HeaderView(weather: weather)
		super.init(frame: .zero)

		setupView()
		setupConstraint()
	}

	required init?(coder _: NSCoder) {
		fatalError(L10n.FatalError.required)
	}

	// MARK: - Private methods

	private func setupView() {
		scrollView.isOpaque = false
		scrollView.addSubview(mainStackView)
		scrollView.contentSize = mainStackView.bounds.size

		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(DailyTableViewCell.self, forCellReuseIdentifier: L10n.Cell.dailyTableView)

		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: L10n.Cell.hourlyCollectionView)
	}

	private func setupConstraint() {
		addSubview(scrollView)

		mainStackView.addArrangedSubviews([
			headerView,
			collectionView,
			tableView
		])

		NSLayoutConstraint.activate([
			scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
			scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

			mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			mainStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
			mainStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

			collectionView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: Sizes.Medium.halfPadding),
			collectionView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -Sizes.Medium.halfPadding),
			collectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: screen.height / Sizes.Screen.collectionView),

			tableView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: Sizes.Medium.halfPadding),
			tableView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -Sizes.Medium.halfPadding),
			tableView.heightAnchor.constraint(greaterThanOrEqualToConstant: tableHieght)
		])
	}
}

// MARK: UITableViewDataSource

extension HomeView: UITableViewDataSource {
	// MARK: - Internal methods

	func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
		Int(Sizes.Screen.week)
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: L10n.Cell.dailyTableView,
			for: indexPath
		) as? DailyTableViewCell
		else {
			fatalError(L10n.FatalError.cell)
		}

		if let weatherModel = weatherModel {
			cell.configure(model: weatherModel)
		}

		let viewModel = cell.configureTableViewCellViewModelFor(indexPath.row)
		cell.setupCell(viewModel)

		return cell
	}
}

// MARK: UITableViewDelegate

extension HomeView: UITableViewDelegate {
	// MARK: - Internal methods

	func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
		tableCellHieght
	}
}

// MARK: UICollectionViewDataSource

extension HomeView: UICollectionViewDataSource {
	// MARK: - Internal methods

	func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
		Sizes.Collection.hoursDay
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView
			.dequeueReusableCell(
				withReuseIdentifier: L10n.Cell.hourlyCollectionView,
				for: indexPath
			) as? HourlyCollectionViewCell
		else {
			fatalError(L10n.FatalError.cell)
		}

		if let weatherModel = weatherModel {
			cell.configure(model: weatherModel)

			let viewModel = cell.configureCollectionCellViewModelFor(indexPath.row)

			cell.setupCell(viewModel)
		}

		return cell
	}
}

// MARK: UICollectionViewDelegateFlowLayout

extension HomeView: UICollectionViewDelegateFlowLayout {
	// MARK: - Internal methods

	func collectionView(
		_: UICollectionView,
		layout _: UICollectionViewLayout,
		sizeForItemAt _: IndexPath
	) -> CGSize {
		let height = screen.height / Sizes.Screen.collectionView
		return CGSize(
			width: height * Sizes.Collection.widthtMultiplier,
			height: height * Sizes.Collection.heightMultiplier
		)
	}
}
