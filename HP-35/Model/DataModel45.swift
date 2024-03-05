//
//  ModelHP35.swift
//  HP-35
//
//  Created by Enrique Haro on 2/8/24.
//

import Foundation

extension DataModel {
    var hp45Keys: [Key] {
        [
            // Row 0
            Key(type: .gray, ops: [.inverse, .powerYX], "1/", Sym.x, 14, 14, 0,
                                                       Sym.y, Sym.x, 17, 13, 6),
            Key(type: .gray, ops: [.ln, .log], "ln", "", 15, 0, 0,
                                               "", "log",0 , 15, 2),
            Key(type: .gray, ops: [.ex, .tenX], Sym.e, Sym.x, 17, 13, 6,
                                                 "10", Sym.x, 13, 12, 8),
            Key(type: .gray, ops: [.fix, .sci], "FIX", "", 14, 0, 0,
                                                "", "SCI", 0, 13, 2),
            Key(type: .orange, ops: [.fShift], "", "", 0, 0, 0),
            // Row 1
            Key(type: .gray, ops: [.powTwo, .sqrt], Sym.x, "2", 14, 12, 6,
                                               Sym.sqrt, Sym.x, 17, 14, 0),

            Key(type: .black, ops: [.toP, .toR], Sym.right, "P", 10, 14, 0,
                                                 Sym.right, "R", 10, 14, 2),

            Key(type: .black, ops: [.sin, .asin], "SIN", "", 14, 0, 0,
                                                "SIN", "-1", 13, 10, 6),
            Key(type: .black, ops: [.cos, .acos], "COS", "", 14, 0, 0,
                                                "COS", "-1", 13, 10, 6),
            Key(type: .black, ops: [.tan, .atan], "TAN", "", 14, 0, 0,
                                                "TAN", "-1", 13, 10, 6),
            // Row 2
            Key(type: .lightGray, ops: [.exchangeXY, .factorial], "", Sym.exchange, 0, 14, 4,
                                                                  "", "n!", 0, 16, 2),
            Key(type: .lightGray, ops: [.rotateDown], "", "R\(Sym.down35)", 0, 14, 2,
                                            "", "\(Sym.x)\(Sym.macron), s", 0, 16, 2),
            Key(type: .lightGray, ops: [.sto], "STO", "", 14, 0, 0,
                                       Sym.right, "D.MS", 8, 12, 0),
            Key(type: .lightGray, ops: [.rcl], "RCL", "", 14, 0, 0,
                                       "D.MS", Sym.right, 12, 8, 0),
            Key(type: .gray, ops: [.percentage], "%", "", 16, 0, 0,
                                     "", "\(Sym.delta)%", 0, 14, 2),
            // Row 4
            Key(type: .lightGrayLarge, ops: [.enter], "ENTER \(Sym.up35)", "", 17, 0, 0,
                                                                    "DEG", "", 13),
            Key(type: .lightGray, ops: [.chs], "CHS", "", 14, 0, 0,
                                               "RAD", "", 13),
            Key(type: .lightGray, ops: [.eex], "EEX", "", 14, 0, 0,
                                               "GRD", "", 13),
            Key(type: .lightGray, ops: [.clrX], "CL ", Sym.x, 14, 17, 2,
                                                "CLEAR", "", 13),
            Key(type: .lightGray, ops: [.substract], "", Sym.substract, 0, 24, 2),
            Key(type: .white, ops: [.digit("7")], "7", "", 17, 0, 0, "cm/in", "", 14),
            Key(type: .white, ops: [.digit("8")], "8", "", 17, 0, 0, "kg/lb", "", 14),
            Key(type: .white, ops: [.digit("9")], "9", "", 17, 0, 0, "ltr/gal", "", 14),
            Key(type: .lightGray, ops: [.add], "", Sym.add, 0, 22, 4),
            Key(type: .white, ops: [.digit("4")], "4", "", 17, 0, 0),
            Key(type: .white, ops: [.digit("5")], "5", "", 17, 0, 0),
            Key(type: .white, ops: [.digit("6")], "6", "", 17, 0, 0),
            Key(type: .lightGray, ops: [.multiply], "", Sym.multiply, 0, 22, 4),
            Key(type: .white, ops: [.digit("1")], "1", "", 17, 0, 0),
            Key(type: .white, ops: [.digit("2")], "2", "", 17, 0, 0),
            Key(type: .white, ops: [.digit("3")], "3", "", 17, 0, 0),
            Key(type: .lightGray, ops: [.divide], "", Sym.divide, 0, 24, 2),
            Key(type: .white, ops: [.digit("0")], "0", "", 17, 0, 0, "LAST ", Sym.x, 12, 16, 4),
            Key(type: .white, ops: [.digit("."), .pi], Sym.dot, "", 17, 0, 0, "", Sym.pi, 0, 19, 2),
            Key(type: .white, Sym.summation, "+", 17, 17, 0, "", "\(Sym.summation)-", 14, 14, 2),
        ]
    }
}
