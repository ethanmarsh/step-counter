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
	/// Meters
	var distance: NSNumber? { get }
	var floorsAscended: NSNumber? { get }
	var floorsDescended: NSNumber? { get }
	/// Seconds / meter
	var averageActivePace: NSNumber? { get }
}

extension CMPedometerData: StepData {}
