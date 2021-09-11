//
//  StepDataProvider.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/11/21.
//

import Foundation
import CoreMotion

typealias StepDataHandler = (StepData?, Error?) -> Void

protocol StepDataProvider {
	func getStepData(from: Date, to: Date, _ completion: StepDataHandler)
}
