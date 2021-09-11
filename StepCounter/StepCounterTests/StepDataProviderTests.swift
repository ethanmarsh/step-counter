//
//  StepDataProviderTests.swift
//  StepCounterTests
//
//  Created by Ethan Marsh on 9/11/21.
//

import XCTest
@testable import StepCounter

class StepDataProviderTests: XCTestCase {
	
	var calendar: Calendar!
	var stepDataProvider: StepDataProvider!

    override func setUpWithError() throws {
		self.calendar = Calendar.current
		let startOfToday = calendar.startOfDay(for: Date())
		var stepDictionary: StepDictionary = [:]
		
		for day in 0...9 {
			guard let date = calendar.date(byAdding: .day, value: -day, to: startOfToday) else {
				throw StepDataError.invalidDate
			}
			// Put a different number of steps into each day
			let steps = MockPedometerData(numberOfSteps: NSNumber(integerLiteral: 100 * day))
			stepDictionary[date] = steps
		}
	
		self.stepDataProvider = MockStepDataProvider(stepDictionary: stepDictionary)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	func testProvidesStepsForToday() throws {
		self.stepDataProvider.getStepData(forDayFromToday: 0) { data, error in
			XCTAssertNil(error)
			XCTAssertNotNil(data)
			
			XCTAssertEqual(data?.numberOfSteps, 0)
		}
	}
	
	func testDoesNotProvideStepsForDateOlderThan10Days() throws {
		self.stepDataProvider.getStepData(forDayFromToday: 1000) { data, error in
			XCTAssertNil(data)
			XCTAssertNotNil(error)
		}
	}
	
	func testProvidesStepsFor9DaysAgoUsingDaysFromToday() throws {
		self.stepDataProvider.getStepData(forDayFromToday: 9) { data, error in
			XCTAssertNil(error)
			XCTAssertNotNil(data)
			
			XCTAssertEqual(data?.numberOfSteps, 900)
		}
	}
	
	func testProvidesStepsFor9DaysAgoUsingDateRange() throws {
		let startOfToday = calendar.startOfDay(for: Date())
		guard let startOfDayNine = calendar.date(byAdding: .day, value: -9, to: startOfToday) else {
			XCTFail("Failed to create Date object for start of day 9")
			return
		}
		
		guard let endOfDayNine = calendar.date(byAdding: .day, value: 1, to: startOfDayNine) else {
			XCTFail("Failed to create Date object for end of day 9")
			return
		}
		
		self.stepDataProvider.getStepData(from: startOfDayNine, to: endOfDayNine) { data, error in
			XCTAssertNil(error)
			XCTAssertNotNil(data)
			
			XCTAssertEqual(data?.numberOfSteps, 900)
		}
	}
}
