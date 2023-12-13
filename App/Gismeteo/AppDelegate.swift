//
//  AppDelegate.swift
//  Gismeteo
//
//  Created by Constantin on 22.11.2023.
//

import CoreLocation
import UIKit

// MARK: - AppDelegate

@main

final class AppDelegate: UIResponder, UIApplicationDelegate { private let locationManager = CLLocationManager()

	// MARK: - Internal methods

	func application(
		_: UIApplication,
		didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		setupLocationManager()
		setupRepository()

		return true
	}

	// MARK: - Private methods

	private func setupLocationManager() {
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
	}

	private func setupRepository() {
		Repository.shared.loadBackup()
	}
}

// MARK: CLLocationManagerDelegate

extension AppDelegate: CLLocationManagerDelegate {
	// MARK: - Internal methods

	func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.last else { return }
		locationManager.stopUpdatingLocation()
		let latitude = location.coordinate.latitude
		let longitude = location.coordinate.longitude
		Repository.shared.setLocation(latitude: latitude, longitude: longitude)
	}

	func locationManager(_: CLLocationManager, didFailWithError _: Error) {}
}
