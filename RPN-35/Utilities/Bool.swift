//
//  Bool.swift
//  RPN-35
//
//  Created by Enrique Haro on 3/6/24.
//

import UIKit

extension Bool {
    static var mac: Bool {
#if os(macOS)
        return true
#else
        return false
#endif
    }

    static var isHP35: Bool {
        Global.model == .hp35
    }

    static var isHP45: Bool {
        Global.model == .hp45
    }

    static var isHP21: Bool {
        Global.model == .hp21
    }

    static var isMK61: Bool {
        Global.model == .mk61
    }

    static var iPad: Bool {
        !UIDevice.current.systemName.contains("iPhone")
        // UIDevice.current.userInterfaceIdiom == .pad
    }

    static var iPhone: Bool {
        !UIDevice.current.systemName.contains("iPad")
    }
}
