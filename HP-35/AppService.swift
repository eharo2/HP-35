//
//  AppService.swift
//  HP-15
//
//  Created by Enrique Haro on 1/10/24.
//

import SwiftUI

class AppService: ObservableObject, DisplayManagerDelegate {
    @Published var displayInfo = DisplayInfo()
    @Published var model: Model!
    @Published var ops: [Op] = [] {
        didSet {
            guard !ops.isEmpty else { return }
            processOps(ops)
            Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false) { _ in
                self.ops = []
            }
        }
    }
    var displayManager = DisplayManager()
    var stack = Stack()
    var fShiftKey: Bool = false // arc in HP-35, orangeKey in HP-45

    var didLstX = false

    // HP-45
    var formatInput = false

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
        model = Global.model
        displayManager.delegate = self
        stack.delegate = displayManager
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false) { _ in
            self.stack.regX = 0
        }
    }

    func processOps(_ ops: [Op]) {
        // print("Process: \(ops.names)")
        var op: Op = ops[0]
        if op == .fix {
            formatInput = true
            print("Op: Fix")
            return
        }
        if formatInput {
            displayManager.processFormatInput(ops)
            formatInput = false
            return
        }
        if fShiftKey {
            guard ops.count > 1 else {
                print("Ignore. After \(.hp35 ? "'arc'" : "'shift'"): \(ops[0])")
                return
            }
            if .hp35 && !ops[1].isArcOp {
                print("Ignore. No trigonometric op: \(ops[1])")
                return
            }
            op = ops[1]
            fShiftKey = false
            if op == .deg || op == .rad {
                self.displayManager.displayInfo.degrees = op == .deg ? .deg : .rad
                return
            }
        } else {
            op = ops[0]
        }
        switch op {
        case .fShift:
            print("Op: \(.hp35 ? "arc" : "shift")")
            fShiftKey = true
        case .eex: displayManager.processEEXInput()
        case .digit(let input):
            if displayManager.enteringEex {
                guard input != "." else { return }
                guard let first = displayManager.expInput.first else { return }
                displayManager.expInput = String((displayManager.expInput.dropFirst() + input).suffix(2))
                displayManager.expInput = "\(first)\(displayManager.expInput)"
                processEEX()
                return
            }
            if (displayManager.numericInput + input).isNumeric {
                displayManager.numericInput += input
                if displayManager.numericInput == "." {
                    displayManager.numericInput = "0."
                }
                if let value = Double(displayManager.numericInput) {
                    print("Digit Input: \(value)")
                    if stack.shouldLiftAtInput {
                        stack.lift()
                        stack.shouldLiftAtInput = false
                    }
                    stack.regX = value
                    displayManager.update(with: displayManager.numericInput)
                }
                stack.inspect()
            }
        case .enter:
            displayManager.processEnter()
            stack.lift(stack.regX)
            stack.inspect()
        case .delete:
            guard displayManager.displayInfo.output != 0.format(displayManager.numberOfDigits) else { return }
            displayManager.numericInput = String(displayManager.numericInput.dropLast())
            if displayManager.numericInput.count == 0 {
                displayManager.update(with: 0.format(displayManager.numberOfDigits), addExponent: false)
                return
            }
            displayManager.update(with: displayManager.numericInput, addExponent: false)
        case .chs:
            print("Op: \(op)")
            if displayManager.enteringEex {
                if let first = displayManager.expInput.first {
                    let exp = String(displayManager.expInput.suffix(2))
                    displayManager.expInput = first == "-" ? " \(exp)" : "-\(exp)"
                }
                processEEX()
                return
            }
            if displayManager.numericInput.isEmpty {
                if stack.shouldLiftAtInput {
                    stack.regX = -stack.regX
                } else {
                    displayManager.numericInput = "-"
                    displayManager.update(with: displayManager.numericInput)
                }
            } else {
                if displayManager.numericInput.starts(with: "-") {
                    displayManager.numericInput = String(displayManager.numericInput.dropFirst())
                } else {
                    displayManager.numericInput = "-\(displayManager.numericInput)"
                }
                if let value = Double(displayManager.numericInput) {
                    stack.regX = value
                }
            }
            stack.inspect()
        default:
            stack.processOp(op, displayInfo.degrees, displayManager.numericInput.isEmpty)
            displayManager.reset()
        }
    }

    func processEEX() {
        let exp = displayManager.expInput.contains("-") ? displayManager.expInput : String(displayManager.expInput.suffix(2))
        guard let coeficient = Double(displayManager.numericInput), let exponent = Double(exp) else { return }
        print("Digit Input: \(coeficient), exponent: \(exponent)")
        if stack.shouldLiftAtInput {
            stack.lift()
            stack.shouldLiftAtInput = false
        }
        stack.regX = coeficient * pow(10, exponent)
        displayManager.update(with: displayManager.numericInput)
        stack.inspect()
    }

    // MARK: - DisplayManagerDelegate
    func displayDidUpdateInfo(_ info: DisplayInfo) {
        displayInfo = info
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
