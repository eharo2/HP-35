//
//  Display.swift
//  HP-35
//
//  Created by Enrique Haro on 3/5/24.
//

import Foundation

protocol DisplayManagerDelegate {
    func displayDidUpdateInfo(_ info: DisplayInfo)
}

class Display: StackDelegate {
    var delegate: DisplayManagerDelegate?

    var info = DisplayInfo() {
        didSet {
            self.delegate?.displayDidUpdateInfo(info)
        }
    }
    var numericInput = ""
    var expInput = "   "
    var enteringEex: Bool = false

    // HP-45
    // HP-45
    var enteringFormat = false
    var outputFormat: Format = .fix(2)

    init() { }

    func processOps(_ ops: [Op]) {
        // print("Process: \(ops.names)")
        let op: Op = ops[0]
        if op == .fix {
            enteringFormat = true
            print("Op: Fix")
            return
        }
        if enteringFormat {
            processFormatInput(ops)
            enteringFormat = false
            return
        }
    }

    func processEnter() {
        numericInput = ""
        expInput = "   "
        enteringEex = false
    }

    func processEEXInput() {
        enteringEex = true
        expInput = " 00"
        if numericInput.isEmpty {
            numericInput = "1.0"
        }
        print(numericInput, expInput)
        update(with: numericInput)
    }

    func update(with string: String, addExponent: Bool = true) {
        if addExponent {
            info.output = string.padded + expInput
        } else {
            info.output = string.padded.noExp
        }
    }

    func reset() {
        numericInput = ""
        expInput = "   "
        enteringEex = false
        info.fKey = false
        info.gKey = false
    }

    // HP-45
    func processFormatInput(_ ops: [Op]) {
        switch ops[0] {
        case .digit(let value):
            if let value = Int(value) {
                print("Fix \(value)")
                outputFormat = .fix(value)
            }
        default: print("Ignore: Fix \(ops)")
        }
    }

    // MARK: - StackDelegate
    func stackDidUpdateRegX(value: Double) {
        let rounded = value.roundedToTwelvePositions()
        info.output = rounded.scientificNotation()
    }

    func stackDidUpdateError(error: Bool) {
        info.error = error
        if error {
            info.output = "-9.999999999-99"
        }
    }
}

struct DisplayInfo: Equatable {
    var output = "0.".padded.noExp
    var error: Bool = false
    var fKey = false {
        didSet {
            if fKey {
                gKey = false
            }
        }
    }
    var gKey = false {
        didSet {
            if gKey {
                fKey = false
            }
        }
    }
    var degrees: Degrees = .deg
}

enum Format {
    case fix(_ value: Int)
    case sci(_ value: Int)

    var digits: Int {
        switch self {
        case .fix(let value): return value
        case .sci(let value): return value
        }
    }
}
