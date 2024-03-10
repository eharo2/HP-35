//
//  KeyboardViewHP.swift
//  HP-35
//
//  Created by Enrique Haro on 2/8/24.
//

import SwiftUI

struct KeyboardView: View {
    @EnvironmentObject var appService: AppService
    @State var ops: [Op] = []

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 3)
                    .stroke(Color.fKey35, lineWidth: 2)
                    .background(Color.gray35)
                    .padding(.horizontal, 5)
                    .padding(.bottom, .mac ? 2 : -1)
                VStack(spacing: 0) {
                    ForEach(0..<3) { row in
                        keysRow(index: row * 5, numKeys: 5)
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
        .background(Color.gray35)
        .syncOps($appService.ops, with: $ops)
    }

    func keysRow(index: Int, numKeys: Int) -> some View {
        GeometryReader { geometry in
            let width = geometry.size.width/10 * 1.1
            let keys = DataModel.shared.keys(for: Global.model)
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

    func logoLabelView() -> some View {
        HStack {
            logoImage
                .aspectRatio(contentMode: .fit)
                .frame(height: 20)
            Text(" RPN \(Sym.dot) CALCULATOR  \(.hp35 ? "35" : "45")")
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
            Global.model = .hp35 ? .hp45 : .hp35
            appService.stack.clear()
            appService.stack.inspect()
        }
    }

    var logoImage: Image {
        .hp35 ? Images.hpLogoBlue : Images.hpLogoGray
    }
}
