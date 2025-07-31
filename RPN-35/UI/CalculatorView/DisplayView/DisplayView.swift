//
//  DisplayView.swift
//  RPN-35
//
//  Created by Enrique Haro on 1/11/24.
//

import SwiftUI

struct DisplayView: View {
    @EnvironmentObject var rpnEngine: RPNEngine

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0.0) {
                ZStack {
                    displayBackground()
                    if rpnEngine.onOffPosition == .right {
                        LedsView(displayInfo: rpnEngine.displayInfo,
                                 fontSize: geometry.size.width/13)
                   }
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
                .foregroundColor(backgroundColor)
                .opacity(0.7)
                .cornerRadius(5.0)
                .padding(.vertical, 10.0)
                .padding(.horizontal, 5.0)
            Rectangle()
                .foregroundColor(displayColor)
                .cornerRadius(5.0)
                .padding(10.5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    var displayColor: Color {
        if .isMK61 {
            return .mk61_displayGreen
        }
        return .displayRed
    }

    var backgroundColor: Color {
        if .isMK61 {
            return .mk61_ledGreenBack
        }
        return .red.opacity(0.6)
    }
}

struct LedsView: View {
    @ObservedObject var errorTimer: ErrorTimer
    let displayInfo: DisplayInfo
    let fontSize: CGFloat

    init(displayInfo: DisplayInfo, fontSize: CGFloat) {
        self.errorTimer = ErrorTimer()
        self.displayInfo = displayInfo
        self.fontSize = fontSize
    }

    var body: some View {
        VStack(spacing: 0.0) {
            Text(displayInfo.output)
                .lineLimit(1)
                .kerning(5.0)
                .font(.hp15cFont(size: fontSize))
                .foregroundColor(ledColor)
                .padding(.bottom, 5.0)
                .padding(.leading, 5.0)
        }
        .padding(.horizontal, 20.0)
    }

    var ledColor: Color {
        if displayInfo.enterBlink {
            return .black
        }
        if .isMK61 {
            return .mk61_ledGreen
        }
        return displayInfo.showError && errorTimer.errorTick ? .black : .red
    }

    class ErrorTimer: ObservableObject {
        @Published var errorTick = false
        var timer: Timer!

        init() {
            DispatchQueue.main.async {
                self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                    self.errorTick.toggle()
                }
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
