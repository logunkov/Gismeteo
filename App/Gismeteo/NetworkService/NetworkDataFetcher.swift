//
//  NetworkDataFetcher.swift
//  Gismeteo
//
//  Created by Constantin on 24.11.2023.
//

import Foundation

// MARK: - NetworkDataFetcher

final class NetworkDataFetcher {
	// MARK: - Private properties

	private let jsonDecoder = JSONDecoder()

	// MARK: - Internal methods

	func fetchData<T: Codable>(urlString: String, completion: @escaping (T?) -> Void) {
		guard let url = URL(string: urlString) else { return }
		let session = URLSession.shared.dataTask(with: url) { [jsonDecoder] data, _, _ in
			guard let data = data else { return }
			if let response = try? jsonDecoder.decode(T.self, from: data) {
				DispatchQueue.main.async {
					completion(response)
				}
			}
		}
		session.resume()
	}
}
