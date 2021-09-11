//
//  MockStepDataProvider.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/11/21.
//

import Foundation
import CoreMotion

typealias StepDictionary = [Date: StepData]

class MockStepDataProvider: StepDataProvider {
	let calendar = Calendar.current
	let stepDictionary: StepDictionary
	
	init(stepDictionary: StepDictionary) {
		self.stepDictionary = stepDictionary
	}
	
	func getStepData(forDayFromToday day: Int, _ completion: StepDataHandler) {
		let startOfToday = self.calendar.startOfDay(for: Date())
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
	
	func getStepData(from: Date, to: Date, _ completion: (StepData?, Error?) -> Void) {
		guard let stepData = self.stepDictionary[from] else {
			// No step data found for given date
			completion(nil, StepDataError.invalidDate)
			return
		}
		
		completion(stepData, nil)
	}
}
