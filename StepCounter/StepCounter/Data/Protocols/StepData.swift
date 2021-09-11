//
//  StepData.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/11/21.
//

import Foundation
import CoreMotion

protocol StepData {
	var numberOfSteps: NSNumber { get }
}

extension CMPedometerData: StepData {}
