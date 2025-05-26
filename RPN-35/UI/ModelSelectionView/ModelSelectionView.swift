//
//  ModelSelectionView.swift
//  RPN35
//
//  Created by Enrique Haro on 11/30/24.
//

import SwiftUI

struct ModelSelectionView: View {
    @EnvironmentObject var appService: AppService
    @EnvironmentObject var rpnEngine: RPNEngine

    var body: some View {
        modelSelectionView()
    }

    private func modelSelectionView() -> some View {
        ZStack {
            Color.gray35
                Color.keyWhite45
                .cornerRadius(8.0)
                .padding(.top, 3.0)
                .padding(.horizontal, 3.0)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 0.0) {
                Text("SELECT MODEL")
                    .font(.century(size: 22.0))
                    .foregroundColor(.black)
                    .kerning(5.0)
                    .minimumScaleFactor(0.8)
                    .padding(.top, 20.0)
                    .padding(.bottom, 15.0)
                modelSelectionButton(title: "HP-35",
                                     font: .century(size: 20.0),
                                     action: { Global.model = .hp35 })
                .background(Color.keyLightGray45.opacity(0.15))
                modelSelectionButton(title: "HP-45",
                                     font: .century(size: 20.0),
                                     action: { Global.model = .hp45 })
                modelSelectionButton(title: "HP-21",
                                     font: .century(size: 20.0),
                                     action: { Global.model = .hp21 })
                .background(Color.keyLightGray45.opacity(0.15))
                modelSelectionButton(title: Cyrilic.mk61Label,
                                     font: .mk61Font(size: 18.0),
                                     action: { Global.model = .mk61 })
                Spacer()
            }
            .padding(.horizontal, 3.0)
            .onTapGesture {
                appService.showModelSelectionView.toggle()
            }
        }
    }

    private func modelSelectionButton(title: String, font: Font, action: @escaping ()->Void) -> some View {
        Button(action: {
            action()
            appService.showModelSelectionView = false
            rpnEngine.resetView()
        }, label: {
            Text(title)
                .font(font)
                .kerning(5.0)
                .minimumScaleFactor(0.8)
                .padding(.vertical, 8.0)
                .frame(maxWidth: .infinity)
        })
    }
}
