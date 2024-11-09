//
//  Display.swift
//  RPN-35
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
        scientificNotation(value, digits: outputFormat.digits)
    }

    func scientificNotation(_ value: Double, digits: Int) {
        print("SCI - Value: \(value)")
        var formatDigits = .hp35 ? 10 : digits
        if value < 0 && formatDigits > 0 {
            formatDigits -= 1
        }
        let scientificNotationString = String(format: "%.\(formatDigits)e", value)
        var components = scientificNotationString.components(separatedBy: "e")
        var mantissa = ""
        var exponent = ""
        guard components.count == 2 else { return }
        if components[1] == "-00" || components[1] == "+00" {
            exponent = "   "
        } else {
            exponent = String(components[1].replacingOccurrences(of: "+", with: " "))
        }
        mantissa = components[0]
        components = mantissa.components(separatedBy: ".")
        var integer = ""
        var fraction = ""
        if components.count > 0 {
            integer = components[0]
        }
        if components.count > 1 {
            fraction = components[1]
        }
        if fraction.count < digits {
            for _ in fraction.count..<digits {
                if (integer.count + fraction.count + 1) < 12 {
                    fraction += "0"
                }
            }
        }
        let size = integer.count + fraction.count + 1
        if size < 12 {
            for _ in size..<12 {
                fraction += " "
            }
        }
        print("SCI -  1234567890ABCDE")
        print("SCI - [\(integer).\(fraction)\(exponent)]")
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
