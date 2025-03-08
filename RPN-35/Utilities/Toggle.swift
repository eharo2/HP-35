//
//  Toggle.swift
//  RPN35
//
//  Created by Enrique Haro on 12/11/24.
//

import SwiftUI
struct HPToggle: View {
    let with: [String]
    @Binding var position: TogglePosition
#if os(iOS)
    let haptic = UIImpactFeedbackGenerator(style: .soft)
#endif

    var body: some View {
        HStack(spacing: 0.0) {
            ZStack {
                Text(with[0])
                    .foregroundColor(.gray(0.1))
                    .shadow(color: .init(white: 0.6), radius: 0.0, x: 1.0, y: 1.0)
            }
            ZStack {
                Rectangle()
                    .foregroundColor(.black)
                    .frame(height: 18.0)
                    .cornerRadius(2.0)
                    .padding(.vertical, 2.0)
                HStack(spacing: 0.0) {
                    if position == .right {
                        Spacer()
                            .frame(width: 15.0)
                    }
                    ZStack {
                        Rectangle()
                            .foregroundColor(.black)
                            .cornerRadius(3.0)
                        HStack(spacing: 0.0) {
                            ForEach(0..<11) { index in
                                let color: Color = index%2 == 0 ? .hp21_black : .gray(0.1)
                                Rectangle()
                                    .foregroundColor(color)
                            }
                        }
                        .cornerRadius(3.0)
                        .padding(0.5)
                    }
                    .frame(width: 30.0, height: 20.0)
                    .shadow(color: .black, radius: 2.0, x: 1.0, y: -1.0)
                    if position == .left {
                        Spacer()
                            .frame(width: 15.0)
                    }
                }
                .onTapGesture {
                    self.position = self.position == .left ? .right : .left
                    haptic.impactOccurred()
                }
            }
            .frame(width: 45.0)
            .padding(.horizontal, 8.0)
            ZStack {
                Text(with[1])
                    .foregroundColor(.gray(0.1))
                    .shadow(color: .init(white: 0.6), radius: 0.0, x: 1.0, y: 1.0)
            }
        }
        .frame(height: 45.0)
        .font(Font.custom("Century Gothic", size: 16))
    }
}

enum TogglePosition {
    case left, center, right
}

// Used for the Standard SwiftUI Toggle in HP21
struct CustomToggleStyle: ToggleStyle {
    var onColor: Color
    var offColor: Color
    var thumbColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label
                .font(.body)
            Spacer()
            RoundedRectangle(cornerRadius: 16.0, style: .circular)
                .fill(configuration.isOn ? onColor : offColor)
                .frame(width: 50.0, height: 30.0)
                .overlay(
                    Circle()
                        .fill(thumbColor)
                        .padding(2.0)
                        .offset(x: configuration.isOn ? 10.0 : -10.0)
                )
                .onTapGesture {
                    withAnimation(.smooth(duration: 0.2)) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}

struct MKToggle: View {
    let labels: [String]
    @Binding var position: TogglePosition
    @State var previousPosition: TogglePosition = .left
#if os(iOS)
    let haptic = UIImpactFeedbackGenerator(style: .soft)
#endif

    var body: some View {
        VStack(spacing: 0.0) {
            Text(centerLabel)
                .foregroundColor(.gray(0.9))
            HStack(spacing: 0.0) {
                ZStack {
                    Text(leftLabel)
                        .foregroundColor(.gray(0.9))
                }
                ZStack {
                    HStack {
                        Rectangle()
                            .onTapGesture {
                                position = .left
                                haptic.impactOccurred()
                            }
                        Rectangle()
                            .onTapGesture {
                                position = .right
                                haptic.impactOccurred()
                            }
                    }
                    .foregroundColor(.gray35)
                    .frame(height: 18.0)
                    .cornerRadius(2.0)
                    .padding(.vertical, 2.0)
                    HStack(spacing: 0.0) {
                        if position == .right {
                            Spacer()
                                .frame(width: 25.0)
                        }
                        if position == .center {
                            Spacer()
                        }
                        ToggleButton()
                            .onTapGesture {
                                if labels.count == 1 {
                                    position = position == .left ? .right : .left
                                } else {
                                    position = .center
                                }
                                haptic.impactOccurred()
                            }
                        if position == .center {
                            Spacer()
                        }
                        if position == .left {
                            Spacer()
                                .frame(width: 25.0)
                        }
                    }
                }
                .frame(width: 60.0)
                .padding(.horizontal, 8.0)
                ZStack {
                    Text(rightLabel)
                        .foregroundColor(.gray(0.9))
                }
            }
        }
        .frame(height: 65.0)
        .font(Font.mk61Font(size: 16.0).bold())
    }

    var leftLabel: String {
        labels.count > 1 ? labels[0] : ""
    }

    var centerLabel: String {
        labels.count == 3 ? labels[1] : ""
    }

    var rightLabel: String {
        labels.count == 3 ? labels[2] : labels[0]
    }
}

struct ToggleButton: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray35)
                .cornerRadius(3.0)
            HStack(spacing: 0.0) {
                ForEach(0..<11) { index in
                    let color: Color = index%2 == 0 ? .hp21_black : .gray(0.1)
                    Rectangle()
                        .foregroundColor(color)
                }
            }
            .cornerRadius(3.0)
            .padding(0.5)
        }
        .frame(width: 30.0, height: 20.0)
        .shadow(color: .black, radius: 2.0, x: 1.0, y: -1.0)
    }
}
