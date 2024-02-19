//
//  DebugSwitUI.swift
//  NbvDirector
//
//  Created by Enrique Haro on 1/13/21.
//

import SwiftUI

typealias DebugView = EmptyView

extension DebugView {
    /// These functions are for debugging purposes only
    /// They allow to print to the console or run a closure inside a View block (e.g. a VStack)
    /// Usage:  DebugView.printToConsole("Hello World")
    static func printToConsole<T>(_ value: T) -> EmptyView {
        print("\(value)")
        return EmptyView()
    }

    /// Usage: DebugView.runClosure { print("Hello World") }
    static func runClosure(_ closure: () -> Void) -> EmptyView {
        closure()
        return EmptyView()
    }
}
