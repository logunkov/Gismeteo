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
	func routeToCityScene(viewModel: FindModel.ViewModel)
	func routeToAlert(viewModel: FindModel.ViewModel)
}

// MARK: - FindViewController

final class FindViewController: UIViewController {
	// MARK: - Internal Properties

	var interactor: IFindInteractor?
	weak var delegate: IFindViewControllerDelegate?

	// MARK: - Private Properties

	private let findView: IFindView
	private var weatherModels = [WeatherModel]()

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
		dismiss(animated: true) {
			self.delegate?.didCloseToFindScene(index: index, weatherModels: weatherModels)
		}
	}

	func routeToCityScene(viewModel _: FindModel.ViewModel) {
		guard let viewController = MainAssembler().assembly(isMain: false) as? MainViewController else { return }
		viewController.delegate = self
		present(viewController, animated: true)
	}

	func routeToAlert(viewModel: FindModel.ViewModel) {
		guard let message = viewModel.error?.message else { return }
		let alert = Factory.shared.createAlert(message: message.firstCapitalized)
		present(alert, animated: true, completion: nil)
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
