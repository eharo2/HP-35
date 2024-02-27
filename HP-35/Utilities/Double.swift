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
        self
    }

    var toHMS: Double {
        self
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
