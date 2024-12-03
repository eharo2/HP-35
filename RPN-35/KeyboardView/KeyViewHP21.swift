//
//  KeyViewHP21.swift
//  RPN35
//
//  Created by Enrique Haro on 11/24/24.
//

import SwiftUI

extension KeyView {
    func hp21_KeyView() -> some View {
        VStack(spacing: 0.0) {
            Spacer()
            ZStack {
                Rectangle()
                    .foregroundColor(.black)
                    .cornerRadius(5)
                ZStack {
                    keyView_21(keyColor)
                    VStack(spacing: 0.0) {
                        key.bLabel
                            .foregroundColor(foregroundColor)
                        key.fLabel
                            .foregroundColor(.hp21_blue)
                            .padding(.top, 5.0)
                            .padding(.bottom, key.type == .white ? 2.0 : 0.0)
                    }
                }
                .padding(1.0)
                .padding(.top, clicked ? 2.0 : 0.0)
            }
            .frame(height: width * 1.2)
            .padding(.bottom, 5.0)
        }
        .frame(width: keyWidth)
        .onTapGesture {
#if os(iOS)
            haptic.impactOccurred()
#endif
            clicked = true
            DispatchQueue.global().async {
                ops = key.ops.isEmpty ? [.digit(key.bLabel1)] : key.ops
            }
        }
    }

    func keyView_21(_ color: Color) -> some View {
        ZStack {
            subview(.black)
            subview(color).opacity(0.5)
            subview(color)
                .padding([.leading, .top, .trailing], 2.0)
                .padding(.bottom, 4.0)
            subview(shineColor)
                .padding([.leading, .top, .trailing], 4.0)
                .padding(.bottom, 21.0)
            subview(color)
                .padding([.leading, .top], 4.0)
                .padding(.trailing, 6.0)
                .padding(.bottom, 23.0)
        }
    }

    var shineColor: Color {
        switch key.type {
        case .black, .blackLarge: .gray(0.6)
        default: .white
        }
    }
}

extension KeyboardView {
    func topToggleView() -> some View {
        ZStack {
            Rectangle()
                .frame(height: 45.0)
                .foregroundColor(.black)
                .cornerRadius(8.0)
                .padding(10.0)
                .padding(.trailing, 5.0)
                .padding(.bottom, -9.0)
            Rectangle()
                .frame(height: 45.0)
                .foregroundColor(.white)
                .cornerRadius(8.0)
                .padding(10.0)
                .padding(.leading, 0.5)
                .padding(.trailing, -0.5)
                .padding(.bottom, -11.0)
            HStack {
                toggle(with: ["OFF", "ON"], value: $hp21IsOn)
                    .padding(.leading, 20.0)
                Spacer()
                toggle(with: ["DEG", "RAD"], value: $radIsOn)
                    .padding(.trailing, 20.0)
            }
            .background(Color.hp21_black)
            .cornerRadius(8.0)
            .padding(10.0)
            .padding(.leading, 0.5)
            .padding(.bottom, -10.0)
        }
    }

    func toggle(with: [String], value: Binding<Bool>) -> some View {
        HStack(spacing: 0.0) {
            ZStack {
                Text(with[0])
                    .foregroundColor(.gray(0.9))
                    .padding(.trailing, -1.5)
                    .padding(.bottom, -1.0)
                Text(with[0])
                    .foregroundColor(.gray(0.1))
            }
            .padding(.trailing, -10.0)
            Toggle("", isOn: value)
                .scaleEffect(0.8)
                .frame(width: 60.0)
                .toggleStyle(CustomToggleStyle(onColor: .black, offColor: .black, thumbColor: .hp21_black))
            ZStack {
                Text(with[1])
                    .foregroundColor(.gray(0.9))
                    .padding(.trailing, -1.5)
                    .padding(.bottom, -1)
                Text(with[1])
                    .foregroundColor(.gray(0.1))
            }
            .padding(.trailing, 10.0)
            .frame(height: 45.0)
            .font(Font.custom("Century Gothic", size: 16))
        }
    }
}

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
