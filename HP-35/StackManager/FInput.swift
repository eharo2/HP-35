//
//  FInput.swift
//  RNP Calculator
//
//  Created by Enrique Haro on 3/18/22.
//

import Foundation
import Darwin

//extension MainView.ViewModel {
//    func fInput() {
//        switch index {
//        case 0: input = .fixInput
//        case 1: input = .sciInput
//        case 2: input = .engInput
//        case 7: stackRotateDown()
//        case 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19: fAritmeticInput()
//        case 22: clx()
//        default: break
//        }
//        if  input != .eexInput &&
//            input != .fixInput &&
//            input != .sciInput &&
//            input != .engInput {
//            input = .baseInput
//        }
//        if index == 20 {            // Reset
//            input = .baseInput
//        }
//        if index == 21 {
//            input = .gInput
//        }
//    }
//
//    func notationInput() {
//        state.display.numberOfDigits = valueForIndex()
//        switch input {
//        case .sciInput: state.notation = .sci
//        case .engInput: state.notation = .eng
//        default: state.notation = .fix
//        }
//        input = .baseInput
//        state.savedisplay.numberOfDigits()      // Save in UserDefaults
//        state.saveNotation()            // Save in UserDefaults
//    }
//
//    func fAritmeticInput() {
//        if state.baseInput.isNotEmpty { enter() }
//        switch index {
//        case 4: toR()
//        case 5: toHMS()
//        case 6: toDeg()
//        case 8: squareRoot()
//        case 9: ePowerX()
//        case 10: tenPowerX()
//        case 11: yPowerX()
//        case 12: sin()
//        case 13: cos()
//        case 14: tan()
//        case 15: changeSign()
//        case 16: pi()
//        case 17: percentage()
//        case 18: exchangeRegsXY()
//        default: integerPart()
//        }
//    }
//
//    func toR() {
//        let regX = stack.pop() // r
//        let regY = stack.pop() // angle
//        let angle = isRadians ? regY : regY.radians()
//        let x = regX * Darwin.cos(angle) // x = r * cos(angle)
//        let y = regX * Darwin.sin(angle) // y = r * sin(angle)
//        stack.push(y)
//        updateDisplayWithStackPush(x)
//    }
//
//    func toHMS() {
//        let value = valueFromInputOrStackPop()
//        let integer = Int(trunc(value))
//        let fraction = value - Double(integer)
//        var seconds = fraction * 3600
//        let minutes = trunc(seconds/60)
//        let minutesString = minutes < 10 ? "0\(Int(minutes))" : "\(Int(minutes))"
//        seconds = seconds - minutes * 60
//        var secondsString = "\(seconds)"
//        secondsString = secondsString.replacingOccurrences(of: ".", with: "")
//        let hms = "\(integer)." + minutesString + secondsString
//        updateDisplayWithStackPush(Double(hms) ?? 0.0)
//    }
//
//    func toDeg() {
//        let regX = stack.pop()
//        updateDisplayWithStackPush(regX.degrees())
//    }
//
//    func stackRotateDown() {
//        if state.baseInput.isNotEmpty {
//            enter()
//        }
//        let regX = stack.pop()
//        stack.setRegT(regX)
//        updateDisplay(stack.peek())
//    }
//
//    func squareRoot() {
//        let regX = stack.pop()
//        updateDisplayWithStackPush(regX.squareRoot())
//    }
//
//    func ePowerX() {
//        let regX = stack.pop()
//        let e = Darwin.M_E
//        updateDisplayWithStackPush(pow(e, regX))
//    }
//
//    func tenPowerX() {
//        let regX = stack.pop()
//        updateDisplayWithStackPush(pow(10, regX))
//    }
//
//    func yPowerX() {
//        let regX = stack.pop()
//        let regY = stack.pop()
//        updateDisplayWithStackPush(pow(regY, regX))
//    }
//
//    func sin() {
//        var regX = stack.pop()
//        if !isRadians { regX = regX.radians() }
//        updateDisplayWithStackPush(Darwin.sin(regX))
//    }
//
//    func cos() {
//        var regX = stack.pop()
//        if !isRadians { regX = regX.radians() }
//        updateDisplayWithStackPush(Darwin.cos(regX))
//    }
//
//    func tan() {
//        var regX = stack.pop()
//        if !isRadians { regX = regX.radians() }
//        updateDisplayWithStackPush(Darwin.tan(regX))
//    }
//
//    func changeSign() {
//        if state.eexInput.isNotEmpty {
//            input = .eexInput
//            eexChangeSign()
//        } else {
//            let regX = stack.pop()
//            if regX != 0 {
//                updateDisplayWithStackPush(regX * -1.0)
//            }
//        }
//    }
//
//    func pi() {
//        updateDisplayWithStackPush(Double.pi)
//    }
//
//    func percentage() {
//        let regX = stack.pop()
//        let regY = stack.pop()
//        updateDisplayWithStackPush(regY * regX/100)
//    }
//
//    func exchangeRegsXY() {
//        let regX = stack.pop()
//        let regY = stack.pop()
//        stack.push(regX)
//        updateDisplayWithStackPush(regY)
//    }
//
//    func integerPart() {
//        let regX = stack.pop()
//        updateDisplayWithStackPush(trunc(regX))
//    }
//
//    func clx() {
//        _ = stack.pop()
//        updateDisplayWithStackPush(0.0)
//    }
//}
