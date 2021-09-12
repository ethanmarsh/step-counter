//
//  DateUtils.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/12/21.
//

import Foundation

struct DateUtils {
	static let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		if let locale = Locale.preferredLanguages.first {
			formatter.locale = Locale(identifier: locale)
		}
		
		formatter.setLocalizedDateFormatFromTemplate("M.d.yyyy")
		return formatter
	}()
	
	/// Returns a Date object created from the given number of days counting backwards from today, i.e. 0 returns today's date, 1 returns yesterday, etc.
	static func date(from dayIndex: Int) -> Date? {
		let calendar = Calendar.current
		let startOfToday = calendar.startOfDay(for: Date())
		return calendar.date(byAdding: .day, value: -dayIndex, to: startOfToday)
	}
	
	static func naturalLanguageDate(from dayIndex: Int) -> String {
		if dayIndex == 0 {
			return "Today"
		} else if dayIndex == 1 {
			return "Yesterday"
		} else {
			let calendar = Calendar.current
			let startOfToday = calendar.startOfDay(for: Date())
			guard let date = calendar.date(byAdding: .day, value: -dayIndex, to: startOfToday) else {
				return ""
			}
			
			return DateUtils.dateFormatter.string(from: date)
		}
	}
}
