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
    var display = Display()
    var stack = Stack()
    var fShiftKey: Bool = false // arc in HP-35, orangeKey in HP-45

    var didLstX = false

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
        display.delegate = self
        stack.delegate = display
    }

    func processOps(_ ops: [Op]) {
        // print("Process: \(ops.names)")
        guard ops.count > 0 else { return }
        var op: Op = ops[0]
        if op != .clrX && displayInfo.error { return }
        if op == .fix {
            display.enteringFormat = true
            print("Op: Fix")
            return
        }
        if display.enteringFormat {
            display.processFormatInput(ops)
            display.enteringFormat = false
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
                display.info.degrees = op == .deg ? .deg : .rad
                return
            }
        } else {
            op = ops[0]
        }
        switch op {
        case .fShift:
            print("Op: \(.hp35 ? "arc" : "shift")")
            fShiftKey = true
        case .eex: display.processEEXInput()
        case .digit(let input):
            if display.enteringEex {
                guard input != "." else { return }
                guard let first = display.expInput.first else { return }
                display.expInput = String((display.expInput.dropFirst() + input).suffix(2))
                display.expInput = "\(first)\(display.expInput)"
                processEEX()
                return
            }
            guard display.numericInput.count < 12 else { return }
            if (display.numericInput + input).isNumeric {
                display.numericInput += input
                if display.numericInput == "." {
                    display.numericInput = "0."
                }
                if display.numericInput.starts(with: "-0") {
                    display.numericInput = display.numericInput.replacingOccurrences(of: "-0", with: "-")
                }
                if let value = Double(display.numericInput) {
                    print("Digit Input: \(value)")
                    if stack.shouldLiftAtInput {
                        stack.lift()
                        stack.shouldLiftAtInput = false
                    }
                    stack.regX = value
                    display.update(with: display.numericInput.padded(keepZeros: true))
                }
                stack.inspect()
            }
        case .enter:
            display.processEnter()
            stack.lift(stack.regX)
            stack.inspect()
        case .delete:
            guard display.info.output != 0.format(display.numberOfDigits) else { return }
            display.numericInput = String(display.numericInput.dropLast())
            if display.numericInput.count == 0 {
                display.update(with: 0.format(display.numberOfDigits), addExponent: false)
                return
            }
            display.update(with: display.numericInput, addExponent: false)
        case .chs:
            print("Op: \(op)")
            if display.enteringEex {
                if let first = display.expInput.first {
                    let exp = String(display.expInput.suffix(2))
                    display.expInput = first == "-" ? " \(exp)" : "-\(exp)"
                }
                processEEX()
                return
            }
            if display.numericInput.isEmpty {
                stack.regX = -stack.regX
                display.numericInput = "-"
                if stack.regX == 0 {
                    display.info.output = "-0.".padded.noExp
                }
            } else {
                if display.numericInput.starts(with: "-") {
                    display.numericInput = String(display.numericInput.dropFirst())
                } else {
                    display.numericInput = "-\(display.numericInput)"
                }
                if let value = Double(display.numericInput) {
                    stack.regX = value
                }
            }
            stack.inspect()
        default:
            stack.processOp(op, displayInfo.degrees, display.numericInput.isEmpty)
            display.reset()
        }
    }

    func processEEX() {
        let exp = display.expInput.contains("-") ? display.expInput : String(display.expInput.suffix(2))
        guard let coeficient = Double(display.numericInput), let exponent = Double(exp) else { return }
        print("Digit Input: \(coeficient), exponent: \(exponent)")
        if stack.shouldLiftAtInput {
            stack.lift()
            stack.shouldLiftAtInput = false
        }
        stack.regX = coeficient * pow(10, exponent)
        display.update(with: display.numericInput)
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
