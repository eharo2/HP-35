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
        appService.processOps("fC".ops35)
    }

    override func tearDownWithError() throws { }

    func test_Page_8() throws {
        //             "1234567890ABCDE"
        let results = ["5.00           ",
                       "53.13          "]
        let inputs = ["4\r3P", "L"]
        // evaluate(results, inputs)
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
