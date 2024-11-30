//
//  View.swift
//  RPN-35
//
//  Created by Enrique Haro on 2/2/24.
//

import SwiftUI

extension View {
    func syncOps(_ published: Binding<[Op]>, with binding: Binding<[Op]>) -> some View {
        self
            .onChange(of: published.wrappedValue) { _, published in
                binding.wrappedValue = published
            }
            .onChange(of: binding.wrappedValue) { _, binding in
                published.wrappedValue = binding
            }
    }
}

extension View {
    func baseFont(_ size: CGFloat) -> some View {
        self.font(.system(size: size, weight: .bold))
    }

    func fFont(_ size: CGFloat) -> some View {
        self.font(.system(size: size, weight: .semibold))
    }

    func gFont(_ size: CGFloat) -> some View {
        self.font(.system(size: size, weight: .medium).italic())
    }
}

extension View {
    @ViewBuilder func `if` <Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
}
