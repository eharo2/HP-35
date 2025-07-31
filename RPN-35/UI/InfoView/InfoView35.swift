//
//  InfoView35.swift
//  RPN-35
//
//  Created by Enrique Haro on 2/18/24.
//

import SwiftUI

struct InfoView35: View {
    var body: some View {
        HStack(spacing: 0) {
            columnView(left: true)
            Rectangle().frame(width: 0.5)
                .foregroundColor(.white)
                .padding(5)
            columnView(left: false)
        }
        .padding(5)
    }

    func columnView(left: Bool) -> some View {
        VStack(spacing: 0) {
            headerView()
            contentView(left)
                .padding(.top, left ? 0 : 2)
        }
        .padding(.trailing, 5)
    }

    func headerView() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Function")
                    .fFont(14)
                    .padding(.horizontal, 5)
                    .padding(.top, 2)
                    .padding(.bottom, 4)
                    .background(Color.gray(0.35))
                    .cornerRadius(3)
                Spacer()
                Text("Key")
                    .fFont(14)
                    .frame(width: 40)
                    .padding(.vertical, 3)
                    .background(Color.gray(0.35))
                    .cornerRadius(3)
            }
            .foregroundColor(.white)
            .padding(5)
        }
    }

    func contentView(_ left: Bool) -> some View {
        VStack( spacing: 0) {
            ZStack {
                VStack(spacing: 0) {
                    let inputs = left ? DataModel.leftSideKeys : DataModel.rightSideKeys
                    ForEach(inputs, id: \.self) { input in
                        HStack(spacing: 0) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 3)
                                    .stroke(Color.white, lineWidth: 0.5)
                                    .background(backgroundColor(input.key))
                                    .frame(width: keyWidth(input.key) + 1, height: 24)
                                label(input.key)
                                    .foregroundColor(foregroundColor(input.key))
                                    .frame(width: keyWidth(input.key), height: 23)
                            }
                            Spacer()
                            Text(keyName(input))
                                .fFont(17)
                                .cornerRadius(3)
                                .padding(.trailing, input == .enter ? 5 : 20)
                        }
                        .padding(.leading, 5)
                        .padding(.bottom, 8)
                    }
                    Spacer()
                }
                .background(Color.clear)
                .padding(.top, 5)
                .padding(.leading, 2)
            }
            Spacer()
        }
    }

    @ViewBuilder
    func label(_ key: DataModel.Key?) -> some View {
        if let key {
            if key.type == .brown || key.type == .black {
                key.fLabel
            } else {
                if let op = key.ops.first {
                    if [.substract, .add, .multiply, .divide, .enter, .pi].contains(op) {
                        key.bLabel
                    } else {
                        key.fLabel
                    }
                } else {
                    EmptyView()
                }
            }
        } else {
            EmptyView()
        }
    }

    func foregroundColor(_ key: DataModel.Key?) -> Color {
        guard let key, let op = key.ops.first else { return .clear }
        return op == .pi ? .black : .white
    }

    func keyWidth(_ key: DataModel.Key?) -> CGFloat {
        guard let key, let op = key.ops.first else { return 0 }
        return op == .enter ? 75 : 40
    }

    func keyName(_ input: String) -> String {
        if input == .enter {
            return "enter"
        } else if input == "L" {
            return Sym.leftTriangle
        } else if input == "D" {
            return Sym.downTriangle
        } else {
            return input
        }
    }

    func backgroundColor(_ key: DataModel.Key?) -> Color {
        guard let key else { return .clear }
        return switch key.type {
        case .blue, .blueLarge: .blue
        case .brown: .brown
        case .black: .black
        case .white: .white
        default: .clear
        }
    }
}

extension DataModel {
    static let leftSideKeys = ["^", "l", "n", "e", "q", "a", "s", "c", "t", "i", "L", "D"]
    static let rightSideKeys = ["\r", "C", "X", "E", "h", "-", "+", "*", "/", "p", "S", "R"]
}

extension String {
    var key: DataModel.Key? {
        for key in DataModel.shared.keys(for: Global.model) {
            if let first = key.ops.first, first == self.ops35.first {
                return key
            }
        }
        return nil
    }
}
