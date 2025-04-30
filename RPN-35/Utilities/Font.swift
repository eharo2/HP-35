//
//  Font.swift
//  RPN35
//
//  Created by Enrique Haro on 3/2/25.
//

import SwiftUI

extension Font {
    static func hp15cFont(size: CGFloat) -> Font {
        Font.custom(CustomFont.hp15c.name, size: size)
    }

    static func mk61Font(size: CGFloat) -> Font {
        Font.custom(CustomFont.mk61.name, size: size)
    }

    static func century(size: CGFloat) -> Font {
        Font.custom("Century Gothic", size: size)
    }

    static func availableFonts() {
#if os(iOS)
        for fontFamilyNames in UIFont.familyNames {
            for fontName in UIFont.fontNames(forFamilyName: fontFamilyNames) {
                print("Font:\(fontName)")
            }
        }
#endif
    }
}

enum CustomFont {
    case hp15c, mk61

    var name: String {
        switch self {
        case .hp15c: "HP15C-Simulator-Font"
        case .mk61: "Saira"
        }
    }
}
