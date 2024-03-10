//
//  KeyView.swift
//  HP-35
//
//  Created by Enrique Haro on 3/4/24.
//

import SwiftUI

struct KeyView: View {
    @Binding var ops: [Op]
    @State var clicked: Bool = false {
        didSet {
            guard clicked else { return }
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
                clicked = false
            }
        }
    }

    #if os(iOS)
    let haptic = UIImpactFeedbackGenerator(style: .soft)
    #endif

    var key: DataModel.Key
    var width: CGFloat

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack(spacing: 0) {
                if key.type == .lightGrayLarge {
                    Spacer()
                }
                key.fLabel
                    .foregroundColor(.fKey35)
                    .padding(.trailing, key.type == .lightGrayLarge ? 15 : 0)
            }
            ZStack {
                Rectangle()
                    .foregroundColor(.black)
                    .cornerRadius(5)
                ZStack {
                    keyView(keyColor)
                    key.bLabel
                        .foregroundColor(foregroundColor)
                        .padding(.bottom, 9)
                        .padding(.trailing, 1)
                }
                .padding(1)
                .padding(.top, clicked ? 2 : 0)
            }
            .frame(height: width)
            .padding(.bottom, 5)
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

    func keyView(_ color: Color) -> some View {
        ZStack {
            subview(.black)
            subview(color).opacity(0.5)
            subview(color)
                .padding([.leading, .top, .trailing], 2)
                .padding(.bottom, 8)
            subview(.white)
                .padding([.leading, .top, .trailing], 4)
                .padding(.bottom, 11)
            subview(color)
                .padding([.leading, .top], 4)
                .padding(.trailing, 6)
                .padding(.bottom, 13)
        }
    }

    func subview(_ color: Color) -> some View {
        GeometryReader { geometry in
            let w = geometry.size.width
            let h = geometry.size.height
            let r = h * 0.1
            Path { path in
                path.move(to: CGPoint(x: r, y: 0))
                path.addArc(tangent1End: CGPoint(x: w, y: 0),
                            tangent2End: CGPoint(x: w, y: r), radius: r)
                path.addArc(tangent1End: CGPoint(x: w, y: h),
                            tangent2End: CGPoint(x: w - r, y: h), radius: r)
                path.addArc(tangent1End: CGPoint(x: 0, y: h),
                            tangent2End: CGPoint(x: 0, y: h - r), radius: r)
                path.addArc(tangent1End: CGPoint(x: 0, y: 0),
                            tangent2End: CGPoint(x: r, y: 0), radius: r)
            }
            .fill(color)
        }
    }

    var keyWidth: CGFloat {
        switch key.type {
        // HP35
        case .blueLarge, .lightGrayLarge: width * 3
        case .white: width * 1.5
        case.brown: width
        // HP45
        case .orange, .gray, .lightGray: width * 1.2
        case .black: width * (.hp35 ? 1.0 : 1.2)
        default: width
        }
    }

    var keyColor: Color {
        switch key.type {
        // HP35
        case .blue, .blueLarge: .keyCyan35
        case .brown: .keyBrown35

        // HP45
        case .orange: .keyOrange45
        case .gray: .keyGray45
        case .lightGray, .lightGrayLarge: .keyLightGray45
        case .white: .keyWhite45
        case .black: .keyBlack45
        default: .clear
        }
    }

    var foregroundColor: Color {
        switch key.type {
        case .blue, .blueLarge: .white
        case .white, .brown: .black
        // HP45
        case .gray, .black: .white
        case .lightGray, .lightGrayLarge: .black
        default: .white
        }
    }
}

enum KeyType {
    // HP35
    case blue, blueLarge, brown, black, white
    // HP45
    case orange, gray, lightGray, lightGrayLarge

    case none
}
