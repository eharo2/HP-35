//
//  Bool.swift
//  RPN-35
//
//  Created by Enrique Haro on 3/6/24.
//

import Foundation

extension Bool {
    static var mac: Bool {
#if os(macOS)
        return true
#else
        return false
#endif
    }

    static var hp35: Bool {
        Global.model == .hp35
    }

    static var hp45: Bool {
        Global.model == .hp45
    }

    static var hp21: Bool {
        Global.model == .hp21
    }
}
