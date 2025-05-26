//
//  UserManualTests45.swift
//  RPN-35Tests
//
//  Created by Enrique Haro on 3/19/24.
//

import XCTest
import RPN35

final class UserManualTests45: XCTestCase {
    let rpnEngine = RPNEngine()

    override func setUpWithError() throws {
        Global.model = .hp45
        let ops = "fCff2" // CLR FIX2
        for op in ops {
            rpnEngine.processOps(String(op).ops35)
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
                       "9.00           ",
                       // Page 13
                       "3.80           ",
                       "3.16           ",
                       "12.00          ",
                       "5.56           "
        ]
        let inputs = ["12\r3/", "ax" , "*", "ax", "-",  // 'a' = shiftKey, 'x' = lstX
                      "12\r3.157/", "ax" , "*", "2.157/"]
        evaluate(results, inputs)
    }

    func test_FIX_SCI_Page_14() throws {
        //             "1234567890ABCDE"
        let results = ["123.456        ",
                       "123.4560       ",
                       "123.5          ",
                       "123.           "]

        let inputs = ["123.456", "ff4" , "ff1", "ff0"]
        evaluate(results, inputs)
    }

    func test_STO_RCL_Page_27() throws {
        //             "1234567890ABCDE"
        let results = ["88.00          ",
                       "88.00          ",
                       "0.09           ",
                       "0.23           ",
                       "0.19           ",
                       "0.49           "]

        let inputs = ["8\r20+17+43+", "S1", "8R1/", "20R1/", "17R1/", "43R1/"]
        evaluate(results, inputs)
    }

    func test_Reg_Arithmetic_Page_27() throws {
        //             "1234567890ABCDE"
        let results = ["6.00           ", "2.00           ", "8.00           ",
                       "3.00           ", "5.00           ", "7.00           ",
                       "5.00           ", "6.00           ", "5.00           ",
                       "3.00           ", "2.00           ", "0.25           ",
                       "20.00          ", "100.00         ", "0.             ",
                       "1.00           ", "1.00           ", "1.00           ",
                       "1.00           ", "2.00           "]

        let inputs = ["6S1", "2S+1", "R1", "3S-1", "R1", "2R+1", "R1",
                      "11R-1", "R1", "3S1", "2S+1", ".25S/1", "R1",
                      "5R*1", "0S4", "1S+4", "1S+4", "1S+4", "1S-4", "R4"]
        evaluate(results, inputs)
    }

    func test_Statistical_Page_34() throws {
        //             "1234567890ABCDE"
        let results = ["10.00          ", "64.40          ", "10.10          ",
                       "12.00          ", "65.00          ", "12.29          "]

        let inputs = ["62Z84Z47Z58Z68Z60Z62Z59Z71Z73Z",
                      "aD", // shift RotateDown
                      "L", // Exchange X-Y
                      "87Z49Z",
                      "aD",
                      "L"]
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
