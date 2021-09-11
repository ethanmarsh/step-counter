//
//  StepDataError.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/11/21.
//

import Foundation

enum StepDataError: Error {
	// No step data available for given date range
	case invalidDate
	// Can't provide steps because we are not authorized to access user step data
	case notAuthorized
}
