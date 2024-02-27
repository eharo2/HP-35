//
//  Global.swift
//  HP-35
//
//  Created by Enrique Haro on 2/12/24.
//

import Foundation

struct Global {

    // HP35
    static var displayVerticalPadding: CGFloat = 0.0
    static var displayFontSize: CGFloat = 0.0
    static var fFontFactor = 1.0
    static var bFontFactor = 1.0
    static var keySizeFactor = 1.0

    init() {
        #if os(iOS)
        Self.displayVerticalPadding = 5.0
        Self.displayFontSize = 28
        Self.fFontFactor = 1.1
        Self.bFontFactor = 1.2
        Self.keySizeFactor = 1.1
        #else
        Self.displayVerticalPadding = 0.0
        Self.displayFontSize = 24.0
        Self.fFontFactor = 1.0
        Self.bFontFactor = 1.0
        Self.keySizeFactor = 1.0
    #endif
    }
}
