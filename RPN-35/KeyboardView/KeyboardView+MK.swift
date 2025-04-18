//
//  KeyboardView+MK.swift
//  RPN35
//
//  Created by Enrique Haro on 3/1/25.
//

import SwiftUI

extension KeyboardView {
    func mkKeyboardView() -> some View {
        VStack(spacing: 0.0) {
            Image("mk61_green_backplane").resizable()
                .frame(maxWidth: .infinity, maxHeight: 140.0)
            mkLogoLabelView()
            mkTopToggleView()
            VStack(spacing: 0.0) {
                ForEach(0..<6) { row in
                    mkKeysRow(index: row * 5, numKeys: 5)
                        .if(row == 5) {
                            $0
                        }
                }
            }
        }
        .padding(.bottom, 35.0)
        .background(keyboardBackgroundColor)
    }

    func mkLogoLabelView() -> some View {
        HStack {
            Text(Cyrilic.mk61Label)
                .font(.mk61Font(size: 16.0).bold())
                .kerning(5.0)
                .minimumScaleFactor(0.8)
                .lineLimit(1)
                .foregroundColor(.white)
        }
        .padding(.top, 10.0)
        .padding(.bottom, 0.0)
        .frame(maxWidth: .infinity)
        .onTapGesture {
            appService.showModelSelectionView = true
        }
    }

    func mkTopToggleView() -> some View {
        HStack {
            MKToggle(labels: [Cyrilic.on], position: $appService.onOffPosition)
                .padding(.leading, 20.0)
            Spacer()
            MKToggle(labels: [Cyrilic.rad, Cyrilic.grd, Cyrilic.deg], position: $appService.radDegPosition)
                .padding(.trailing, 20.0)
        }
        .padding(.horizontal, 10.0)
        .padding(.bottom, 5.0)
    }

    func mkKeysRow(index: Int, numKeys: Int) -> some View {
        GeometryReader { geometry in
            let width = geometry.size.width/10 * 1.1
            let keys = DataModel.shared.keys(for: Global.model)
            HStack(spacing: 0.0) {
                KeyView(ops: $ops, key: keys[index], width: width)
                ForEach(1..<numKeys, id: \.self) { position in
                    Spacer()
                    KeyView(ops: $ops, key: keys[index + position], width: width)
                }
            }
            .padding(.horizontal, width * 0.2)
        }
    }
}
