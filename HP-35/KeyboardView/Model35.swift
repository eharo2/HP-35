//
//  ModelHP35.swift
//  HP-35
//
//  Created by Enrique Haro on 2/8/24.
//

#if os(iOS)
import UIKit
#else
import AppKit
#endif
import SwiftUI

class Model35 {
    static let shared = Model35()

    var keys = [Key]()

    init() {
        self.keys = [
            Key(type: .black, ops: [.powerXY], fLabel1: Sym.x, fLabel2: Sym.y, fLabel1Size: 17, fLabel2Size: 13, fOffset: 6),
            Key(type: .black, ops: [.log], fLabel1: "log"),
            Key(type: .black, ops: [.ln], fLabel1: "ln"),
            Key(type: .black, ops: [.ex], fLabel1: Sym.e, fLabel2: Sym.x, fLabel1Size: 17, fLabel2Size: 13, fOffset: 4),
            Key(type: .blue, ops: [.clr],  fLabel1: "CLR", fLabel1Size: 14),
            Key(type: .black, ops: [.sqrt], fLabel1: Sym.sqrt, fLabel2: Sym.x, fLabel2Size: 17),
            Key(type: .brown, ops: [.arc], fLabel1: "arc"),
            Key(type: .brown, ops: [.sin, .asin], fLabel1: "sin"),
            Key(type: .brown, ops: [.cos, .acos], fLabel1: "cos"),
            Key(type: .brown, ops: [.tan, .atan], fLabel1: "tan"),
            Key(type: .black, ops: [.inverse], fLabel1: "1/", fLabel2: Sym.x, fLabel1Size: 13, fLabel2Size: 16, fOffset: 0),
            Key(type: .black, ops: [.exchangeXY], fLabel1: Sym.exchange),
            Key(type: .black, ops: [.rotateDown], fLabel1: "R\(Sym.down35)", fLabel1Size: 14),
            Key(type: .black, ops: [.sto], fLabel1: "STO", fLabel1Size: 14),
            Key(type: .black, ops: [.rcl], fLabel1: "RCL", fLabel1Size: 14),

            Key(type: .blueLarge, ops: [.enter], bLabel1: "ENTER \(Sym.up35)"),
            Key(type: .blue, ops: [.chs], fLabel1: "CH S", fLabel1Size: 14),
            Key(type: .blue, ops: [.eex], fLabel1: "E EX", fLabel1Size: 14),
            Key(type: .blue, ops: [.clrX], fLabel1: "CL ", fLabel2: Sym.x, fLabel1Size: 14, fLabel2Size: 17, fOffset: 2),

            Key(type: .blue, ops: [.substract], bLabel1: Sym.substract, bLabel1Size: 24),
            Key(type: .white, bLabel1: "7"),
            Key(type: .white, bLabel1: "8"),
            Key(type: .white, bLabel1: "9"),
            Key(type: .blue, ops: [.add], bLabel1: Sym.add, bLabel1Size: 24),
            Key(type: .white, bLabel1: "4"),
            Key(type: .white, bLabel1: "5"),
            Key(type: .white, bLabel1: "6"),
            Key(type: .blue, ops: [.multiply], bLabel1: Sym.multiply, bLabel1Size: 24),
            Key(type: .white, bLabel1: "1"),
            Key(type: .white, bLabel1: "2"),
            Key(type: .white, bLabel1: "3"),
            Key(type: .blue, ops: [.divide], bLabel1: Sym.divide, bLabel1Size: 24),
            Key(type: .white, bLabel1: "0"),
            Key(type: .white, ops: [.decimalPoint], bLabel1: Sym.dot),
            Key(type: .white, ops: [.pi], bLabel1: Sym.pi, bLabel1Size: 22),
        ]
    }

    struct Key: Identifiable {
        let id: String = UUID().uuidString
        let type: KeyType
        let ops: [Op]

        let bLabel1: String
        let bLabel1Size: CGFloat
        let bOffset: CGFloat
        let fLabel1: String
        let fLabel2: String
        let fLabel1Size: CGFloat
        let fLabel2Size: CGFloat
        let fOffset: CGFloat

        init(
            type: KeyType = .none,
            ops: [Op] = [],
            bLabel1: String = "",
            bLabel1Size: CGFloat = 17,
            bOffset: CGFloat = 0,
            fLabel1: String = "",
            fLabel2: String = "",
            fLabel1Size: CGFloat = 16,
            fLabel2Size: CGFloat = 11,
            fOffset: CGFloat = 4) {
                self.type = type
                self.ops = ops
                self.bLabel1 = bLabel1
                self.bLabel1Size = bLabel1Size
                self.bOffset = bOffset
                self.fLabel1 = fLabel1
                self.fLabel2 = fLabel2
                self.fLabel1Size = fLabel1Size
                self.fLabel2Size = fLabel2Size
                self.fOffset = fOffset
            }

        var bLabel: some View {
            Text(self.bLabel1)
                .font(.system(size: bLabel1Size * Global.bFontFactor, weight: .regular))
                .padding(.bottom, 2)
        }
        var fLabel: some View { FLabel(key: self) }
    }

    struct FLabel: View {
        let key: Key

        var body: some View {
            HStack(spacing: 0) {
                Text(key.fLabel1)
                    .font(.system(size: key.fLabel1Size * Global.fFontFactor, weight: .regular))
                Text(key.fLabel2)
                    .baselineOffset(key.fOffset)
                    .font(.system(size: key.fLabel2Size * Global.fFontFactor, weight: .regular))
            }
        }
    }
}

struct Sym {
    static let x = "\u{1D499}"
    static let y = "\u{1D49A}"
    static let pi = "\u{1D6D1}"
    static let e = "\u{1D486}"
    static let add = "\u{002B}"
    static let dot = "\u{2022}"
    static let substract = "\u{002D}"
    static let multiply = "\u{00D7}"
    static let divide = "\u{00F7}"
    static let sqrt = "\u{221A}"
    static let left = "\u{21E6}"
    static let right = "\u{2B95}"
    static let up = "\u{21E7}"
    static let down = "\u{21E9}"
    static let exchange = "\u{1D499}\u{2276}\u{1D49A}"

    static let upTriangle = "\u{25B2}"
    static let downTriangle = "\u{25BC}"
    static let leftTriangle = "\u{25C0}"
    static let rightTriangle = "\u{25B6}"

    static let on = "\u{23FB}"
}

extension Sym {
    //  HP-35
    static let down35 = "\u{2193}"
    static let up35 = "\u{2191}"
}

extension String {
    var ops35: [Op] {
        switch self {
        case "^": [.powerXY]
        case "l": [.log]
        case "n": [.ln]
        case "e": [.ex]
        case "C": [.clr]
        case "q": [.sqrt]
        case "a": [.arc]
        case "s": [.sin, .asin]
        case "c": [.cos, .acos]
        case "t": [.tan, .atan]
        case "i": [.inverse]
        case "L": [.exchangeXY]
        case "D": [.rotateDown]
        case "S": [.sto]
        case "R": [.rcl]
        case "\r": [.enter]
        case "h": [.chs]
        case "E": [.eex]
        case "x": [.clrX]
        case "-": [.substract]
        case "+": [.add]
        case "*": [.multiply]
        case "/": [.divide]
        case "p": [.pi]
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ".": [.digit(self)]

            // Mac Keyboard only
        case .delete: [.delete]
        default: []
        }
    }
}
