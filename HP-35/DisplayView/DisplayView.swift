//
//  DisplayView.swift
//  HP-35
//
//  Created by Enrique Haro on 1/11/24.
//

import SwiftUI

struct DisplayView: View {
    @EnvironmentObject var appService: AppService
    @State var displayInfo = DisplayInfo()

    var body: some View {
        lcdView()
            .onChange(of: appService.displayInfo) { _, displayInfo in
                DispatchQueue.main.async {
                    self.displayInfo = displayInfo
                }
            }
    }

    func lcdView() -> some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ZStack {
                    display35()
                        .padding(.vertical, Global.displayVerticalPadding)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    VStack(spacing: 0) {
                        Text(displayInfo.output)
                            .lineLimit(1)
                        .kerning(5)
                        .font(Font.custom("HP15C-Simulator-Font", size: geometry.size.width/13))
                        .foregroundColor(.red)
                        .padding(.bottom, 5)
                        .padding(.leading, 5)
                    }
                    .padding(.horizontal, 20)
                    #if os(macOS)
                    .padding(.top, 6)
                    #endif
                }
            }
        }
    }
}

// MARK: - HP35
extension DisplayView {
    func display35() -> some View {
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
    }
}

struct DisplayInfo: Equatable {
    var output = ""
    var fKey = false {
        didSet {
            if fKey {
                gKey = false
            }
        }
    }
    var gKey = false {
        didSet {
            if gKey {
                fKey = false
            }
        }
    }
    var degrees: Degrees = .deg
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
