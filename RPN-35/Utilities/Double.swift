//
//  Double.swift
//  RPN-35
//
//  Created by Enrique Haro on 1/14/24.
//

import Foundation

extension Double {
    func format(_ digits: Int, commas: Bool = false) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
#if os(macOS)
        formatter.hasThousandSeparators = commas
#endif
        formatter.minimumFractionDigits = digits
        formatter.maximumFractionDigits = digits

        let number = NSNumber(value: self)
        guard let formattedValue = formatter.string(from: number) else { return String(self) }
        return formattedValue
    }

    // HP35
    func checkForOverflowResult(_ format: Format) -> String? {
        if abs(self) < pow(10, -99) {
            if .isHP35 {
                return "0.             "
            } else if .isHP45 {
                return Double(0).roundedToFormat(format).resultString(format)
            } else {
                if self == 0.0 { return nil }
            }
        }
        if self >= pow(10, 100)       { return "9.9999999999 99" }
        if self < pow(10, 100) * -1.0 { return "-9.999999999 99" }
        return nil
    }

    // Required to reduce the accuracy discrepancies vs. the manual results
    func roundedToFormat(_ format: Format) -> Double {
        if .isHP35 {
            return self
        } else {
            // Needed to fix accuray discrepancies with the manual results
            let fixedPrecision = (self * 10_000_000_000).rounded(.toNearestOrEven)/10_000_000_000
            let factor = pow(10, Double(format.digits))
            let rounded = (fixedPrecision * factor).rounded(.toNearestOrEven)/factor
            return rounded
        }
    }

    func resultString(_ format: Format, f: String = #function) -> String {
        if .isHP35 {
            // Result is in a fixed format for the range. Else use SCI format
            if abs(self) <= pow(10, 9) && abs(self) > pow(10, -3) {
                return String(self).padded().noExp
            }
            return self.scientificNotation(format)
        }
        // .hp45
        switch format {
        case .fix(let digits):
            if !(abs(self) <= pow(10, 9) && abs(self) > pow(10, -3)) {
                if !.isHP21 || self != 0.0 {
                    return self.scientificNotation(format)
                }
            }
            var stringValue = String(self)
            let components = stringValue.components(separatedBy: ".")
            guard components.count == 2 else { return stringValue.padded().noExp }
            let decimals = components[1].count
            if decimals < digits {
                for _ in decimals..<digits {
                    stringValue += "0"
                }
                while stringValue.count < 12 {
                    stringValue += " "
                }
                return stringValue.noExp
            } else {
                return stringValue.padded().noExp
            }
        case .sci(let digits):
            return self.scientificNotation(.sci(digits))
        }
    }

    private func scientificNotation(_ format: Format) -> String {
        let digits = .isHP35 ? 12 : format.digits
        let scientificNotation = String(format: "%.\(digits)e", self)
        let components = scientificNotation.components(separatedBy: "e")
        guard components.count == 2, let exp = Int(components[1]) else {
            return String(self).padded().noExp
        }
        var coeficient = components[0]
        let coeficientComponents = coeficient.components(separatedBy: ".")
        switch coeficientComponents.count {
        case 1:
            coeficient = "\(coeficientComponents[0])."
            for _ in 0..<digits {
                coeficient.append("0")
            }
        case 2:
            for _ in coeficientComponents[1].count..<digits {
                coeficient.append("0")
            }
        default:
            return String(self).padded().noExp
        }
        coeficient = String(coeficient.padded().suffix(12))
        var exponent: String
        if exp == 0 {
            exponent = String().noExp
        } else {
            exponent = exp < 0 ? "-" : " "
            let abs = abs(exp)
            exponent += abs < 10 ? "0\(abs)" : "\(abs)"
        }
        return coeficient + exponent
    }

    /// Used for Stack inspection only
    func stringValue(withSize size: Int) -> String {
        var string = String(self)
        guard string.count < size else { return string }
        for _ in string.count..<size {
            string += " "
        }
        return string
    }

    var toRad: Double {
        (self * Double.pi)/180
    }

    var toDeg: Double {
        (self * 180)/Double.pi
    }

    var toH: Double {
//        if value > 1000000 {
//            updateDisplayWithStackPush(value)
//            return
//        }
//        let components = string.components(separatedBy: ".")
//        let integerString = components[0]
//        var fractionString = ""
//        var minutesString = ""
//        var secondsString = ""
//        if components.count > 1 {
//            fractionString = components[1]
//        }
//        switch fractionString.count {
//        case 0: break
//        case 1: minutesString = fractionString + "0"
//        case 2: minutesString = fractionString
//        case 3:
//            minutesString = String(fractionString.prefix(2))
//            secondsString = String(fractionString.suffix(fractionString.count - 2)) + "0"
//        case 4:
//            minutesString = String(fractionString.prefix(2))
//            secondsString = String(fractionString.suffix(fractionString.count - 2))
//        default:
//            minutesString = String(fractionString.prefix(2))
//            var reminder = String(fractionString.suffix(fractionString.count - 2))
//            secondsString = String(reminder.prefix(2))
//            reminder = String(reminder.suffix(reminder.count - 2))
//            secondsString = secondsString + "." + reminder
//        }
//        let hours = Double(integerString) ?? 0.0
//        let minutes = (Double(minutesString) ?? 0.0)/60.0
//        let seconds = (Double(secondsString) ?? 0.0)/60.0/60.0
//        value = hours + minutes + seconds
//        updateDisplayWithStackPush(value)
        self
    }

    var toHMS: Double {
        let integer = Int(trunc(self))
        let fraction = self - Double(integer)
        var seconds = fraction * 3600
        let minutes = trunc(seconds/60)
        let minutesString = minutes < 10 ? "0\(Int(minutes))" : "\(Int(minutes))"
        seconds = seconds - minutes * 60
        var secondsString = "\(seconds)"
        secondsString = secondsString.replacingOccurrences(of: ".", with: "")
        let hms = "\(integer)." + minutesString + secondsString
        return Double(hms) ?? self
    }

    var cmToIn: Double {
        return self / 2.54 // 1 In = 2.54 cms.
    }

    var kgToLb: Double {
        return self / 0.453_592_37 // 1 Lb = 0.45359237 Kg.
    }

    var ltrToGal: Double {
        return self / 3.785_411_784 // 1 Gal = 3.785411784 Ltr.
    }

    private var timeString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
        formatter.unitsStyle = .positional
        return formatter.string(from: self) ?? ""
    }

    func convertFrom(_ degrees: Degrees) -> Double {
        switch degrees {
        case .rad: return self
        case .deg: return self.toRad
        default: return self
        }
    }

    func convertTo(_ degrees: Degrees) -> Double {
        switch degrees {
        case .rad: return self
        case .deg: return self.toDeg
        default: return self
        }
    }

    var factorial: Int? {
        func fact(_ n: Int) -> Int {
            if n == 0 { return 1 }
            return n * fact(n - 1)
        }

        guard self >= 0 else { return nil }
        return fact(Int(self))
    }
}

enum Degrees {
    case deg, rad, grd

    var name: String {
        switch self {
        // case .deg: return ""
        default: return "\(self)".uppercased()
        }
    }
}
