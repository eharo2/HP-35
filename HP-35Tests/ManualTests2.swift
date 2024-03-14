//
//  ManualTests2.swift
//  HP-35Tests
//
//  Created by Enrique Haro on 3/13/24.
//

import XCTest
import HP_35

final class ManualTests2: XCTestCase {
    let appService = AppService()

    override func setUpWithError() throws {
        appService.processOps("\r".ops35)
    }

    override func tearDownWithError() throws { }

    func test_12_BigAndLittleNumbers() throws {
        //             "1234567890ABCDE"
        let results = ["9.7546042371 11"] // "9.754604237  11"

        let inputs = ["987654\r*"]

        for index in 0..<inputs.count {
            let input = inputs[index]
            let expectedResult = results[index]
            for char in input {
                let key = String(char)
                appService.processOps(key.ops35)
            }
            XCTAssertEqual(appService.displayInfo.output, expectedResult,
                           "Index: \(index), Input \(input)")
        }
    }

    func test_12_BigAndLittleNumbers_2() throws {
        //             "1234567890ABCDE"
        let results = ["1.             ",
                       "15.            ",
                       "15.            ",
                       "15.6           ",
                       "15.6         00",
                       "15.6         01",
                       "15.6         12"]

        let inputs = ["1", "5", ".", "6", "E", "1", "2"]

        for index in 0..<inputs.count {
            let input = inputs[index]
            let expectedResult = results[index]
            for char in input {
                let key = String(char)
                appService.processOps(key.ops35)
            }
            XCTAssertEqual(appService.displayInfo.output, expectedResult,
                           "Index: \(index), Input \(input)")
        }
    }

    func test_13_BigAndLittleNumbers_3() throws {
        //             "1234567890ABCDE"
        let results = ["1.           00",
                       "1.           06",
                       "0.             ",

                       "9.             ",
                       "9.             ",
                       "9.1            ",
                       "9.10           ",
                       "9.109          ",
                       "9.109        00",
                       "9.109       -00",
                       "9.109       -03",
                       "9.109       -31"]

        let inputs = ["E","6", "C",
                      "9", ".", "1", "0", "9", "E", "h", "3", "1"]

        for index in 0..<inputs.count {
            let input = inputs[index]
            let expectedResult = results[index]
            for char in input {
                let key = String(char)
                appService.processOps(key.ops35)
            }
            XCTAssertEqual(appService.displayInfo.output, expectedResult,
                           "Index: \(index), Input \(input)")
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

    func test_15_MoreMemory() throws {
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
            // XCTAssertEqual(appService.displayInfo.output, expectedResult, "Index: \(index), Op \(key.ops35)")
        }
    }
}
