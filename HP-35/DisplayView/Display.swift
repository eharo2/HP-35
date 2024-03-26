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
    var outputFormat: Format = .fix(2)

    init() { }

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
            info.output = string.padded() + expInput
        } else {
            info.output = string.padded().noExp
        }
    }

    func reset() {
        numericInput = ""
        expInput = "   "
        enteringEex = false
        info.fKey = false
        info.gKey = false
    }

    // MARK: - StackDelegate
    func stackDidUpdateRegX(value: Double) {
        if let overflowResult = value.checkForOverflowResult(outputFormat) {
            info.output = overflowResult
            return
        }
        let rounded = value.roundedToFormat(outputFormat)
        let result = rounded.resultString(outputFormat)
//        print("Format Double Value    : [\(value)]")
//        print("Format Double Rounded  : [\(rounded)]")
//        print("Format Result as String: [\(result)]")
        info.output = result
    }

    func stackDidUpdateError(error: Bool) {
        info.error = error
        if error {
            info.output = "-9.999999999-99"
        }
    }
}

struct DisplayInfo: Equatable {
    var output: String = ""
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
