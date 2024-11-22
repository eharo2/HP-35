//
//  UserManualTests2.swift
//  RPN-35Tests
//
//  Created by Enrique Haro on 3/13/24.
//

import XCTest
import RPN35

final class UserManualTests2: XCTestCase {
    let appService = AppService()

    override func setUpWithError() throws {
        Global.model = .hp35
        appService.processOps("C".ops35)
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
        let results = ["25.            ",
                       "25.            ",
                       "1.             ",
                       "25.            ",
                       "0.04           ",
                       "3.             ",
                       "25.            ",
                       "0.12           ",
                       "5.             ",
                       "25.            ",
                       "0.2            ",
                       "7.             ",
                       "25.            ",
                       "0.28           ",
                       "9.             ",
                       "25.            ",
                       "0.36           "]

        let inputs = ["25", "S", "1", "R", "/", "3", "R", "/",
                      "5", "R", "/", "7", "R", "/", "9", "R", "/"]

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

    func test_16_Stack() throws {
        //             "1234567890ABCDE"
        let results = ["512.           ",
                       "512.           ",
                       "9.             ",
                       "0.1111111111   ",
                       "512.           ",
                       "2.             "]

        let inputs = ["512", "\r", "9", "i", "L", "^"]

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

    func test_18_Logarithms() throws {
        //             "1234567890ABCDE"
        let results = ["25000.         ",
                       "25000.         ",
                       "30.            ",
                       "30.            ",
                       "9.4            ",
                       "3.1914893617   ", // "3.191489362    "
                       "1.1604876923   ", // "1.160487693    "
                       "29012.192309   "] // "29012.19233    "

        let inputs = ["25000", "\r", "30", "\r", "9.4", "/", "n", "*"]

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

    func test_19_Trigonometry_1() throws {
        //             "1234567890ABCDE"
        let results = ["30.5           ",
                       "0.5075383629   ", // "0.5075383628   "
                       "150.           ",
                       "-0.866025403   ", // "-0.8660254041  "
                       "0.8660254037   ", // "0.8660254041   "
                       "-25.6          ",
                       "-0.479119721   "] // "-0.4791197214  "

        let inputs = ["30.5", "s", "150", "c", "h", "25.6", "t"]

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

    func test_19_Trigonometry_2() throws {
        //             "1234567890ABCDE"
        let results = ["0.3            ",
                       "17.457603123   ",
                       "-17.45760312   ",
                       "-.7            ",
                       "134.427004     ",
                       "10.2           ",
                       "84.400660663   "] // "84.40066068    "

        let inputs = [".3", "as", "h", ".7", "ac", "10.2", "at"]

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

    func test_20_DecimalDegrees() throws {
        //             "1234567890ABCDE"
        let results = ["35.            ",
                       "35.            ",
                       "17.            ",
                       "17.            ",
                       "47.            ",
                       "47.            ",
                       "60.            ",
                       "60.            ",
                       "0.7833333333   ",
                       "17.783333333   ",
                       "60.            ",
                       "0.2963888888   ",
                       "35.296388888   "] // "35.296388889   "

        let inputs = ["35", "\r", "17", "\r", "47", "\r", "60", "S", "/", "+", "R", "/", "+"]

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
}
