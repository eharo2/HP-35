//
//  UserManualTests21.swift
//  RPN35
//
//  Created by Enrique Haro on 12/4/24.
//

import XCTest
import RPN35

final class UserManualTests21: XCTestCase {
    let rpnEngine = RPNEngine()

    override func setUpWithError() throws {
        Global.model = .hp21
//        let ops = "fCff2" // CLR FIX2
//        for op in ops {
//            rpnEngine.processOps(String(op).ops35)
//        }
    }

    override func tearDownWithError() throws { }

    func test_Page_45() throws {
        //             "1234567890ABCDE"
        let results = ["184.00         ",
                       "10120.00       ",
                       "10120.00       ",
                       "202.40         ",
                       "202.40         ",
                       "94.00          ",
                       "5405.00        ",
                       "5405.00        ",
                       "162.15         ",
                       "162.15         ",
                       "15160.45       "
        ]
        let inputs = ["45\r47+49+43+",
                      "55*",
                      "S", // STO
                      ".02*",
                      "a-", //  a=fShift. M-
                      "46\r48+",
                      "57.50*",
                      "a+", // M+
                      ".03*",
                      "a-", // M-
                      "R" // RCL
        ]
        evaluate(results, inputs)
    }

    func evaluate(_ results: [String], _ inputs: [String], f: String = #function) {
        for index in 0..<inputs.count {
            let input = inputs[index]
            let expectedResult = results[index]
            for char in input {
                let key = String(char)
                rpnEngine.processOps(key.ops35)
            }
            XCTAssertEqual(rpnEngine.displayInfo.output, expectedResult,
                           "func \(f), Index: \(index), Input \(input)")
        }
    }
}
