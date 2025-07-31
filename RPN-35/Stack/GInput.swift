//
//  GInput.swift
//  RNP Calculator
//
//  Created by Enrique Haro on 3/19/22.
//

import Foundation
import Darwin

//extension MainView.ViewModel {
//    func gInput() {
//        switch index {
//        case 0, 1, 2, 4, 5, 6, 7, 8, 9, 10, 11,
//             12, 13, 14, 15, 16, 17, 18, 19: gAritmeticInput()
//        default: break
//        }
//        input = .baseInput
//        if index == 20 {
//            input = .fInput
//        }
//        if index == 21 {         // Reset
//            input = .baseInput
//        }
//    }
//
//    func gAritmeticInput() {
//        if state.baseInput.isNotEmpty { enter() }
//        switch index {
//        case 0: deg()
//        case 1: rad()
//        case 2: prefix()
//        case 4: toP()
//        case 5: toH()
//        case 6: toRad()
//        case 7: stackRotateUp()
//        case 8: square()
//        case 9: ln()
//        case 10: log()
//        case 11: inverse()
//        case 12: arcSin()
//        case 13: arcCos()
//        case 14: arcTan()
//        case 15: absolute()
//        case 16: e()
//        case 17: factorial()
//        case 18: random()
//        default: fraction()
//        }
//        if index != 0 { // Error in toP() handled in function
//            // displayUpdate()
//        }
//    }
//
//    func deg() {
//        isRadians = false
//        state.showRADLabel = false
//    }
//
//    func rad() {
//        isRadians = true
//        state.showRADLabel = true
//    }
//
//    func prefix() {
//    }
//
//    func toP() {
//        let regX = stack.pop() //                       x
//        let regY = stack.pop() //                       y
//        let r = sqrt(pow(regX, 2) + pow(regY, 2))
//        var angle = Darwin.acos(regX/r)
//        if regY < 0.0 && r != 0.0 {
//            angle = -angle
//        } else if r != 0.0 {
//            angle = isRadians ? angle : angle.degrees()
//            stack.push(angle)
//            updateDisplayWithStackPush(r)
//        } else {
//            displayError(0)
//        }
//    }
//
//
//    func toRad() {
//        let regX = stack.pop()
//        updateDisplayWithStackPush(regX.radians())
//    }
//
//    func stackRotateUp() {
//        if state.baseInput.isNotEmpty {
//            enter()
//        }
//        let regT = stack.regT()
//        updateDisplayWithStackPush(regT)
//    }
//
//    func square() {
//        let regX = stack.pop()
//        updateDisplayWithStackPush(regX * regX)
//    }
//
//    func ln() {
//        let regX = stack.pop()
//        updateDisplayWithStackPush(Darwin.log(regX))
//    }
//
//    func log() {
//        let regX = stack.pop()
//        updateDisplayWithStackPush(Darwin.log10(regX))
//    }
//
//    func inverse() {
//        let regX = stack.pop()
//        if regX == 0 {
//            displayError(0)
//        } else {
//            updateDisplayWithStackPush(1 / regX)
//        }
//    }
//
//    func absolute() {
//        let regX = stack.pop()
//        updateDisplayWithStackPush(abs(regX))
//    }
//
//    func arcSin() {
//        let regX = stack.pop()
//        var arc = Darwin.asin(regX)
//        if !isRadians { arc = arc.degrees() }
//        updateDisplayWithStackPush(arc)
//    }
//
//    func arcCos() {
//        let regX = stack.pop()
//        var arc = Darwin.acos(regX)
//        if !isRadians { arc = arc.degrees() }
//        updateDisplayWithStackPush(arc)
//    }
//
//    func arcTan() {
//        let regX = stack.pop()
//        var arc = Darwin.atan(regX)
//        if !isRadians { arc = arc.degrees() }
//        updateDisplayWithStackPush(arc)
//    }
//
//    func e() {
//        updateDisplayWithStackPush(Darwin.M_E)
//    }
//
//    func factorial() {
//        let intRegX = Int(stack.pop())
//        let factorial = (1...intRegX).map(Double.init).reduce(1.0, *)
//        updateDisplayWithStackPush(factorial)
//    }
//
//    func random() {
//        updateDisplayWithStackPush(Double.random(in: 0.0..<1.0))
//    }
//
//    func fraction() {
//        let regX = stack.pop()
//        updateDisplayWithStackPush(regX - trunc(regX))
//    }
//}
