//
//  Toggle.swift
//  RPN35
//
//  Created by Enrique Haro on 12/11/24.
//

import SwiftUI
struct HPToggle: View {
    let with: [String] // String array with Toggle Labels
    @Binding var position: TogglePosition

    var body: some View {
        HStack(spacing: 0.0) {
            ZStack {
                Text(with[0])
                    .foregroundColor(.gray(0.9))
                    .padding(.trailing, -1.5)
                    .padding(.bottom, -1.0)
                Text(with[0])
                    .foregroundColor(.gray(0.1))
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
                    if position == .left {
                        Spacer()
                            .frame(width: 15.0)
                    }
                }
                .onTapGesture {
                    self.position = self.position == .left ? .right : .left
                }
            }
            .frame(width: 45.0)
            .padding(.horizontal, 8.0)
            ZStack {
                Text(with[1])
                    .foregroundColor(.gray(0.9))
                    .padding(.trailing, -1.5)
                    .padding(.bottom, -1)
                Text(with[1])
                    .foregroundColor(.gray(0.1))
            }
        }
        .frame(height: 45.0)
        .font(Font.custom("Century Gothic", size: 16))
    }
}

enum TogglePosition {
    case left, right
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
