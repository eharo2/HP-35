//
//  UserManualTests45.swift
//  HP-35Tests
//
//  Created by Enrique Haro on 3/19/24.
//

import XCTest
import HP_35

final class UserManualTests45: XCTestCase {
    let appService = AppService()

    override func setUpWithError() throws {
        Global.model = .hp45
        let ops = "fCff2" // CLR FIX2
        for op in ops {
            appService.processOps(String(op).ops35)
        }
    }

    override func tearDownWithError() throws { }

    func test_Page_8() throws {
        //             "1234567890ABCDE"
        let results = ["5.00           ",
                       "53.13          "]
        let inputs = ["4\r3P", "L"]
        evaluate(results, inputs)
    }

    func test_Page_11() throws {
        //             "1234567890ABCDE"
        let results = ["15.00          ",
                       "9.00           ",
                       "36.00          ",
                       "4.00           "]
        let inputs = ["12\r3+", "12\r3-", "12\r3*", "12\r3/"]
        evaluate(results, inputs)
    }

    func test_LastX_Page_12() throws {
        //             "1234567890ABCDE"
        let results = ["4.00           ",
                       "3.00           ",
                       "12.00          ",
                       "3.00           ",
                       "9.00           "]
        let inputs = ["12\r3/", "fx" , "*", "fx", "-"]
        evaluate(results, inputs)
    }

    func evaluate(_ results: [String], _ inputs: [String], f: String = #function) {
        for index in 0..<inputs.count {
            let input = inputs[index]
            let expectedResult = results[index]
            for char in input {
                let key = String(char)
                appService.processOps(key.ops35)
            }
            XCTAssertEqual(appService.displayInfo.output, expectedResult,
                           "func \(f), Index: \(index), Input \(input)")
        }
    }
}
