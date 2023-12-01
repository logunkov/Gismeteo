//
//  Date+Extension.swift
//  Gismeteo
//
//  Created by Constantin on 28.11.2023.
//

import Foundation

// MARK: - Date

extension Date {

	// MARK: - Internal methods

	func getTimeForDate() -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "HH:mm"
		return formatter.string(from: self)
	}

	func getHourForDate() -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "HH"
		return formatter.string(from: self)
	}

	func getDayForDate() -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "EEEE"
		return formatter.string(from: self)
	}
}
