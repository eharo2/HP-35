//
//  Input.swift
//  HP-35
//
//  Created by Enrique Haro on 1/12/24.
//

import SwiftUI

enum Op: Identifiable, Equatable {
    var id: String { UUID().uuidString }

    case digit(_ value: String)
    case enter

    /// Single Operand
    case sqrt, powTwo
    case log, tenX, ln, ex
    case sin, cos, tan, asin, acos, atan
    case frac, int, abs, chs, inverse, factorial, percentage
    case toDeg, toRad

    /// Two Operands
    case powerXY // HP35
    case powerYX, root
    case add, substract, multiply, divide

    /// No Operand
    case pi, random

    /// Misc
    case clr, clrX, lstX
    case toP, toR // Polar / Cartesian
    case toH, toHMS

    case fix, sci, eng
    case eex
    case deg, rad, grd

    case rotateDown, rotateUp, exchangeXY
    case delete
    case sto, rcl
    case fShift // arc in HP-35, orangeKey in HP-45
    case none

    // HP35
    var shouldDrop: Bool {
        switch self {
        case .add, .substract, .multiply, .divide, .powerXY, .powerYX: true
        default: false
        }
    }

    var shouldLift: Bool {
        switch self {
        case .pi, .rcl: true
        default: false
        }
    }

    var noLift: Bool {
        switch self {
        case .sqrt, .powTwo, .inverse, .log, .tenX, .ln, .ex, .pi, .chs: true
        case .toP, .toR: true
        default: false
        }
    }

    var isTrigonometric: Bool { // Lift regZ
        switch self {
        case .sin, .cos, .tan, .asin, .acos, .atan: true
        default: false
        }
    }

    var noStackOperation: Bool {
        switch self {
        case .clr, .clrX, .exchangeXY, .rotateDown, .sto: true
        default: false
        }
    }

    var isArcOp: Bool {
        let ops: [Op] = [.sin, .cos, .tan, .asin, .acos, .atan]
        return ops.contains(self)
    }
}
