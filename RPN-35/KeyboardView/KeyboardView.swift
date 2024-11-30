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

    // HP-21
    @State var showModelSelectionView = false
    @State var radIsOn = false

    var body: some View {
        VStack {
            if .hp21 {
                hp21_DegRadToggleView()
            }
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.fKey35, lineWidth: .hp21 ? 0.5 : 2)
                    .background(keyboardBackgroundColor)
                    .padding(.horizontal, 5)
                    .padding(.bottom, .mac ? 2 : -1)
                VStack(spacing: 0) {
                    if .hp21 {
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
                .padding(.bottom, 15)
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

    func logoLabelView() -> some View {
        HStack {
            logoImage
                .aspectRatio(contentMode: .fit)
                .frame(height: 20)
            Text(" RPN \(Sym.dot) CALCULATOR  \(modelText)")
                .font(Font.custom("Century Gothic", size: .mac ? 14 : 16))
                .kerning(5)
                .minimumScaleFactor(0.8)
                .lineLimit(1)
                .foregroundColor(.white)
        }
        .padding(.top, 5)
        .padding(.bottom, .mac ? 10 : 20)
        .padding(.horizontal, .mac ? 10 : 20)
        .onTapGesture {
            showModelSelectionView.toggle()
//            Global.model = .hp35 ? .hp45 : .hp35
//            appService.display.info.error = false
//            appService.stack.clear()
//            appService.stack.inspect()
        }
    }

    var modelText: String {
        switch Global.model {
        case .hp21 : "21"
        case .hp35 : "35"
        case .hp45 : "45"
        }
    }

    func modelSelectionView() -> some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.keyGray45, lineWidth: 2)
                    .background(Color.white)
                VStack {
                    Text("SELECT MODEL")
                        .font(Font.custom("Century Gothic", size: 18))
                        .kerning(5)
                        .minimumScaleFactor(0.8)
                    Spacer()
                    Button(action: {
                        Global.model = .hp35
                        resetView()
                        showModelSelectionView = false
                    }, label: {
                        Text("HP-35")
                            .font(Font.custom("Century Gothic", size: 18))
                            .kerning(5)
                            .minimumScaleFactor(0.8)
                    })
                    Spacer()
                    Button(action: {
                        Global.model = .hp45
                        resetView()
                        showModelSelectionView = false
                    }, label: {
                        Text("HP-45")
                            .font(Font.custom("Century Gothic", size: 18))
                            .kerning(5)
                            .minimumScaleFactor(0.8)
                    })
                    Spacer()
                    Button(action: {
                        Global.model = .hp21
                        resetView()
                        showModelSelectionView = false
                    }, label: {
                        Text("HP-21")
                            .font(Font.custom("Century Gothic", size: 18))
                            .kerning(5)
                            .minimumScaleFactor(0.8)
                    })
                }
                .padding(.vertical, 30)
            }
        }
        .frame(height: 200)
        .cornerRadius(6)
        .padding(.horizontal, 6)
        .padding(.bottom, 29)
        .onTapGesture {
            showModelSelectionView.toggle()
        }
    }

    func resetView() {
        appService.display.info.error = false
        appService.stack.clear()
        appService.stack.inspect()
    }

    var logoImage: Image {
        .hp45 ? Images.hpLogoGray : Images.hpLogoBlue
    }
}
