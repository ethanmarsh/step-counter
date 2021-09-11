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
	let stepDictionary: StepDictionary
	
	init(stepDictionary: StepDictionary) {
		self.stepDictionary = stepDictionary
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
