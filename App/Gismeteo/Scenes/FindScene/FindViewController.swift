//
//  FindViewController.swift
//  Gismeteo
//
//  Created by Constantin on 04.12.2023.
//

import UIKit

// MARK: - IFindViewControllerDelegate

protocol IFindViewControllerDelegate: AnyObject {
	func didCloseToFindScene(index: Int, weatherModels: [WeatherModel])
}

// MARK: - IFindViewController

protocol IFindViewController: AnyObject {
	func removeWeatherModel(index: Int)
	func routeToGoBack(index: Int, weatherModels: [WeatherModel])
	func routeToCityScene()
	func routeToAlert(viewModel: FindModel.ViewModel)
}

// MARK: - FindViewController

final class FindViewController: UIViewController {
	// MARK: - Internal Properties

	var interactor: IFindInteractor?
	var router: IFindRouter?
	weak var delegate: IFindViewControllerDelegate?
	var weatherModels = [WeatherModel]()

	// MARK: - Private Properties

	private let findView: IFindView

	// MARK: - Lifecycle

	init(findView: IFindView, weatherModel: [WeatherModel]) {
		self.findView = findView
		weatherModels = weatherModel
		super.init(nibName: nil, bundle: nil)
		findView.reloadData(weatherModel: weatherModel)
	}

	required init?(coder _: NSCoder) {
		fatalError(L10n.FatalError.required)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}

	// MARK: - Private methods

	private func setupView() {
		view = findView
		findView.delegate = self
		navigationController?.setNavigationBarHidden(true, animated: true)
	}
}

// MARK: IFindViewController

extension FindViewController: IFindViewController {
	// MARK: - Internal methods

	func removeWeatherModel(index: Int) {
		weatherModels.remove(at: index)
	}

	func routeToGoBack(index: Int, weatherModels: [WeatherModel]) {
		guard let delegate else { return }
		router?.routeToGoBack(index: index, weatherModels: weatherModels, delegate: delegate)
	}

	func routeToCityScene() {
		guard let viewController = MainAssembler().assembly(isMain: false) as? MainViewController else { return }
		viewController.delegate = self
		router?.routeToCityScene(viewController: viewController)
	}

	func routeToAlert(viewModel: FindModel.ViewModel) {
		router?.routeToAlert(viewModel: viewModel)
	}
}

// MARK: IFindViewDelegate

extension FindViewController: IFindViewDelegate {
	// MARK: - Internal methods

	func goBack(index: Int, weatherModels: [WeatherModel]) {
		interactor?.goBack(index: index, weatherModels: weatherModels)
	}

	func fetchCityData(city: String) {
		let request = FindModel.Request(findCity: city)
		interactor?.fetchCityData(request: request)
	}

	func remove(index: Int) {
		interactor?.remove(index: index)
	}
}

// MARK: IMainViewControllerDelegate

extension FindViewController: IMainViewControllerDelegate {
	// MARK: - Internal methods

	func didCloseToCityScene(weatherModel: WeatherModel) {
		weatherModels.append(weatherModel)
		findView.reloadData(weatherModel: weatherModels)
	}
}
