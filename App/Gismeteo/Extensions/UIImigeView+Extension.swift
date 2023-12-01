//
//  UIImageView+Extension.swift
//  Gismeteo
//
//  Created by Constantin on 28.11.2023.
//

import UIKit

// MARK: - UIImageView

extension UIImageView {

	// MARK: - Internal methods

	func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
		contentMode = mode
		let session = URLSession.shared.dataTask(with: url) { data, response, error in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == Int(L10n.Downloaded.statusCode),
				let mimeType = response?.mimeType, mimeType.hasPrefix(L10n.Downloaded.image),
				let data = data, error == nil,
				let image = UIImage(data: data)
				else { return }
			DispatchQueue.main.async {
				self.image = image
			}
		}
		session.resume()
	}

	func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
		guard let url = URL(string: link) else { return }
		downloaded(from: url, contentMode: mode)
	}
}
