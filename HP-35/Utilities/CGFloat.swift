//
//  CGFloat.swift
//  HP-35
//
//  Created by Enrique Haro on 3/6/24.
//

import Foundation

extension CGFloat {
    init(_ iOS: CGFloat, _ macOS: CGFloat) {
        #if os(iOS)
        self = iOS
        #else
        self = macOS
        #endif
    }
}
