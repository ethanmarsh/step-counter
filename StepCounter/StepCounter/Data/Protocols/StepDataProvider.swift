//
//  StepDataProvider.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/11/21.
//

import Foundation
import CoreMotion

typealias StepDataHandler = (StepData?, Error?) -> Void

protocol StepDataProvider {
	var isStepCountingAvailable: Bool { get }
	
	var isAuthorizedForStepData: Bool { get }
	
	/// Provides step data for the entire given day, as compared to the current day.
	/// For example,  0 will return data for today, 1 for yesterday, 2 for 2 days ago, etc.
	/// When getting data for today, the range will be from the start of the day until the current moment.
	/// For all other days, the range will be from the start of the given day to the end of the given day.
	func getStepData(forDayFromToday day: Int, _ completion: @escaping StepDataHandler)
	
	/// Provides step data for the given date range
	func getStepData(from: Date, to: Date, _ completion: @escaping StepDataHandler)
}

extension StepDataProvider {
	func getStepData(forDayFromToday day: Int, _ completion: @escaping StepDataHandler) {
		let calendar = Calendar.current
		
		let startOfToday = calendar.startOfDay(for: Date())
		guard let startOfTargetDate = calendar.date(byAdding: .day, value: -day, to: startOfToday) else {
			completion(nil, StepDataError.invalidDate)
			return
		}
		guard let endOfTargetDate = calendar.date(byAdding: .day, value: 1, to: startOfTargetDate) else {
			completion(nil, StepDataError.invalidDate)
			return
		}
		
		self.getStepData(from: startOfTargetDate, to: endOfTargetDate, completion)
	}
}
