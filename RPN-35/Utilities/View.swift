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

extension View {
    func touchHandler(_ touchState: Binding<TouchState>,
                      _ touchPoint: Binding<CGPoint>) -> some View {
        self.gesture(
            DragGesture(minimumDistance: 0.0)
                .onChanged { touch in
                    touchPoint.wrappedValue = touch.location
                    if touchState.wrappedValue == .moved {
                        print("moved")
                    }
                    if touchState.wrappedValue == .ended {
                        print("began")
                        touchState.wrappedValue = .began
                    }
                }
                .onEnded { touch in
                    print("ended")
                    touchPoint.wrappedValue = touch.location
                    touchState.wrappedValue = .ended
                }
        )
    }

    func onTouchBegan(touchState: Binding<TouchState>,
                      action: @escaping () -> Void) -> some View {
        self.gesture(
            DragGesture(minimumDistance: 0.0)
                .onChanged { _ in
                    if touchState.wrappedValue == .ended {
                        touchState.wrappedValue = .began
                        action()
                    }
                })
    }

    func onTouchMoved(touchState: Binding<TouchState>,
                      action: @escaping () -> Void) -> some View {
        self.gesture(
            DragGesture(minimumDistance: 0.0)
                .onChanged { _ in
                    if touchState.wrappedValue != .moved {
                        touchState.wrappedValue = .moved
                        action()
                    }
                })
    }

    func onTouchEnded(touchState: Binding<TouchState>,
                      action: @escaping () -> Void) -> some View {
        self.gesture(
            DragGesture(minimumDistance: 0.0)
                .onEnded { _ in
                    touchState.wrappedValue = .ended
                    action()
                })
    }
}

enum TouchState {
    case began, moved, ended
}
