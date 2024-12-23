//
//  Stack2.swift
//  RPN-35
//
//  Created by Enrique Haro on 1/13/24.
//

import SwiftUI

protocol StackDelegate {
    func stackDidUpdateRegX(value: Double)
    func stackDidUpdateError(error: Bool)
}

class Stack {
    var delegate: StackDelegate?
    var shouldLiftAtInput: Bool = false // xIsResultAndShouldLiftAtdisplay.numericInput

    /// Previous Values used for Debugging purposes.
    var preT: Double = 0
    var preZ: Double = 0
    var preY: Double = 0
    var preX: Double = 0

    /// Registers
    var lstX: Double = 0 // HP45
    var regS: Double = 0 // HP35 STO
    var regT: Double = 0
    var regZ: Double = 0
    var regY: Double = 0
    var regX: Double = 0 {
        didSet {
            lstX = oldValue
            delegate?.stackDidUpdateRegX(value: regX)
        }
    }
    // HP-45
    var regsSTO: [Double] = Array(repeating: 0.0, count: 10) // 0 not used.  STO n = index
    var sigmaArray: [Double] = .init() // Used for std deviation

    func processOp(_ op: Op, _ degrees: Degrees, _ numericInputIsEmpty: Bool) {
        if op.shouldDrop {
            executeOp(op)
            drop()
            shouldLiftAtInput = true
        } else if op.shouldLift {
            if shouldLiftAtInput || !numericInputIsEmpty {
                lift()
            }
            executeOp(op)
        } else if op.noLift || op.noStackOperation {
            executeOp(op)
        } else if op.isTrigonometric {
            executeOp(op, degrees: degrees)
        } else {
            print("No Op: \(op)")
        }
        shouldLiftAtInput = !op.noStackOperation
        inspect()
    }

