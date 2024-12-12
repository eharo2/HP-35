//
//  SnackBar.swift
//  RPN35
//
//  Created by Enrique Haro on 11/21/24.
//

import SwiftUI

extension View {
    func snackBar<T: View>(isPresenting: Binding<Bool>,
                           offset: CGFloat,
                           @ViewBuilder view: @escaping () -> T) -> some View {
        modifier(SnackBar(isPresenting: isPresenting,
                          offset: offset,
                          view: view))
    }
}

struct SnackBar<T: View>: ViewModifier {
    @Binding var isPresenting: Bool
    var offset: Double
    var view: () -> T
    @State var size = CGSize.zero

    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                Spacer()
                view()
                    // .padding(.horizontal, 10)
//                    .readSize { size in
//                        self.size = size
//                    }
                    .offset(y: isPresenting ? -offset : 300)
                    // .offset(y: isPresenting ? -offset : size.height + 1)
                    // .opacity(isPresenting ? 1.0 : 0.0)
                    .animation(.spring(), value: isPresenting)
            }
        }
    }
}

extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometry in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometry.size)
            }
        )
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static let defaultValue = CGSize.zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) { }
}
