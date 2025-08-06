//
//  Int.swift
//  RPN35
//
//  Created by Enrique Haro on 8/5/25.
//

import Foundation

extension Double {
    var safeInt: Int? {
        guard Double(Int.max) >= self else { return nil }
        return Int(self)
    }
}
