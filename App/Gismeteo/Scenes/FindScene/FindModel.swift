//
//  FindModel.swift
//  Gismeteo
//
//  Created by Constantin on 11.12.2023.
//

// MARK: - FindModel

enum FindModel {
	// MARK: - Request

	struct Request {
		var findCity: String
	}

	// MARK: - Response

	struct Response {
		var city: CityModel?
		var error: ErrorModel?
	}

	// MARK: - ViewModel

	struct ViewModel {
		var city: CityModel?
		var error: ErrorModel?
	}
}
