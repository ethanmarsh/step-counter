//
//  StepsViewModel.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/12/21.
//

import Foundation

/// Holds relevant data for a single day's worth of steps
struct StepsViewModel {
	let dayIndex: Int
	let date: Date
	let stepData: StepData
	
	var numberOfSteps: Int {
		self.stepData.numberOfSteps.intValue
	}
}
