//
//  UserManualTests1.swift
//  HP-35Tests
//
//  Created by Enrique Haro on 2/17/24.
//

import XCTest
import HP_35

final class UserManualTests1: XCTestCase {
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

    func test_7_Stack() throws {
        //             "1234567890ABCDE"
        let results = ["3.             ",
                       "3.             ",
                       "4.             ",
                       "12.            ",
                       "5.             ",
                       "5.             ",
                       "6.             ",
                       "30.            ",
                       "42.            "]
        let regY: [Double] = [0, 3, 3, 0, 12, 5, 5, 12, 0]
        let regZ: [Double] = [0, 0, 0, 0, 0, 12, 12, 0, 0]

        let inputs = ["3", "\r", "4", "*", "5", "\r", "6", "*", "+"]

        for index in 0..<inputs.count {
            let input = inputs[index]
            let expectedResult = results[index]
            for char in input {
                let key = String(char)
                appService.processOps(key.ops35)
            }
            XCTAssertEqual(appService.displayInfo.output, expectedResult, 
                           "Index: \(index), Input \(input)")
            XCTAssertEqual(appService.stack.regY, regY[index])
            XCTAssertEqual(appService.stack.regZ, regZ[index])
        }
     }

    func test_8_SimpleProblems() throws {
        //             "1234567890ABCDE"
        let results = ["4.             ", //Square Root
                       "49.            ",
                       "7.             ",
                       "2.             ", // Reciprocal
                       "25.            ",
                       "0.04           ",
                       "3.             ", // Hypotenuse
                       "3.             ",
                       "9.             ",
                       "4.             ",
                       "4.             ",
                       "16.            ",
                       "25.            ",
                       "5.             ",
                       "3.             ", // Area of Circle
                       "3.             ",
                       "9.             ",
                       "3.1415926535   ", // "3.141592654    "
                       "28.274333882   "] // "28.27433389    "

        let inputs = ["4", "9", "q", "2", "5", "i", "3", "\r", "*", "4", "\r", "*", "+", "q",
                      "3", "\r", "*", "p", "*"]

        for index in 0..<inputs.count {
            let input = inputs[index]
            let expectedResult = results[index]
            for char in input {
                let key = String(char)
                appService.processOps(key.ops35)
            }
            XCTAssertEqual(appService.displayInfo.output, expectedResult,
                           "Index: \(index), Input \(input)")
            print("RegX: \(appService.stack.regX)")
        }
     }

    func test_9_PowerOfNumbers() throws {
        //             "1234567890ABCDE"
        let results = ["7.             ",
                       "7.             ",
                       "2.             ",
                       "128.           ",

                       "2.             ",
                       "2.             ",
                       "3.             ",
                       "0.6666666666   ",
                       "8.             ",
                       "3.9999999999   "]

        let inputs = ["7", "\r", "2", "^",
                      "2", "\r", "3", "/", "8", "^"]

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

    func test_10_ProblemsInFinance() throws {
        //             "1234567890ABCDE"
        let results = ["17.            ", // Compound Interest
                       "17.            ",
                       "1.05           ",
                       "2.2920183178   ", // "2.292018319    "

                       "1972.          ", // Compound Growth Rate
                       "1972.          ",
                       "1965.          ",
                       "7.             ",
                       "0.1428571428   ", // "0.1428571429   "
                       "1.37         09",
                       "1.37         09",
                       "926.         06",
                       "1.4794816414   ", // "1.479481641    "
                       "1.0575511178   "] // "1.057551119    "

        let inputs = ["17", "\r", "1.05", "^",
                      "1972", "\r", "1965", "-", "i", "1.37E9", "\r", "926E6", "/", "^"]

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

    func test_11_ProblemsInFinance() throws {
        //             "1234567890ABCDE"
        let results = ["30000.         ",
                       "30000.         ",
                       "0.005          ",
                       "150.           ",
                       "1.             ",
                       "1.             ",
                       "360.           ",
                       "360.           ",
                       "1.005          ",
                       "6.0225752122   ", // "6.0225.        "
                       "0.166041928    ", // "0.16604        ",
                       "0.8339580719   ", // "0.83395        ",
                       "179.86515754   "] // "179.86         "

        let inputs = ["30000", "\r", ".005", "*", "1", "\r", "360", "\r",
                      "1.005", "^", "i", "-", "/"]

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
