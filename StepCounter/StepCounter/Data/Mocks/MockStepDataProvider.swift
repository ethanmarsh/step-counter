//
//  MockStepDataProvider.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/11/21.
//

import Foundation
import CoreMotion

class MockStepDataProvider: StepDataProvider {
	let stepData: StepData = {
		MockPedometerData(numberOfSteps: 50)
	}()
	
	func getStepData(from: Date, to: Date, _ completion: (StepData?, Error?) -> Void) {
		completion(self.stepData, nil)
	}
}
