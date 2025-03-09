//
//  KeyboardViewHP.swift
//  RPN-35
//
//  Created by Enrique Haro on 2/8/24.
//

import SwiftUI

struct KeyboardView: View {
    @EnvironmentObject var appService: AppService
    @State var ops: [Op] = []

    @State var showModelSelectionView = false

    var body: some View {
        if .isMK61 {
            mkKeyboardView()
        } else {
            hpKeyboardView()
        }
    }

    func hpKeyboardView() -> some View {
        VStack {
            if .isHP21 {
                topToggleView()
            }
            ZStack {
                RoundedRectangle(cornerRadius: 4.0)
                    .stroke(Color.fKey35, lineWidth: .isHP21 ? 0.5 : 2.0)
                    .background(keyboardBackgroundColor)
                    .padding(.horizontal, 5.0)
                    .padding(.bottom, .mac ? 2.0 : -1.0)
                VStack(spacing: 0.0) {
                    if .isHP21 {
                        ForEach(1..<3) { row in
                            keysRow(index: row * 5, numKeys: 5)
                        }
                    } else {
                        ForEach(0..<3) { row in
                            keysRow(index: row * 5, numKeys: 5)
                        }
                    }
                    keysRow(index: 15, numKeys: 4)
                    ForEach(0..<4) { row in
                        keysRow(index: row * 4 + 19, numKeys: 4)
                    }
                }
                .padding(.bottom, 15.0)
            }
            logoLabelView()
        }
        .background(keyboardBackgroundColor)
        .snackBar(isPresenting: $showModelSelectionView, offset: 25,
                  view: modelSelectionView)
        .syncOps($appService.ops, with: $ops)
    }

    var keyboardBackgroundColor: Color {
        switch Global.model {
        case .hp21: .hp21_black
        case .mk61: .hp21_black
        default: .gray35
        }
    }

    func keysRow(index: Int, numKeys: Int) -> some View {
        GeometryReader { geometry in
            let width = geometry.size.width/10 * 1.1
            let keys = DataModel.shared.keys(for: Global.model)
            HStack(spacing: 0) {
                KeyView(ops: $ops, key: keys[index], width: width)
                ForEach(1..<numKeys, id: \.self) { position in
                    Spacer()
                    KeyView(ops: $ops, key: keys[index + position], width: width)
                }
            }
            .padding(.horizontal, width * 0.5)
        }
    }

    func resetView() {
        appService.display.info.showError = false
        appService.hp21OnOffPosition = .right
        appService.stack.clear()
        appService.stack.inspect()
    }

    var logoImage: Image {
        .isHP45 ? Images.hpLogoGray : Images.hpLogoBlue
    }
}
