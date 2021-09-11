//
//  StepDataProviderTests.swift
//  StepCounterTests
//
//  Created by Ethan Marsh on 9/11/21.
//

import XCTest
@testable import StepCounter

class StepDataProviderTests: XCTestCase {
	
	var stepDataProvider: StepDataProvider!

    override func setUpWithError() throws {
		self.stepDataProvider = MockStepDataProvider()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	func testProvidesStepsForToday() throws {
		let calendar = Calendar.current
		self.stepDataProvider.getStepData(from: calendar.startOfDay(for: Date()), to: Date()) { data, error in
			XCTAssertNil(error)
			XCTAssertNotNil(data)
			
			XCTAssert(data?.numberOfSteps == 50)
		}
	}
}
