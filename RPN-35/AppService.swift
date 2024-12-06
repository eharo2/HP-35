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
    // HP-21
    @Published var hp21IsOn = true {
        didSet {
            if hp21IsOn {
                display.reset()
            }
        }
    }
    @Published var radIsOn = false
//    {
//        didSet {
//            displayInfo.degrees = radIsOn ? .rad : .deg
//        }
//    }

    var display = Display()
    var stack = Stack()

    var enteringFIX = false
    var enteringSCI = false

    init() {
#if os(macOS)
        setupNSEvents() // .macOS only
#endif
        display.delegate = self
        stack.delegate = display
        model = Global.model
        stack.regX = 0 // Force display reload

#if DEBUG
//        let pi = Double.pi
//        let array = [pi, pi * -1.0, pi * 100_000_000_000_000, pi * -100_000_000_000_000, (pi * -1.0) / 100_000_000_000_000]
//        for value in array {
//             display.scientificNotation(value, digits: display.outputFormat.digits)
//        }
#endif
    }

    func processOps(_ ops: [Op]) {
        // Inspect
        if display.info.fKey && ops == [.fShift] {
            print("Process: \([Op.fix].names)")
        } else {
            print("Process: \(ops.names)")
        }

        guard ops.count > 0 else { return }
        var op: Op = ops[0]

        if op != .clrX && displayInfo.error { return }

        // Shift Key - Handle Mac Keyboard Input
        if op == .fShift {
            if !display.info.fKey {
                display.info.fKey = true
            } else {
                op = .fix
            }
            return
        }

        // FIX
        if ops == [.fix, .sci] {
            op = display.info.fKey ? ops[1] : ops[0]
        }
        if op == .fix {
            print("Entering FIX")
            enteringFIX = true
            return
        }
        if op == .sci {
            print("Entering SCI")
            enteringSCI = true
            return
        }
        if enteringFIX {
            processFormatInput(ops, isFix: true)
            enteringFIX = false
            return
        }
        if enteringSCI {
            processFormatInput(ops, isFix: false)
            enteringSCI = false
            return
        }

        if display.info.fKey {
            guard ops.count > 1 else {
                print("Ignore After \(.isHP35 ? "'arc'" : "'shift'"): \(ops[0])")
                return
            }
            if .isHP35 && !ops[1].isArcOp {
                print("Ignore. No trigonometric op: \(ops[1])")
                return
            }
            op = ops[1]
            display.info.fKey = false
            if op == .deg || op == .rad {
                display.info.degrees = op == .deg ? .deg : .rad
                return
            }
        } else {
            op = ops[0]
        }

        switch op {
        case .fShift:
            print("Op: \(.isHP35 ? "arc" : "shift")")
            display.info.fKey = true
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
            guard display.info.output != 0.format(display.outputFormat.digits) else { return }
            display.numericInput = String(display.numericInput.dropLast())
            if display.numericInput.count == 0 {
                display.update(with: 0.format(display.outputFormat.digits), addExponent: false)
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
                    display.info.output = "-0.".padded().noExp
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
            var degrees = displayInfo.degrees
            if .isHP21  {
                degrees = self.radIsOn ? .rad : .deg
            }
            stack.processOp(op, degrees, display.numericInput.isEmpty)
            display.reset()
        }
    }

    // HP-45
    func processFormatInput(_ ops: [Op], isFix: Bool) {
        switch ops[0] {
        case .digit(let value):
            if let value = Int(value) {
                if isFix {
                    print("Format FIX: \(value)")
                    display.outputFormat = .fix(value)
                } else {
                    print("Format SCI: \(value)")
                    display.outputFormat = .sci(value)
                }
                display.info.fKey = false
                stack.regX = stack.regX
            }
        default: print("Ignore: Fix \(ops)")
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
