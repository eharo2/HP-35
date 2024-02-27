//
//  KeyboardViewHP35.swift
//  HP-35
//
//  Created by Enrique Haro on 2/8/24.
//

import SwiftUI

struct KeyboardView35: View {
    @EnvironmentObject var appService: AppService
    @State var ops: [Op] = []

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
            RoundedRectangle(cornerRadius: 3)
                .stroke(Color.fKey35, lineWidth: 2)
                .background(Color.gray35)
                .padding(5)
            VStack(spacing: 0) {
                ForEach(0..<3) { row in
                    keysRow(index: row * 5, numKeys: 5)
                }
                keysRow(index: 15, numKeys: 4)
                ForEach(0..<4) { row in
                    keysRow(index: row * 4 + 19, numKeys: 4)
                }
            }
            .padding(.bottom, 20)
            .background(Color.clear)
            .padding(Global.displayVerticalPadding)
            .padding(.bottom, 5)
        }
        .syncOps($appService.ops, with: $ops)
    }

    func keysRow(index: Int, numKeys: Int) -> some View {
        GeometryReader { geometry in
            let width = geometry.size.width/10 * 1.1
            let keys = Model35.shared.keys
            HStack(spacing: 0) {
                KeyView35(ops: $ops, key: keys[index], width: width)
                ForEach(1..<numKeys, id: \.self) { position in
                    Spacer()
                    KeyView35(ops: $ops, key: keys[index + position], width: width)
                }
            }
            .padding(.horizontal, width * 0.5)
        }
    }
}

struct KeyView35: View {
    @Binding var ops: [Op]
    @State var clicked: Bool = false
    #if os(iOS)
    let haptic = UIImpactFeedbackGenerator(style: .soft)
    #endif

    var key: Model35.Key
    var width: CGFloat

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            key.fLabel
                .foregroundColor(.fKey35)
            ZStack {
                Rectangle()
                    .foregroundColor(.black)
                    .cornerRadius(5)
                ZStack {
                    image()
                    key.bLabel
                        .foregroundColor(foregroundColor)
                        .padding(.bottom, 5)
                        .padding(.trailing, 1)
                }
                .padding(1)
                .padding(.top, clicked ? 2 : 0)
            }
            .frame(width: keyWidth * Global.keySizeFactor, height: width * Global.keySizeFactor)
            .padding(.bottom, 5)
        }
        .onTapGesture {
            #if os(iOS)
            haptic.impactOccurred()
            #endif
            clicked = true
            ops = key.ops == [.decimalPoint] ? [.digit(".")] :
                  key.ops.isEmpty ? [.digit(key.bLabel1)] : key.ops
        }
    }

    func image() -> Image {
        switch key.type {
        case .blue: Images.blueKey
        case .blueLarge: Images.blueLargeKey
        case .black: Images.blackKey
        case .brown: Images.brownKey
        case .white: Images.whiteKey
        default: Images.whiteKey
        }
    }

    var keyWidth: CGFloat {
        switch key.type {
        case .blueLarge: width * 3
        case .white: width * 1.5
        default: width
        }
    }

    var foregroundColor: Color {
        switch key.type {
        case .blue, .blueLarge: .white
        case .white: .black
        default: .clear
        }
    }
}

enum KeyType {
    // HP35
    case blue, blueLarge, brown, black, white
    case none
}
