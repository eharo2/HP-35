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

    override func setUpWithError() throws {
        appService.processOps("\r".ops35)
    }

    override func tearDownWithError() throws { }

    func test_1_AddNumbers() throws {
        //             "1234567890ABCDE"
        let results = ["1.             ",
                       "12.            ",
                       "12.            ",
                       "3.             ",
                       "15.            ",
                       "1.             ",
                       "12.            ",
                       "12.            ",
                       "3.             ",
                       "9.             "]

        let input = ["1", "2", "\r", "3", "+", "1", "2", "\r", "3", "-"]

        for index in 0..<input.count {
            let key = input[index]
            let expectedResult = results[index]
            appService.processOps(key.ops35)
            XCTAssertEqual(appService.displayInfo.output, expectedResult, "Index: \(index), Op \(key.ops35)")
        }
    }

    func test_2_MultiplyNumbers() throws {
        //             "1234567890ABCDE"
        let results = ["1.             ",
                       "12.            ",
                       "12.            ",
                       "3.             ",
                       "36.            ",
                       "1.             ",
                       "12.            ",
                       "12.            ",
                       "3.             ",
                       "4.             "]

        let input = ["1", "2", "\r", "3", "*", "1", "2", "\r", "3", "/"]

        for index in 0..<input.count {
            let key = input[index]
            let expectedResult = results[index]
            appService.processOps(key.ops35)
            XCTAssertEqual(appService.displayInfo.output, expectedResult, "Index: \(index), Op \(key.ops35)")
        }
    }

    func test_2_DobleNumbers() throws {
        //             "1234567890ABCDE"
        let results = ["3.             ",
                       "3.             ",
                       "6.             ",
                       "3.             ",
                       "3.             ",
                       "9.             "]

        let input = ["3", "\r", "+", "3", "\r", "*"]

        for index in 0..<input.count {
            let key = input[index]
            let expectedResult = results[index]
            appService.processOps(key.ops35)
            XCTAssertEqual(appService.displayInfo.output, expectedResult, "Index: \(index), Op \(key.ops35)")
        }
    }

    func test_3_SerialCalculation() throws {
        //             "1234567890ABCDE"
        let results = ["1.             ",
                       "1.             ",
                       "3.             ",
                       "4.             ",
                       "5.             ",
                       "9.             ",
                       "7.             ",
                       "16.            ",
                       "9.             ",
                       "25.            ",
                       "2.             ",
                       "2.             ",
                       "4.             ",
                       "8.             ",
                       "6.             ",
                       "48.            ",
                       "8.             ",
                       "384.           ",
                       "1.             ",
                       "10.            ",
                       "3840.          "]

        let input = ["1", "\r", "3", "+", "5", "+", "7", "+", "9", "+",
                     "2", "\r", "4", "*", "6", "*", "8", "*", "1", "0", "*"]

        for index in 0..<input.count {
            let key = input[index]
            let expectedResult = results[index]
            appService.processOps(key.ops35)
            XCTAssertEqual(appService.displayInfo.output, expectedResult, "Index: \(index), Op \(key.ops35)")
        }
    }

    func test_4_SerialCalculation_2() throws {
        //             "1234567890ABCDE"
        let results = ["2.             ",
                       "2.             ",
                       "3.             ",
                       "5.             ",
                       "4.             ",
                       "1.25           ",
                       "5.             ",
                       "6.25           ",
                       "6.             ",
                       "37.5           "]

        let inputs = ["2", "\r", "3", "+", "4", "/", "5", "+", "6", "*"]

        for index in 0..<inputs.count {
            let input = inputs[index]
            let expectedResult = results[index]
            for char in input {
                let key = String(char)
                appService.processOps(key.ops35)
            }
            XCTAssertEqual(appService.displayInfo.output, expectedResult, "Index: \(index), Input \(input)")
        }
    }

    func test_4_SumOfProducts() throws {
        //             "1234567890ABCDE"
        let results = ["12.            ",
                       "12.            ",
                       "1.58           ",
                       "18.96          ",
                       "8.             ",
                       "8.             ",
                       "2.67           ",
                       "21.36          ",
                       "40.32          ",
                       "16.            ",
                       "16.            ",
                       "0.54           ",  // ".58 in the manual"
                       "8.64           ",
                       "48.96          "]

        let inputs = ["12", "\r", "1.58", "*", "8", "\r", "2.67", "*", "+", "16", "\r", ".54", "*", "+"]

        for index in 0..<inputs.count {
            let input = inputs[index]
            let expectedResult = results[index]
            for char in input {
                let key = String(char)
                appService.processOps(key.ops35)
            }
            XCTAssertEqual(appService.displayInfo.output, expectedResult, "Index: \(index), Input \(input)")
        }
    }

    func test_5_ProductsOfSums() throws {
        //             "1234567890ABCDE"
        let results = ["7.             ",
                       "7.             ",
                       "3.             ",
                       "10.            ",
                       "5.             ",
                       "5.             ",
                       "11.            ",
                       "16.            ",
                       "160.           ",
                       "13.            ",
                       "13.            ",
                       "17.            ",
                       "30.            ",
                       "4800.          "]


        let inputs = ["7", "\r", "3", "+", "5", "\r", "11", "+", "*", "13", "\r", "17", "+", "*"]

        for index in 0..<inputs.count {
            let input = inputs[index]
            let expectedResult = results[index]
            for char in input {
                let key = String(char)
                appService.processOps(key.ops35)
            }
            XCTAssertEqual(appService.displayInfo.output, expectedResult, "Index: \(index), Input \(input)")
        }
    }

    func test_14_NegativeNumbers() throws {
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

        for index in 0..<input.count {
            let key = input[index]
            let expectedResult = results[index]
            appService.processOps(key.ops35)
            XCTAssertEqual(appService.displayInfo.output, expectedResult, "Index: \(index), Op \(key.ops35)")
        }
    }
}
