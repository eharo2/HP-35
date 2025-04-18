//
//  String.swift
//  RPN-35
//
//  Created by Enrique Haro on 1/23/24.
//

import Foundation
import RegexBuilder

extension String {
    static let enter = "\r"
    static let delete = "\u{7f}"

    var isNumeric: Bool {
        guard !self.isEmpty else { return false }
        guard let regex = try? NSRegularExpression(pattern: "^-?\\d*\\.?\\d*$",
                                                   options: .caseInsensitive) else { return false }
        let range = NSRange(location: .zero, length: self.utf16.count)
        let matches = regex.matches(in: self, range: range)
        return matches.count == 1
    }

    var isFixedFormat: Bool {
        guard !self.isEmpty else { return false }
        return self.matches("ff\\d$")
    }

    func zeroPadded(digits: Int) -> String {
        if self.count >= digits { return String(self.prefix(digits)) }
        var string = self
        for _ in self.count..<digits {
            string += "0"
        }
        return string
    }

    // Strips trailing '0's and add spaces up to 12 spaces
    func padded(digits: Int = 12, keepZeros: Bool = false) -> String {
        let truncated = String(String(self).prefix(digits))
        let components = truncated.components(separatedBy: ".")
        var string = self
        switch components.count {
        case 2:
            string = components[1]
            if !keepZeros {
                for _ in 0..<string.count {
                    if let last = string.last {
                        if last == "0" {
                            string = String(string.dropLast())
                        } else {
                            break
                        }
                    }
                }
            }
            string = "\(components[0]).\(string)"
        case 1: string = "\(components[0])."
        default: break
        }
        let upperBound = digits
        if string.count <= upperBound {
            for _ in string.count..<upperBound {
                string += " "
            }
        }
        return string
    }

    var noExp: String { self + "   " }
}

extension String {
    func matches(_ pattern: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern,
                                                   options: .caseInsensitive) else { return false }
        let range = NSRange(location: .zero, length: self.utf16.count)
        let matches = regex.matches(in: self, range: range)
        return matches.count == 1
    }

    func character(at index: Int) -> String? {
        guard index >= 0 && index < self.count else { return nil }
        let stringIndex = self.index(self.startIndex, offsetBy: index)
        return String(self[stringIndex])
    }
}
