//
//  MainModel.swift
//  Gismeteo
//
//  Created by Constantin on 01.12.2023.
//

import CoreLocation

// MARK: - MainModel

enum MainModel {
	// MARK: - Request

	struct Request {
		var cities: [City]
	}

	// MARK: - Response

	struct Response {
		var weatherModel: [WeatherModel]
	}

	// MARK: - ViewModel

	struct ViewModel: Codable {
		var weatherModel: [WeatherModel]
	}
}
