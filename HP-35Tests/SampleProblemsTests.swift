//
//  SampleProblemsTests.swift
//  HP-35Tests
//
//  Created by Enrique Haro on 3/11/24.
//

import XCTest
import HP_35

final class SampleProblemsTests: XCTestCase {
    let appService = AppService()

    override func setUpWithError() throws { }
    override func tearDownWithError() throws { }

    func test_clearKey() throws {
        let result = "0.             "

        appService.displayInfo.output = "XXX"
        let input = ["C"]
        for key in input {
            appService.processOps(key.ops35)
        }
        XCTAssertEqual(appService.displayInfo.output, result)
    }

    func test_Exercise1() throws {
        //           "1234567890ABCDE"
        let result = "98.            "

        let input = ["3", "\r", "4", "*", "5", "\r", "6", "*", "+", "7", "\r", "8", "*", "+"]
        for key in input {
            appService.processOps(key.ops35)
        }
        XCTAssertEqual(appService.displayInfo.output, result)
    }

    func test_Exercise2() throws {
        //           "1234567890ABCDE"
        let result = "1155.          "

        let input = ["3", "\r", "4", "+", "5", "\r", "6", "+", "*", "7", "\r", "8", "+", "*"]
        for key in input {
            appService.processOps(key.ops35)
        }
        XCTAssertEqual(appService.displayInfo.output, result)
    }

    func test_Exercise3() throws {
        //           "1234567890ABCDE"
        let result = "26.90641536    "

        let input = ["4", "\r", "5", "*", "7", "/", "2", "9", "\r", "3", "/", "1", "1", "/", "+",
                     "1", "9", "\r", "2", "\r", "4", "+", "/", "1", "3", "\r", "p", "+", "4", "/",
                     "+", "*"]
        for key in input {
            appService.processOps(key.ops35)
        }
        XCTAssertEqual(appService.displayInfo.output, result)
    }

    func test_Exercise4() throws {
        //           "1234567890ABCDE"
        let result = "2.             "

        let input = ["3", "i", "6", "i", "+", "i"]
        for key in input {
            appService.processOps(key.ops35)
        }
        XCTAssertEqual(appService.displayInfo.output, result)
    }

    func test_Exercise5() throws {
        //           "1234567890ABCDE"
        let result = "3.141592653    "

        let input = ["2", "9", "2", "i", "1", "+", "i", "1", "5", "+", "i", "7", "+", "i", "3", "+"]
        for key in input {
            appService.processOps(key.ops35)
        }
        XCTAssertEqual(appService.displayInfo.output, result)
    }

    func test_Exercise6() throws {
        //           "1234567890ABCDE"
        let result = "6949.3924693   " // 6949.392474

        let input = ["4", "5", "c", "1", "5", "0", "c", "*", "4", "5", "s", "1", "5", "0", "s",
                     "*", "6", "0", "c", "*", "+", "a", "c", "6", "0", "*"]
        for key in input {
            appService.processOps(key.ops35)
        }
        XCTAssertEqual(appService.displayInfo.output, result)
    }

    func test_Exercise7a() throws {
        //            "1234567890ABCDE"
        let resultX = "4.3301270189   " // 4.33012702
        let resultY = "2.4999999999   " // 2.5

        let input = ["3", "0", "\r", "t", "L", "c", "5", "*"]
        for key in input {
            appService.processOps(key.ops35)
        }
        XCTAssertEqual(appService.displayInfo.output, resultX)
        appService.processOps("*".ops35)
        XCTAssertEqual(appService.displayInfo.output, resultY)
    }

    func test_Exercise7b() throws {
        //            "1234567890ABCDE"
        let resultT = "36.869897645   " // 36.86989764
        let resultR = "5.             " // 5.000000003

        var input = ["3", "\r", "\r", "4", "/", "a", "t"]
        for key in input {
            appService.processOps(key.ops35)
        }
        XCTAssertEqual(appService.displayInfo.output, resultT)

        input = ["s", "/"]
        for key in input {
            appService.processOps(key.ops35)
        }
        XCTAssertEqual(appService.displayInfo.output, resultR)
    }

    func test_Exercise8() throws {
        //           "1234567890ABCDE"
        var result = "160.02         "

        var input = ["2", ".", "5", "4", "S", "5", "\r", "1", "2", "*", "3", "+", "R", "*"]
        for key in input {
            appService.processOps(key.ops35)
        }
        XCTAssertEqual(appService.displayInfo.output, result)

        //       "1234567890ABCDE"
        result = "93.98          "
        input = ["3", "7", "R", "*"]
        for key in input {
            appService.processOps(key.ops35)
        }
        XCTAssertEqual(appService.displayInfo.output, result)

        //       "1234567890ABCDE"
        result = "60.96          "
        input = ["2", "4", "R", "*"]
        for key in input {
            appService.processOps(key.ops35)
        }
        XCTAssertEqual(appService.displayInfo.output, result)

        //       "1234567890ABCDE"
        result = "91.44          "
        input = ["3", "6", "R", "*"]
        for key in input {
            appService.processOps(key.ops35)
        }
        XCTAssertEqual(appService.displayInfo.output, result)
    }
}
