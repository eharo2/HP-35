//
//  AppService.swift
//  HP-15
//
//  Created by Enrique Haro on 1/10/24.
//

import SwiftUI

class AppService: ObservableObject, StackDelegate {
    @Published var displayInfo = DisplayInfo()
    @Published var ops: [Op] = [] {
        didSet {
            guard !ops.isEmpty else { return }
            processOps(ops)
            Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false) { _ in
                self.ops = []
            }
        }
    }
    var stack = Stack()
    var numericInput = ""
    var expInput = "   "
    var numberOfDigits: Int = 2
    var didLstX = false

    var fShiftKey: Bool = false // arc in HP-35, orangeKey in HP-45
    var enteringEex: Bool = false

    init() {
#if os(macOS)
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event -> NSEvent? in
            guard !event.isARepeat else { return nil }
            let input = event.input
            guard !input.ops35.isEmpty else {
                print("Ignore: \(input)")
                return nil
            }
            self?.processOps(input.ops35)
            return nil
        }
#endif
        stack.delegate = self
        numberOfDigits = 12
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: false) { _ in
            self.stack.regX = 0
        }
    }

    func processOps(_ ops: [Op]) {
        var op: Op
        if fShiftKey {
            guard ops.count > 1 else {
                print("Ignore. After \(Global.model == .hp35 ? "'arc'" : "'shift'"): \(ops[0])")
                return
            }
            if Global.model == .hp35 && !ops[1].isArcOp {
                print("Ignore. No trigonometric op: \(ops[1])")
                return
            }
            op = ops[1]
            fShiftKey = false
        } else {
            op = ops[0]
        }
        switch op {
        case .fShift:
            print("Op: \(Global.model == .hp35 ? "arc" : "shift")")
            fShiftKey = true
        case .eex:
            enteringEex = true
            expInput = " 00"
            if numericInput.isEmpty {
                numericInput = "1.0"
            }
            displayInfo.output = numericInput.padded + expInput
        case .digit(let input):
            if enteringEex {
                guard input != "." else { return }
                guard let first = expInput.first else { return }
                expInput = String((expInput.dropFirst() + input).suffix(2))
                expInput = "\(first)\(expInput)"
                processEEX()
                return
            }
            if (numericInput + input).isNumeric {
                numericInput += input
                if numericInput == "." {
                    numericInput = "0."
                }
                if let value = Double(numericInput) {
                    print("Digit Input: \(value)")
                    if stack.shouldLiftAtInput {
                        stack.lift()
                        stack.shouldLiftAtInput = false
                    }
                    stack.regX = value
                    displayInfo.output = numericInput.padded + expInput
                }
                stack.inspect()
            }
        case .enter:
            numericInput = ""
            expInput = "   "
            enteringEex = false
            stack.lift(stack.regX)
            stack.inspect()
        case .delete:
            guard displayInfo.output != 0.format(numberOfDigits) else { return }
            numericInput = String(numericInput.dropLast())
            if numericInput.count == 0 {
                displayInfo.output = 0.format(numberOfDigits).padded.noExp
                return
            }
            displayInfo.output = numericInput.padded.noExp
        case .chs:
            print("Op: \(op)")
            if enteringEex {
                if let first = expInput.first {
                    let exp = String(expInput.suffix(2))
                    expInput = first == "-" ? " \(exp)" : "-\(exp)"
                }
                processEEX()
                return
            }
            if numericInput.isEmpty {
                if stack.shouldLiftAtInput {
                    stack.regX = -stack.regX
                } else {
                    numericInput = "-"
                    displayInfo.output = numericInput.padded + expInput
                }
            } else {
                if numericInput.starts(with: "-") {
                    numericInput = String(numericInput.dropFirst())
                } else {
                    numericInput = "-\(numericInput)"
                }
                if let value = Double(numericInput) {
                    stack.regX = value
                }
            }
            stack.inspect()
        default:
            if op.shouldDrop {
                stack.execute(op)
                stack.drop()
                stack.shouldLiftAtInput = true
            } else if op.shouldLift {
                if stack.shouldLiftAtInput || !numericInput.isEmpty {
                    stack.lift()
                }
                stack.execute(op)
            } else if op.noLift || op.noStackOperation {
                stack.execute(op)
            } else if op.isTrigonometric {
                stack.execute(op, degrees: displayInfo.degrees)
            } else {
                print("No Op \(op)")
            }
            stack.shouldLiftAtInput = !op.noStackOperation
            stack.inspect()
            reset()
        }
    }

    func processEEX() {
        let exp = expInput.contains("-") ? expInput : String(expInput.suffix(2))
        guard let coeficient = Double(numericInput), let exponent = Double(exp) else { return }
        print("Digit Input: \(coeficient), exponent: \(exponent)")
        if stack.shouldLiftAtInput {
            stack.lift()
            stack.shouldLiftAtInput = false
        }
        stack.regX = coeficient * pow(10, exponent)
        displayInfo.output = numericInput.padded + expInput
        stack.inspect()
    }

    func reset() {
        numericInput = ""
        expInput = "   "
        enteringEex = false
        displayInfo.fKey = false
        displayInfo.gKey = false
    }

    // MARK: - StackDelegate
    func stackDidUpdateRegX(value: Double) {
        displayInfo.output = value.scientificNotation()
    }
}

#if os(macOS)
extension NSEvent {
    var input: String {
        switch self.keyCode {
        case 123: "L"
        case 124: "R"
        case 125: "D"
        case 126: "U"
        default: self.characters ?? "?"
        }
    }
}
#endif
