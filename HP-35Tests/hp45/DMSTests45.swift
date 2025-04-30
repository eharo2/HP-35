//
//  DMSTests45.swift
//  RPN35
//
//  Created by Enrique Haro on 4/28/25.
//

import XCTest
import RPN35

final class DMSTests45: XCTestCase {
    let appService = AppService()

    override func setUpWithError() throws {
        Global.model = .hp45
        let ops = "fCff2" // CLR FIX2
        for op in ops {
            appService.processOps(String(op).ops35)
        }
    }

    override func tearDownWithError() throws { }

    func test_DMS_Conversion_Page_39() throws {
        //             "1234567890ABCDE"
        let results = ["10.15          ",
                       "2.30           ",
                       "12.44          ",
                       "12.2638        "]
        let inputs = ["10.0856N", "2.1742N", "+", "M"]
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
