//
//  DisplayView.swift
//  RPN-35
//
//  Created by Enrique Haro on 1/11/24.
//

import SwiftUI

struct DisplayView: View {
    @EnvironmentObject var appService: AppService

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ZStack {
                    displayBackground()
                    LedsView(displayInfo: self.appService.displayInfo,
                             fontSize: geometry.size.width/13)
                }
            }
        }
    }
}

// MARK: - HP35
extension DisplayView {
    func displayBackground() -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
            Rectangle()
                .foregroundColor(.black)
                .padding(.horizontal, 5)
            Rectangle()
                .foregroundColor(.red).opacity(0.6)
                .opacity(0.7)
                .cornerRadius(5)
                .padding(10)
            Rectangle()
                .foregroundColor(.displayRed)
                .cornerRadius(5)
                .padding(10.5)
                .padding(.leading, 5)
        }
        .padding(.vertical, 0)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LedsView: View {
    @ObservedObject var timer: LedTimer
    let fontSize: CGFloat

    init(displayInfo: DisplayInfo, fontSize: CGFloat) {
        self.timer = LedTimer(displayInfo)
        self.fontSize = fontSize
    }
    var body: some View {
        VStack(spacing: 0) {
            Text(timer.text)
                .lineLimit(1)
            .kerning(5)
            .font(Font.custom("HP15C-Simulator-Font", size: fontSize))
            .foregroundColor(.red)
            .padding(.bottom, 5)
            .padding(.leading, 5)
        }
        .padding(.horizontal, 20)
    }

    class LedTimer: ObservableObject {
        @Published var text: String = ""

        init(_ displayInfo: DisplayInfo) {
            if displayInfo.error {
                Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { _ in
                    self.text = self.text.isEmpty ? displayInfo.output : ""
                }
            } else {
                self.text = displayInfo.output
            }
        }
    }
}

extension View {
    func isVisible(_ visible: Bool) -> some View {
        modifier(Visible(visible: visible))
    }
}

struct Visible: ViewModifier {
    var visible: Bool

    func body(content: Content) -> some View {
        content
            .foregroundColor(visible ? .black : .clear)
    }
}
