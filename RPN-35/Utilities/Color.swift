//
//  Color.swift
//  RNP Calculator
//
//  Created by Enrique Haro on 3/13/22.
//

import SwiftUI

extension Color {
    // static let keyOrange = Self(hex: 0xFF8615)
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

    static let displayRed = Color(hex: 0x220000)
    static let gray35 = Color(hex: 0x4A453E)
    static let fKey35 = Color(hex: 0xD9CCA6)

    // HP35
    static let keyCyan35 = Color(hex: 0x67C1F7)
    static let keyBrown35 = Color(hex: 0x989798)

    static let keyOrange45 = Color(hex: 0xD48400)
    static let keyGray45 = Color(hex: 0x3B4445)
    static let keyBlack45 = Color(hex: 0x1F2527)
    static let keyLightGray45 = Color(hex: 0x9BA993)
    static let keyWhite45 = Color(hex: 0xE5E5CB)

    // HP21
    static let hp21_yellow = Color(hex: 0xD7BD99)
    static let hp21_black = Color(hex: 0x363436)
    static let hp21_blue = Color(hex: 0x33B4CC)

    // MK61
    static let mk61_white = Color(hex: 0xE5E5CB)
    static let mk61_yellow = Color(hex: 0xEAD006)
    static let mk61_blue = Color(hex: 0x00C5F3)
    static let mk61_red = Color(hex: 0xDF4B52)


    static let mk61_ledGreen = Color(hex: 0x90E2B1)
    static let mk61_displayGreen = Color(hex: 0x254030)
    static let mk61_ledGreenBack = Color(hex: 0x598C8D)

    init(hex: UInt, brightness: Double = 1.0, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF)/255.0 * brightness,
            green: Double((hex >> 8) & 0xFF)/255.0 * brightness,
            blue: Double(hex & 0xFF)/255.0 * brightness,
            opacity: alpha
        )
    }
}
