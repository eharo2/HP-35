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
                Rectangle() // HP21 backgroundBlack
                    .foregroundColor(.hp21_black)
                Rectangle() // HP21 key hole
                    .foregroundColor(.black)
                    .cornerRadius(2.0)
                    .padding(.leading, 3.0)
                VStack {
                    Spacer()
                        .frame(height: animateKey ? 1.0 : 0.0)
                    ZStack {
                        VStack {
                            GeometryReader { geometry in
                                let rect = CGRect(origin: .zero, size: geometry.size)
                                ZStack {
                                    VStack(spacing: 0.0) {
                                        let size = CGSize(width: rect.width, height: 5.0)
                                        keyTopView(in: CGRect(origin: .zero,
                                                              size: size), color: viewTopColor)
                                        .frame(height: 5.0)
                                        ZStack {
                                            ZStack {
                                                Rectangle()
                                                    .foregroundColor(.white)
                                                    .cornerRadius(3.0)
                                                Rectangle()
                                                    .foregroundColor(viewMidColor)
                                                    .cornerRadius(3.0)
                                                    .padding(.trailing, 0.5)
                                                    .padding(.bottom, 1.5)
                                            }
//                                            VStack(spacing: 0.0) {
//                                                Spacer()
//                                                Rectangle()
//                                                    .foregroundColor(keyDividerColor)
//                                                    .cornerRadius(3.0)
//                                                    .frame(height: 2.0)
//                                                    .padding(.trailing, 2.0)
//                                            }
                                        }
                                        .padding(.trailing, 4.0)
                                        keyBottomView(in: rect, color: viewBottomColor)
                                            .frame(height: (geometry.size.height - 5.0) * 0.4)
                                    }
                                }
                            }
                        }
                        .padding(.top, 1)
                        VStack(spacing: 0.0) {
                            key.bLabel
                                .foregroundColor(textTopColor)
                                .padding(.top, 4.0)
                                .padding(.trailing, 2.0)
                                .if(key.type == .blue) {
                                    $0.frame(width: 45.0)
                                }
                            key.fLabel
                                .foregroundColor(textBottomColor)
                                .padding(.top, 8.0)
                        }
                    }
                }
            }
            .frame(height: width * 1.3)
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
            animateKey = true
            print("ANIMATE \(animateKey)")
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
                self.animateKey = false
                print("ANIMATE \(animateKey)")
            }
        }
    }

    func keyTopView(in rect: CGRect, color: Color) -> some View {
        return Path() { path in
            path.move(to: CGPoint(x: 0.0, y: rect.maxY))
            path.addArc(tangent1End: CGPoint(x: 3.0, y: 0.0), tangent2End: CGPoint(x: rect.midX, y: 0.0), radius: 3.0)
            path.addLine(to: CGPoint(x: rect.maxX, y: 0.0))
            path.addLine(to: CGPoint(x: rect.maxX - 4.0, y: rect.maxY))
            path.closeSubpath()
        }
        .fill(color)
    }

    func keyBottomView(in rect: CGRect, color: Color) -> some View {
        let height = rect.maxY * 0.35
        return Path() { path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: rect.maxX - 4.0, y: 0.0))
            path.addArc(tangent1End: CGPoint(x: rect.maxX, y: height), tangent2End: CGPoint(x: 3.0, y: height), radius: 2.0)
            path.addArc(tangent1End: CGPoint(x: 3.0, y: height), tangent2End: .zero, radius: 2.0)
            path.closeSubpath()
        }
        .fill(color)
    }

    var viewTopColor: Color {
        switch key.type {
        case .blue: .hp21_blue
        case .white: .gray(0.9)
        default: .hp21_black
        }
    }

    var viewMidColor: Color {
        switch key.type {
        case .blue: .hp21_blue
        case .white: .gray(0.8)
        default: .hp21_black
        }
    }

    var viewBottomColor: Color {
        switch key.type {
        case .blue: .hp21_blue
        case .white: .gray(0.7) // .hp21_keyWhite1
        default: .gray(0.3)
        }
    }

    var keyDividerColor: Color {
        switch key.type {
        case .blue: .white
        case .white: .white
        default: .gray(0.9)
        }
    }

    var textTopColor: Color {
        switch key.type {
        case .blue: .hp21_blue
        case .white: .black
        default: .white
        }
    }

    var textBottomColor: Color {
        switch key.type {
        case .blue: .red
        case .white: .hp21_blue
        default: .hp21_blue
        }
    }
}

extension KeyboardView {
    func hp21_DegRadToggleView() -> some View {
        ZStack {
            Rectangle()
                .frame(height: 45)
                .foregroundColor(.black)
                .cornerRadius(8)
                .padding(10)
                .padding(.trailing, 5)
                .padding(.bottom, -9)
            Rectangle()
                .frame(height: 45)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(10)
                .padding(.leading, 0.5)
                .padding(.trailing, -0.5)
                .padding(.bottom, -11)
            HStack {
                Spacer()
                ZStack {
                    Text("DEG")
                        .font(Font.custom("Century Gothic", size: 16))
                        .foregroundColor(.gray(0.9))
                        .padding(.trailing, -1.5)
                        .padding(.bottom, -1)
                    Text("DEG")
                        .font(Font.custom("Century Gothic", size: 16))
                }
                .padding(.trailing, -10)
                Toggle("", isOn: $radIsOn)
                    .scaleEffect(0.8)
                    .frame(width: 60)
                    .toggleStyle(CustomToggleStyle(onColor: .black, offColor: .black, thumbColor: .hp21_black))
                ZStack {
                    Text("RAD")
                        .font(Font.custom("Century Gothic", size: 16))
                        .foregroundColor(.gray(0.9))
                        .padding(.trailing, -1.5)
                        .padding(.bottom, -1)
                    Text("RAD")
                        .font(Font.custom("Century Gothic", size: 16))
                }
                .padding(.trailing, 10)
                .frame(height: 45)
            }
            .background(Color.hp21_black)
            .cornerRadius(8)
            .padding(10)
            .padding(.leading, 0.5)
            .padding(.bottom, -10)
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
            RoundedRectangle(cornerRadius: 16, style: .circular)
                .fill(configuration.isOn ? onColor : offColor)
                .frame(width: 50, height: 30)
                .overlay(
                    Circle()
                        .fill(thumbColor)
                        .padding(2)
                        .offset(x: configuration.isOn ? 10 : -10)
                )
                .onTapGesture {
                    withAnimation(.smooth(duration: 0.2)) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}
