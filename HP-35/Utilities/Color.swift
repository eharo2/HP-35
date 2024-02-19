//
//  Color.swift
//  RNP Calculator
//
//  Created by Enrique Haro on 3/13/22.
//

import SwiftUI

extension Color {
    static let keyOrange = Self(hex: 0xFF8615)
    static let keyBlue = Self(hex: 0xADDDF6)
    static let lcd = Self(hex: 0x93C3DA)
    // static let keypadBackground = Self(hex: 0x484848)
    static let keypadBackground = Self(hex: 0x383838)
    static let darkGray = Self(hex: 0x202020)
    #if os(macOS)
    static func gray(_ value: CGFloat) -> Color { Color(NSColor(white: value, alpha: 1)) }
    #else
    static func gray(_ value: CGFloat) -> Color { Color(UIColor(white: value, alpha: 1)) }
    #endif

    // HP35
    static let displayRed = Color(hex: 0x220000)
    static let gray35 = Color(hex: 0x4A453E)
    static let fKey35 = Color(hex: 0xD9CCA6)

    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF)/255,
            green: Double((hex >> 8) & 0xFF)/255,
            blue: Double(hex & 0xFF)/255,
            opacity: alpha
        )
    }
}
