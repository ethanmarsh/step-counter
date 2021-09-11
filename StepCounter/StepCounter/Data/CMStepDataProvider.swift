//
//  CMStepDataProvider.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/11/21.
//

import Foundation
import CoreMotion

class CMStepDataProvider: StepDataProvider {
	var isStepCountingAvailable: Bool {
		CMPedometer.isStepCountingAvailable()
	}
	
	var hasAskedForAuthorization: Bool {
		CMPedometer.authorizationStatus() != .notDetermined
	}
	
	var isAuthorizedForStepData: Bool {
		CMPedometer.authorizationStatus() == .authorized
	}
	
	let pedometer = CMPedometer()
	
	func getStepData(from: Date, to: Date, _ completion: @escaping StepDataHandler) {
		if !self.isStepCountingAvailable {
			completion(nil, StepDataError.notAvailable)
			return
		}
		
		if !self.isAuthorizedForStepData, self.hasAskedForAuthorization {
			completion(nil, StepDataError.notAuthorized)
			return
		}
		
		self.pedometer.queryPedometerData(from: from, to: to) { cmData, error in
			completion(cmData, error)
		}
	}
}
