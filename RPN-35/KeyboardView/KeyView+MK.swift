//
//  KeyView+MK.swift
//  RPN35
//
//  Created by Enrique Haro on 3/1/25.
//

import SwiftUI

extension KeyView {
    func mk61_KeyView() -> some View {
        VStack(spacing: 0.0) {
            HStack(spacing: 5.0) {
                key.fLabel
                    .foregroundColor(.mk61_yellow)
                    .padding(.trailing, key.type == .lightGrayLarge ? 15.0 : 0.0)
                customGLabel()
            }
            ZStack {
                Rectangle()
                    .foregroundColor(.black)
                    .cornerRadius(5.0)
                    .padding(.horizontal, 6.5)
                ZStack {
                    keyViewMK61(keyColor)
                        .padding(.horizontal, 7.0)
                    VStack(spacing: 0.0) {
                        Group {
                            if key.ops[0] == .wr {
                                Text(Sym.rightArrow)
                            }
                            if key.ops[0] == .rw {
                                Text(Sym.leftArrow)
                            }
                        }
                        .padding(.top, -5.0)
                        .padding(.bottom, -5.0)
                        key.bLabel
                            .padding(.vertical, vPadding)
                            .padding(.bottom, 9.0)
                    }
                    .foregroundColor(foregroundColor)
                }
                .padding(1.0)
                .padding(.top, clicked ? 2.0 : 0.0)
            }
            .frame(height: width)
            .padding(.bottom, 5.0)
        }
        .frame(minWidth: keyWidth) // .border(Color.red)
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

    func keyViewMK61(_ color: Color) -> some View {
        ZStack {
            subview(.black, radiusFactor: 0.08)
            subview(color, radiusFactor: 0.08).opacity(0.5)
            subview(color, radiusFactor: 0.08)
                .padding([.leading, .top, .trailing], 2.0)
                .padding(.bottom, 3.0)
            subview(.white, radiusFactor: 0.08)
                .padding([.leading, .top, .trailing], 4.0)
                .padding(.bottom, 5.0)
            subview(color, radiusFactor: 0.08)
                .padding([.leading, .top], 4.0)
                .padding(.trailing, 6.0)
                .padding(.bottom, 7.0)
        }
    }

    func customGLabel() -> some View {
        Group {
            if key.ops[0] == .digit("6") {
                customGSubLabel(arrow: Sym.leftArrow, text: "O /")
            } else if key.ops[0] == .add {
                customGSubLabel(arrow: Sym.rightArrow, text: "O /")
            } else if key.ops[0] == .digit("3") {
                customGSubLabel(arrow: Sym.leftArrow, text: "O / //")
            } else if key.ops[0] == .exchangeXY {
                customGSubLabel(arrow: Sym.rightArrow, text: "O / //")
            } else {
                key.gLabel
                    .foregroundColor(.mk61_blue)
            }
        }
    }

    func customGSubLabel(arrow: String, text: String) -> some View {
        ZStack {
            Text(arrow)
                .font(.mk61Font(size: 15.0))
                .padding(.bottom, 10.0)
            Text(text)
                .font(.mk61Font(size: 14.0))
                .padding(.top, 10.0)
        }
        .foregroundColor(.mk61_blue)
        .padding(.top, -3.0)
    }

    var vPadding: CGFloat {
        if key.bLabel1.isEmpty {
            if key.bLabel2 == Sym.multiply {
                return -14.5
            }
            if key.bLabel2 == Sym.substract {
                return -15.0
            }
            if key.bLabel2 == Sym.add {
                return -14.5
            }
            if key.bLabel2 == Sym.divide {
                return -14.0
            }
        }
        return -5.0
    }
}
