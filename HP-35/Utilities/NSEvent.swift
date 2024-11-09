//
//  NSEvent.swift
//  RPN-35
//
//  Created by Enrique Haro on 3/23/24.
//

import SwiftUI

#if os(macOS)
extension AppService {
    func setupNSEvents() {
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event -> NSEvent? in
            guard !event.isARepeat else { return nil }
            let input = event.input
            // Safety reset mechanism in Mac Keyboard. Does not work in UnitTests
            if input == "\u{1B}" { // ESC
                print("NSEvent: ESC")
                self?.fShiftKey = false
                self?.display.reset()
                self?.stack.clear()
                self?.stack.inspect()
                return nil
            }
            let ops = event.input.ops35
            guard !ops.isEmpty else {
                print("Ignore: \(input)")
                return nil
            }
            self?.processOps(ops)
            return nil
        }
    }
}

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
