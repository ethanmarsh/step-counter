//
//  MockPedometerData.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/11/21.
//

import Foundation
import CoreMotion

struct MockPedometerData: StepData {
	var numberOfSteps: NSNumber
	var distance: NSNumber?
	var floorsAscended: NSNumber?
	var floorsDescended: NSNumber?
	var averageActivePace: NSNumber?
} 
