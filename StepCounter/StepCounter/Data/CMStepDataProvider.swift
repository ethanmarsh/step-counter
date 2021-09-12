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
	
	func requestAuthorization(completion: @escaping (Bool) -> Void) {
		if self.hasAskedForAuthorization {
			completion(self.isAuthorizedForStepData)
			return
		}
		
		self.pedometer.queryPedometerData(from: Date(), to: Date()) { [weak self] data, error in
			guard let self = self else { return }
			completion(self.isAuthorizedForStepData)
		}
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
		
		self.pedometer.queryPedometerData(from: from, to: to) { cmData, error in
			completion(cmData, error)
		}
	}
}
