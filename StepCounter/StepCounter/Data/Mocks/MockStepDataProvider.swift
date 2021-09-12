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
	var isStepCountingAvailable = true
	var hasAskedForAuthorization = true
	var isAuthorizedForStepData = true
	
	let stepDictionary: StepDictionary
	
	init(stepDictionary: StepDictionary) {
		self.stepDictionary = stepDictionary
	}
	
	convenience init() {
		let calendar = Calendar.current
		let startOfToday = calendar.startOfDay(for: Date())
		var stepDictionary: StepDictionary = [:]
		
		for day in 0...9 {
			guard let date = calendar.date(byAdding: .day, value: -day, to: startOfToday) else {
				continue
			}
			// Put a different number of steps into each day
			let steps = MockPedometerData(numberOfSteps: NSNumber(integerLiteral: 100 * day))
			stepDictionary[date] = steps
		}
		
		self.init(stepDictionary: stepDictionary)
	}
	
	func requestAuthorization(completion: @escaping (Bool) -> Void) {
		completion(self.isAuthorizedForStepData)
	}
	
	func getStepData(from: Date, to: Date, _ completion: @escaping StepDataHandler) {
		if !self.isStepCountingAvailable {
			completion(nil, StepDataError.notAvailable)
			return
		}
		
		if !self.isAuthorizedForStepData, self.hasAskedForAuthorization {
			completion(nil, StepDataError.notAuthorized)
			return
		}
		
		guard let stepData = self.stepDictionary[from] else {
			// No step data found for given date
			completion(nil, StepDataError.invalidDate)
			return
		}
		
		completion(stepData, nil)
	}
}
