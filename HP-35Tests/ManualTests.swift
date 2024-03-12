//
//  ManualTests.swift
//  HP-35Tests
//
//  Created by Enrique Haro on 2/17/24.
//

import XCTest
import HP_35

final class ManualTests: XCTestCase {
    let appService = AppService()

    override func setUpWithError() throws { }
    override func tearDownWithError() throws { }

    func test_NegativeNumbers() throws {
        //             "1234567890ABCDE"
        let results = ["-0.            ",
                       "-3.            ",
                       "-3.            ",
                       "3.             ",
                       "-4.            ",
                       "12.            ",
                       "5.             ",
                       "-5.            ",
                       "-60.           ",
                       "6.             ",
                       "-6.            ",
                       "360.           "]

        let input = ["h", "3", "\r", "h", "4", "*", "5", "h", "*", "6", "h", "*"]

        var index = 0
        var key = input[index]
        var expectedResult = results[index]
        appService.processOps(key.ops35)
        XCTAssertEqual(appService.displayInfo.output, expectedResult, "Op \(key.ops35)")
        index += 1
        key = input[index]
        expectedResult = results[index]
        appService.processOps(key.ops35)
        XCTAssertEqual(appService.displayInfo.output, expectedResult, "Op \(key.ops35)")
        index += 1
        key = input[index]
        expectedResult = results[index]
        appService.processOps(key.ops35)
        XCTAssertEqual(appService.displayInfo.output, expectedResult, "Op \(key.ops35)")
        index += 1
        key = input[index]
        expectedResult = results[index]
        appService.processOps(key.ops35)
        XCTAssertEqual(appService.displayInfo.output, expectedResult, "Op \(key.ops35)")
        index += 1
        key = input[index]
        expectedResult = results[index]
        appService.processOps(key.ops35)
        XCTAssertEqual(appService.displayInfo.output, expectedResult, "Op \(key.ops35)")
        index += 1
        key = input[index]
        expectedResult = results[index]
        appService.processOps(key.ops35)
        XCTAssertEqual(appService.displayInfo.output, expectedResult, "Op \(key.ops35)")
        index += 1
        key = input[index]
        expectedResult = results[index]
        appService.processOps(key.ops35)
        XCTAssertEqual(appService.displayInfo.output, expectedResult, "Op \(key.ops35)")
        index += 1
        key = input[index]
        expectedResult = results[index]
        appService.processOps(key.ops35)
        XCTAssertEqual(appService.displayInfo.output, expectedResult, "Op \(key.ops35)")
        index += 1
        key = input[index]
        expectedResult = results[index]
        appService.processOps(key.ops35)
        XCTAssertEqual(appService.displayInfo.output, expectedResult, "Op \(key.ops35)")
        index += 1
        key = input[index]
        expectedResult = results[index]
        appService.processOps(key.ops35)
        XCTAssertEqual(appService.displayInfo.output, expectedResult, "Op \(key.ops35)")
        index += 1
        key = input[index]
        expectedResult = results[index]
        appService.processOps(key.ops35)
        XCTAssertEqual(appService.displayInfo.output, expectedResult, "Op \(key.ops35)")
        index += 1
        key = input[index]
        expectedResult = results[index]
        appService.processOps(key.ops35)
        XCTAssertEqual(appService.displayInfo.output, expectedResult, "Op \(key.ops35)")
    }
}
