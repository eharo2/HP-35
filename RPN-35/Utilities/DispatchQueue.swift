//
//  DispatchQueue.swift
//  RPN35
//
//  Created by Enrique Haro on 7/30/25.
//

import Foundation

extension DispatchQueue {
    func asyncAfter(seconds: Double, execute: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: execute)
    }
}

extension Task where Success == Never, Failure == Never {
    static func asyncAfter(seconds: Double) async {
        let nanoseconds = UInt64(seconds * 1_000_000_000)
        try? await Task.sleep(nanoseconds: nanoseconds)
    }
}
