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
                    if appService.hp21OnOffPosition == .right {
                        LedsView(displayInfo: appService.displayInfo,
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
    @ObservedObject var errorTimer: ErrorTimer
    let displayInfo: DisplayInfo
    let fontSize: CGFloat

    init(displayInfo: DisplayInfo, fontSize: CGFloat) {
        self.errorTimer = ErrorTimer()
        self.displayInfo = displayInfo
        self.fontSize = fontSize
    }

    var body: some View {
        VStack(spacing: 0) {
            Text(displayInfo.output)
                .lineLimit(1)
            .kerning(5)
            .font(Font.custom("HP15C-Simulator-Font", size: fontSize))
            .foregroundColor(ledColor)
            .padding(.bottom, 5)
            .padding(.leading, 5)
        }
        .padding(.horizontal, 20)
    }

    var ledColor: Color {
        displayInfo.showError && errorTimer.errorTick ? .black : .red
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
