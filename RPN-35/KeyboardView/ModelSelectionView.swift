//
//  ModelSelectionView.swift
//  RPN35
//
//  Created by Enrique Haro on 11/30/24.
//

import SwiftUI

extension KeyboardView {
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
        }
    }

    func modelSelectionView() -> some View {
        VStack {
            Spacer()
            ZStack {
                Rectangle()
                    .foregroundColor(.keyWhite45)
                    .cornerRadius(6.0)
                VStack {
                    Text("SELECT MODEL")
                        .font(Font.custom("Century Gothic", size: 18))
                        .foregroundColor(.black)
                        .kerning(5.0)
                        .minimumScaleFactor(0.8)
                    Spacer()
                    Button(action: {
                        Global.model = .hp35
                        resetView()
                        showModelSelectionView = false
                    }, label: {
                        Text("HP-35")
                            .font(Font.custom("Century Gothic", size: 18.0))
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
                            .font(Font.custom("Century Gothic", size: 18.0))
                            .kerning(5.0)
                            .minimumScaleFactor(0.8)
                    })
                    Spacer()
                    Button(action: {
                        Global.model = .hp21
                        resetView()
                        showModelSelectionView = false
                    }, label: {
                        Text("HP-21")
                            .font(Font.custom("Century Gothic", size: 18.0))
                            .kerning(5.0)
                            .minimumScaleFactor(0.8)
                    })
                }
                .padding(.vertical, 18)
            }
        }
        .frame(height: 155.0)
        .cornerRadius(6.0)
        .padding(.horizontal, 13)
        .padding(.bottom, 35.0)
        .onTapGesture {
            showModelSelectionView.toggle()
        }
    }

    var modelText: String {
        switch Global.model {
        case .hp21 : "21"
        case .hp35 : "35"
        case .hp45 : "45"
        }
    }
}
