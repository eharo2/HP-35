//
//  Array.swift
//  RPN35
//
//  Created by Enrique Haro on 12/22/24.
//
import Foundation

extension Array where Element: FloatingPoint {
    func sum() -> Element {
        self.reduce(0, +)
    }

    func avg() -> Element {
        guard count > 0 else {
            return Element(0)
        }
        return sum() / Element(count)
    }

    func std() -> Element {
        let mean = avg()
        let v = reduce(0, { $0 + ($1 - mean) * ($1 - mean) })
        return sqrt(v / (Element(count) - 1))
    }
}
