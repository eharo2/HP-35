//
//  ErrorTests.swift
//  RPN-35Tests
//
//  Created by Enrique Haro on 3/15/24.
//

import XCTest
import HP_35

final class ErrorTests2: XCTestCase {
    let appService = AppService()

    override func setUpWithError() throws {
        Global.model = .hp35
        appService.processOps("C".ops35)
    }

    override func tearDownWithError() throws {
        appService.processOps("x".ops35)
    }

    func test_Error_divideByZero() throws {
        //             "1234567890ABCDE"
        let results = ["-9.999999999-99"]

        let inputs = ["9\r0/"]

        for index in 0..<inputs.count {
            let input = inputs[index]
            let expectedResult = results[index]
            for char in input {
                let key = String(char)
                appService.processOps(key.ops35)
            }
            XCTAssertEqual(appService.displayInfo.output, expectedResult,
                           "Index: \(index), Input \(input)")
            XCTAssertTrue(appService.displayInfo.error)
        }
    }

    func test_Error_SquareRootOfNegativeNumber() throws {
        //             "1234567890ABCDE"
        let results = ["-9.999999999-99"]

        let inputs = ["1hq"]

        for index in 0..<inputs.count {
            let input = inputs[index]
            let expectedResult = results[index]
            for char in input {
                let key = String(char)
                appService.processOps(key.ops35)
            }
            XCTAssertEqual(appService.displayInfo.output, expectedResult,
                           "Index: \(index), Input \(input)")
            XCTAssertTrue(appService.displayInfo.error)
        }
    }

    func test_Error_log_ln_yx_OfNegativeNumber() throws {
        //             "1234567890ABCDE"
        let results = ["-9.999999999-99",
                       "-9.999999999-99",
                       "-9.999999999-99",
                       "-9.999999999-99",
                       "-9.999999999-99",
                       "-9.999999999-99"]

        let inputs = ["0n", "x0l", "x1\r0^",     // x = 0
                      "1hn", "x1hl", "x1\r1h^"]  // x < 0

        for index in 0..<inputs.count {
            let input = inputs[index]
            let expectedResult = results[index]
            for char in input {
                let key = String(char)
                appService.processOps(key.ops35)
            }
            XCTAssertEqual(appService.displayInfo.output, expectedResult,
                           "Index: \(index), Input \(input)")
            XCTAssertTrue(appService.displayInfo.error)
        }
    }

    func test_Error_arcSin_arcCos_x_largerThanOne() throws {
        //             "1234567890ABCDE"
        let results = ["-9.999999999-99",
                       "-9.999999999-99",
                       "-9.999999999-99",
                       "-9.999999999-99"]

        let inputs = ["2as", "x2ac",    //  x > 1
                      "2has", "x2hac"]  // |x| > 1

        for index in 0..<inputs.count {
            let input = inputs[index]
            let expectedResult = results[index]
            for char in input {
                let key = String(char)
                appService.processOps(key.ops35)
            }
            XCTAssertEqual(appService.displayInfo.output, expectedResult,
                           "Index: \(index), Input \(input)")
            XCTAssertTrue(appService.displayInfo.error)
        }
    }
}