    func executeOp(_ op: Op, degrees: Degrees = .deg) {
        print("Stack Op: \(op). regY: \(regY), regX: \(regX)")
        switch op {
        // DOUBLE OPERAND
        case .add: regX        = regY + regX
        case .substract: regX  = regY - regX
        case .multiply: regX   = regY * regX
        case .divide:
            if regX == 0 {
                delegate?.stackDidUpdateError(error: true)
                return
            }
            regX     = regY / regX
        case .powerYX: regX = pow(regY, regX)
        case .powerXY:
            if regX <= 0 {
                delegate?.stackDidUpdateError(error: true)
                return
            }
            regX = pow(regX, regY) // HP35
        case .root: regX       = pow(regY, 1/regX)

        // SINGLE OPERAND
        case .sqrt:
            if regX < 0 {
                delegate?.stackDidUpdateError(error: true)
                return
            }
            regX = sqrt(regX)
        case .powTwo: regX    = pow(regX, 2.0)
        case .inverse: regX   = 1/regX
        case .abs: regX       = abs(regX)
        case .chs: regX       = regX * -1.0

        case .log:
            if regX <= 0 {
                delegate?.stackDidUpdateError(error: true)
                return
            }
            regX = log10(regX)
        case .tenX: regX      = pow(10, regX)
        case .ln:
            if regX <= 0 {
                delegate?.stackDidUpdateError(error: true)
                return
            }
            regX = log(regX)
        case .ex: regX        = pow(exp(1), regX)

        case .sin: regX       = sin(regX.convertFrom(degrees))
        case .cos: regX       = cos(regX.convertFrom(degrees))
        case .tan: regX       = tan(regX.convertFrom(degrees))
        case .asin:
            if abs(regX) > 1 {
                delegate?.stackDidUpdateError(error: true)
                return
            }
            regX = asin(regX).convertTo(degrees)
        case .acos:
            if abs(regX) > 1 {
                delegate?.stackDidUpdateError(error: true)
                return
            }
            regX = acos(regX).convertTo(degrees)
        case .atan: regX       = atan(regX).convertTo(degrees)

        case .frac: regX       = regX - trunc(regX)
        case .int: regX        = trunc(regX)

        case .percentage: regX = regY * regX/100
        case .delta: regX      = (regX/regY - 1) * 100

        case .toDeg: regX      = regX.toDeg
        case .toRad: regX      = regX.toRad

        case .toP:
            let r = sqrt(pow(regX, 2) + pow(regY, 2))
            var angle = acos(regX/r)
            if regY < 0.0 {
                angle += Double.pi/2 * (regX < 0 ? 1 : 3)
            }
            regX = r
            regY = angle.convertTo(degrees)

        case .toR:
            let r = regX
            let angle = regY
            regX = r * cos(angle.convertFrom(degrees))
            regY = r * sin(angle.convertFrom(degrees))

        case .toH: regX   = regX.toH //.fromHMS in HP-45
        case .toHMS: regX = regX.toHMS

        case .factorial:
            if let factorial = regX.factorial {
                regX = Double(factorial)
            } else {
                delegate?.stackDidUpdateError(error: true)
            }

        // HP-45
        case .cmIn: regX = regX.cmToIn
        case .kgLb: regX = regX.kgToLb
        case .ltrGal: regX = regX.ltrToGal
        case .toDMS: regX = regX.toDMS
        case .fromDMS: regX = regX.fromDMS

        // HP-21
        case .mSubstract: regS -= regX
        case .mAdd: regS += regX
        case .mMultiply: regS = regS * regX
        case .mDivide: regS = regS / regX

        // NO OPERAND
        case .exchangeXY: exchangeXY()
        case .rotateUp: rotateUp()
        case .rotateDown: rotateDown()
        case .sto(let value, let op):
            if value == 0 {
                regS = regX
                regX = regS // Force FIX
            } else {
                let tempX = regX
                switch op {
                case .mAdd: regsSTO[value] += regX
                case .mSubstract: regsSTO[value] -= regX
                case .mMultiply: regsSTO[value] *= regX
                case .mDivide:
                    if regX > 0.0 {
                        regsSTO[value] /= regX
                    } else {
                        delegate?.stackDidUpdateError(error: true)
                    }
                default: regsSTO[value] = regX
                }
                regX = tempX // Force FIX
                inspectSTO(sto: value)
            }
        case .rcl(let value, let op):
            if value == 0 {
                regX = regS
            } else {
                switch op {
                case .mAdd: regX += regsSTO[value]
                case .mSubstract: regX -= regsSTO[value]
                case .mMultiply: regX *= regsSTO[value]
                case .mDivide:
                    if regsSTO[value] > 0.0 {
                        regX /= regsSTO[value]
                    } else {
                        delegate?.stackDidUpdateError(error: true)
                    }
                default: regX = regsSTO[value]
                }
                inspectSTO(sto: value)
            }
        case .stdDev:
            inspectStdDev()
            regX = sigmaArray.avg()
            regY = sigmaArray.std()
        case .pi: regX        = Double.pi
        case .random: regX    = Double.random(in: 0..<1)

        /// MISC
        case .clr: clear()
        case .clrX:
            delegate?.stackDidUpdateError(error: false)
            regX = 0.0
        case .lstX: lift(lstX)
        case .sumPlus:
            sigmaArray.append(regX)
            regsSTO[5] = Double(sigmaArray.count)
            regsSTO[6] += Double(Int(pow(regX, 2.0)))
            regsSTO[7] = sigmaArray.sum()
            regsSTO[8] += regY
            regX = regsSTO[5]
        default: print("NOP: \(op)")
        }
    }

// MARK: - Stack Operations
    /// Stack Clear
    func clear() {
        regX = 0.0
        regY = 0.0
        regZ = 0.0
        regT = 0.0
        regS = 0.0
        lstX = 0.0
        copyValues()

        // HP-45
        regsSTO[5] = 0.0 // Regs 1-4 are persisted until power off
        regsSTO[6] = 0.0
        regsSTO[7] = 0.0
        regsSTO[8] = 0.0
        regsSTO[9] = 0.0
        sigmaArray.removeAll()
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
        print("regT: \(preT.stringValue(withSize: max)) -> \(regT)")
        print("regZ: \(preZ.stringValue(withSize: max)) -> \(regZ)")
        print("regY: \(preY.stringValue(withSize: max)) -> \(regY)")
        print("regX: \(preX.stringValue(withSize: max)) -> \(regX)")
        if .isHP35 || .isHP21 {
            print("STO: \(regS)")
        } else {
            print("lstX: \(lstX)")
        }
        print()
    }

    func inspectSTO(sto: Int) {
        var max = 0
        let regs = [preX, regsSTO[sto]]
        for reg in regs where String(reg).count > max {
            max = String(reg).count
        }
        print("===== STO[1] =====")
        print("STO reg\(sto): \(regsSTO[sto])")
        print("STO regX: \(regX)")
        print()
    }

    func inspectStdDev() {
        print("===== StdDev =====")
        print("Count: \(sigmaArray.count)")
        print("Sum: \(sigmaArray.sum())")
        print("Mean: \(sigmaArray.avg())")
        print("stdDev: \(sigmaArray.std())")
    }
}
