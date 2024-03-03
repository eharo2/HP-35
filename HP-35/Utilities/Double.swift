//
//  Double.swift
//  HP-35
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
    func scientificNotation() -> String {
        guard abs(self) < pow(10, 100) else { return "9.9999999999 99" }
        guard abs(self) > pow(10, -99) else { return "0.             " }
        guard self > pow(10, 10) || self < pow(10, -2) else { return String(self).padded.noExp }
        let scientificNotation = String(format: "%.12e", self)
        let components = scientificNotation.components(separatedBy: "e")
        guard components.count == 2, let exp = Int(components[1]) else {
            return String(self).padded.noExp
        }
        let coeficient = components[0].padded
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

    func padded(_ size: Int) -> String {
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
}

enum Degrees {
    case deg, rad, grd

    var name: String {
        switch self {
        case .deg: return ""
        default: return "\(self)".uppercased()
        }
    }
}
