//
//  DataModel35.swift
//  HP-35
//
//  Created by Enrique Haro on 2/27/24.
//

import Foundation

extension DataModel {
    var hp35Keys: [Key] {
        [
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
}
