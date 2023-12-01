//
//  String+Extension.swift
//  Gismeteo
//
//  Created by Constantin on 24.11.2023.
//

// MARK: - String

extension String {

	// MARK: - Internal methods

	func deletingPrefix() -> String {
		let newString = self.components(separatedBy: L10n.StringS.prefix)
		return newString[1]
	}
}

// MARK: - StringProtocol

extension StringProtocol {

	// MARK: - Internal properties

	var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
