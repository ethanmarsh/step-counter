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
	
	static func createOldDate() -> Date? {
		var components = DateComponents()
		components.year = 2020
		components.month = 1
		components.day = 1
		return Calendar.current.date(from: components)
	}

    override func setUpWithError() throws {
		self.calendar = Calendar.current
		let stepDictionary = [calendar.startOfDay(for: Date()): MockPedometerData(numberOfSteps: 50)]
		self.stepDataProvider = MockStepDataProvider(stepDictionary: stepDictionary)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	func testProvidesStepsForToday() throws {
		self.stepDataProvider.getStepData(from: calendar.startOfDay(for: Date()), to: Date()) { data, error in
			XCTAssertNil(error)
			XCTAssertNotNil(data)
			
			XCTAssert(data?.numberOfSteps == 50)
		}
	}
	
	func testDoesNotProvideStepsForDateOlderThan10Days() throws {
		guard let oldDate = Self.createOldDate() else {
			XCTFail("Failed to create Date object for an old invalid date")
			return
		}
		
		self.stepDataProvider.getStepData(from: calendar.startOfDay(for: oldDate), to: oldDate) { data, error in
			XCTAssertNil(data)
			XCTAssertNotNil(error)
		}
	}
}
