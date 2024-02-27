//
//  Stack2.swift
//  HP-35
//
//  Created by Enrique Haro on 1/13/24.
//

#if os(iOS)
import UIKit
#else
import AppKit
#endif
import SwiftUI

protocol StackDelegate {
    func stackDidUpdateRegX(value: Double)
}

class Stack {
    var delegate: StackDelegate?
    var shouldLiftAtInput: Bool = false // xIsResultAndShouldLiftAtNumericInput

    /// Previous Values used for Debugging purposes.
    var preT: Double = 0
    var preZ: Double = 0
    var preY: Double = 0
    var preX: Double = 0

    /// Registers
    var lstX: Double = 0
    var regS: Double = 0 // HP35 STO
    var regT: Double = 0
    var regZ: Double = 0
    var regY: Double = 0
    var regX: Double = 0 {
        didSet {
            delegate?.stackDidUpdateRegX(value: regX)
        }
    }

    func execute(_ operation: Op, degrees: Degrees = .deg) {
        print("Stack Op: \(operation)")
        switch operation {
        // NO OPERAND
        case .exchangeXY: exchangeXY()
        case .rotateUp: rotateUp()
        case .rotateDown: rotateDown()
        case .sto: regS       = regX
        case .rcl: regX       = regS

        case .pi: regX        = Double.pi
        case .random: regX    = Double.random(in: 0..<1)

        // SINGLE OPERAND
        case .sqrt: regX      = sqrt(regX)
        case .powTwo: regX    = pow(regX, 2.0)
        case .inverse: regX   = 1/regX
        case .abs: regX       = abs(regX)
        case .chs: regX       = regX * -1.0

        case .log: regX       = log10(regX)
        case .tenX: regX      = pow(10, regX)
        case .ln: regX        = log(regX)
        case .ex: regX        = pow(exp(1), regX)

        case .sin: regX       = sin(regX.convertFrom(degrees))
        case .cos: regX       = cos(regX.convertFrom(degrees))
        case .tan: regX       = tan(regX.convertFrom(degrees))
        case .asin: regX      = asin(regX).convertTo(degrees)
        case .acos: regX      = acos(regX).convertTo(degrees)
        case .atan: regX      = atan(regX).convertTo(degrees)

        case .frac: regX      = regX - trunc(regX)
        case .int: regX       = trunc(regX)

        case .toDeg: regX     = regX.toDeg
        case .toRad: regX     = regX.toRad

        // case .toH: regX       = regX.toH
        // case .toHMS: regX     = regX.toHMS

        // DOUBLE OPERAND
        case .add: regX        = regY + regX
        case .substract: regX  = regY - regX
        case .multiply: regX   = regY * regX
        case .divide: regX     = regY / regX
        case .powerYX: regX    = pow(regY, regX)
        case .powerXY: regX    = pow(regX, regY) // HP35
        case .root: regX       = pow(regY, 1/regX)
        case .percentage: regX = regY * regX/100

        /// MISC
        case .clr: clear()
        case .clrX: regX       = 0.0
        case .lstX: lift(lstX)
        default: print("NOP: \(operation)")
        }
    }

// MARK: - Stack Operations
    /// Stack Clear
    func clear() {
        regX = 0
        regY = 0
        regZ = 0
        regT = 0
        regS = 0
        lstX = 0
        copyValues()
    }

    /// Stack Lift Operation for new input
    func lift(_ value: Double) {
        lift()
        regX = value
    }

    func lift() {
        copyValues()
        regT = regZ
        regZ = regY
        regY = regX
        /// regX is ready to be updated
    }

    func drop() {
        regY = regZ
        regZ = regT
        /// regT stays as constant
    }

    func rotateUp() {
        copyValues()
        let x = regX
        regX = regT
        regT = regZ
        regZ = regY
        regY = x
    }

    func rotateDown() {
        copyValues()
        let x = regX
        regX = regY
        regY = regZ
        regZ = regT
        regT = x
    }

    func exchangeXY() {
        copyValues()
        let x = regX
        regX = regY
        regY = x
    }

    func copyValues() {
        preT = regT
        preZ = regZ
        preY = regY
        preX = regX
    }
}

extension Stack {
    func inspect() {
        var max = 0
        let regs = [preX, preY, preZ, preT]
        for reg in regs where String(reg).count > max {
            max = String(reg).count
        }
        print("===== STACK =====")
        print("regT: \(preT.padded(max)) -> \(regT)")
        print("regZ: \(preZ.padded(max)) -> \(regZ)")
        print("regY: \(preY.padded(max)) -> \(regY)")
        print("regX: \(preX.padded(max)) -> \(regX)")
        print("STO:  \(regS)")
        print()
    }
}
