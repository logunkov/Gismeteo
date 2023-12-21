//
//  MainViewController.swift
//  Gismeteo
//
//  Created by Constantin on 29.11.2023.
//

import UIKit

// MARK: - IMainViewControllerDelegate

protocol IMainViewControllerDelegate: AnyObject {
	func didCloseToCityScene(weatherModel: WeatherModel)
}

// MARK: - IMainViewController

protocol IMainViewController: AnyObject {
	func render(viewModel: MainModel.ViewModel)
	func routeToFindScene()
	func routeToGoBack()
	func routeToGoBackWithWeatherModel()
}

// MARK: - MainViewController

final class MainViewController: UIViewController {
	// MARK: - Internal Properties

	let isMain: Bool
	var interactor: IMainInteractor?
	var router: IMainRouter?
	weak var delegate: IMainViewControllerDelegate?

	// MARK: - Private Properties

	private let mainView: IMainView
	private var cities = [City]()
	private var viewModel: MainModel.ViewModel?

	// MARK: - Life Cycle

	init(mainView: IMainView, isMain: Bool) {
		self.mainView = mainView
		self.isMain = isMain
		super.init(nibName: nil, bundle: nil)
		self.mainView.delegate = self
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
		view = mainView
		navigationController?.setNavigationBarHidden(true, animated: true)

		if isMain {
			cities.append(contentsOf: Repository.shared.cities)
		} else {
			if let city = Repository.shared.city {
				cities.append(city)
			}
		}

		fetchWeatherData()
	}
}

// MARK: IMainViewController

extension MainViewController: IMainViewController {
	// MARK: - Internal methods

	func render(viewModel: MainModel.ViewModel) {
		self.viewModel = viewModel
		mainView.reloadData(viewModel: viewModel)
	}

	func routeToFindScene() {
		guard let weatherModel = viewModel?.weatherModel else { return }
		guard let viewController = FindAssembler().assembly(weatherModel: weatherModel) as? FindViewController else { return }
		viewController.delegate = self
		router?.routeToFindScene(viewController: viewController)
	}

	func routeToGoBack() {
		router?.routeToGoBack()
	}

	func routeToGoBackWithWeatherModel() {
		guard let weatherModel = viewModel?.weatherModel.first, let delegate else { return }
		router?.routeToGoBackWithWeatherModel(weatherModel: weatherModel, delegate: delegate)
	}
}

// MARK: IMainViewDelegate

extension MainViewController: IMainViewDelegate {
	// MARK: - Internal methods

	func fetchWeatherData() {
		let request = MainModel.Request(cities: cities)
		interactor?.fetchWeatherData(request: request)
	}

	func tappedToFindScene() {
		interactor?.tappedToFindScene()
	}

	func tappedToAddScene() {
		interactor?.tappedToAddScene()
	}

	func tappedToGoBack() {
		interactor?.tappedToGoBack()
	}
}

// MARK: IFindViewControllerDelegate

extension MainViewController: IFindViewControllerDelegate {
	// MARK: - Internal methods

	func didCloseToFindScene(index: Int, weatherModels: [WeatherModel]) {
		guard let mainView = mainView as? MainView else { return }
		viewModel = MainModel.ViewModel(weatherModel: weatherModels)

		guard let viewModel else { return }
		mainView.reloadData(viewModel: viewModel)

		let carouselView = mainView.carouselView
		carouselView.setContentOffset(index: index)
	}
}
