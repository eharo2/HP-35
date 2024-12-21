//
//  Input.swift
//  RPN-35
//
//  Created by Enrique Haro on 1/12/24.
//

import SwiftUI

indirect enum Op: Identifiable, Equatable {
    var id: String { UUID().uuidString }

    case digit(_ value: String)
    case enter

    /// Single Operand
    case sqrt, powTwo
    case log, tenX, ln, ex
    case sin, cos, tan, asin, acos, atan
    case frac, int, abs, chs, inverse, factorial, percentage, delta
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

    // HP-45
    case toDMS, fromDMS
    case cmIn, kgLb, ltrGal // Metric conversions

    case fix, sci, eng
    case eex
    case deg, rad, grd

    case rotateDown, rotateUp, exchangeXY
    case delete
    case sto(_ value: Int, op: Op), rcl(_ value: Int, op: Op)
    case fShift // arc in HP-35, orangeKey in HP-45, blue in HP-21
    case none

    // HP-21
    case mSubstract, mAdd, mMultiply, mDivide
    case dsp

    // HP-35
    var shouldDrop: Bool {
        switch self {
        case .add, .substract, .multiply, .divide, .powerXY, .powerYX: true
        default: false
        }
    }

    var shouldLift: Bool {
        switch self {
        case .pi, .rcl: true
        // HP-21
        case .mSubstract, .mAdd, .mMultiply, .mDivide: true
        case .sto: .isHP21
        default: false
        }
    }

    var noLift: Bool {
        switch self {
        case .sqrt, .powTwo, .inverse, .log, .tenX, .ln, .ex, .pi, .chs: true
        case .toP, .toR, .factorial, .percentage, .delta: true
        case .cmIn, .kgLb, .ltrGal: true
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
        case .clr, .clrX, .exchangeXY, .rotateDown: true
        case .lstX: true // HP-45
        case .toDMS, .fromDMS: true
        case .sto: !.isHP21 // HP-21
        default: false
        }
    }

    var isArcOp: Bool {
        let ops: [Op] = [.sin, .cos, .tan, .asin, .acos, .atan]
        return ops.contains(self)
    }
}

extension Op {
    var name: String {
        var name = String("\(self)".split(separator: ".").last ?? "")
        // name = String(name.replacingOccurrences(of: ")", with: ""))
        name = String(name.replacingOccurrences(of: "\"", with: ""))
        name = String(name.replacingOccurrences(of: "\\", with: ""))
        return ".\(name)"
    }
}

extension [Op] {
    var names: String {
        "\(self.map { $0.name })".replacingOccurrences(of: "\"", with: "")
    }
}
