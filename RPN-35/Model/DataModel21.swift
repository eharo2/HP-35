//
//  DataModel21.swift
//  RPN35
//
//  Created by Enrique Haro on 11/27/24.
//

import Foundation

extension DataModel {
    var hp21Keys: [Key] {
        [
            // Row 0 - Ignore Row in HP-21
            Key("", "", 0, 0, 0),
            Key("", "", 0, 0, 0),
            Key("", "", 0, 0, 0),
            Key("", "", 0, 0, 0),
            Key("", "", 0, 0, 0),
            // Row 1
            Key(type: .black, ops: [.inverse, .powerYX], "1/", Sym.x, 14, 14, 0,
                                                        Sym.y, Sym.x, 15, 12, 6),
            Key(type: .black, ops: [.sin, .asin], "SIN", "", 14, 0, 0,
                                                "SIN", "-1", 11, 8, 6),
            Key(type: .black, ops: [.cos, .acos], "COS", "", 14, 0, 0,
                                                "COS", "-1", 11, 8, 6),
            Key(type: .black, ops: [.tan, .atan], "TAN", "", 14, 0, 0,
                                                "TAN", "-1", 11, 8, 6),
            Key(type: .blue, ops: [.fShift],  fLabel1: "", fLabel1Size: 0),
            // Row 2
            Key(type: .black, ops: [.exchangeXY, .toR], "", Sym.exchange, 0, 14, 4,
                                                         Sym.right, "R", 10, 13, 2),
            Key(type: .black, ops: [.rotateDown, .toP], "", "R\(Sym.down35)", 0, 14, 2,
                                                             Sym.right, "P", 10, 13, 0),
            Key(type: .black, ops: [.ex, .ln], Sym.e, Sym.x, 17, 13, 6,
                                                    "ln", "", 15, 0, 2),
            Key(type: .black, ops: [.sto, .log], "STO", "", 14, 0, 0,
                                                 "", "log", 0, 15, 2),
            Key(type: .black, ops: [.rcl, .tenX], "RCL", "", 14, 0, 0,
                                               "10", Sym.x, 13, 12, 8),
            // Row 4
            Key(type: .blackLarge, ops: [.enter], "ENTER \(Sym.up35)", "", 17, 0, 0),
            Key(type: .black, ops: [.chs, .sqrt], "CHS", "", 14, 0, 0,
                                           Sym.sqrt, Sym.x, 12, 14, 0),
            Key(type: .black, ops: [.eex, .pi], "EEX", "", 14, 0, 0,
                                               "", Sym.pi, 0, 17, 0),
            Key(type: .black, ops: [.clrX, .clr], "CL", Sym.x, 14, 17, 2,
                                                      "", "CLR", 0, 12, 2),
            // Row 5
            Key(type: .white, ops: [.substract], "", Sym.substract, 0, 16, 2,
                                               "M", Sym.substract, 12, 12, 2),
            Key(type: .white, ops: [.digit("7")], "7", "", 17, 0, 0),
            Key(type: .white, ops: [.digit("8")], "8", "", 17, 0, 0),
            Key(type: .white, ops: [.digit("9")], "9", "", 17, 0, 0),
            Key(type: .white, ops: [.add], "", Sym.add, 0, 16, 4,
                                         "M", Sym.add, 12, 12, 2),
            Key(type: .white, ops: [.digit("4")], "4", "", 17, 0, 0),
            Key(type: .white, ops: [.digit("5")], "5", "", 17, 0, 0),
            Key(type: .white, ops: [.digit("6")], "6", "", 17, 0, 0),
            Key(type: .white, ops: [.multiply], "", Sym.multiply, 0, 16, 4,
                                              "M", Sym.multiply, 12, 12, 2),
            Key(type: .white, ops: [.digit("1")], "1", "", 17, 0, 0),
            Key(type: .white, ops: [.digit("2")], "2", "", 17, 0, 0),
            Key(type: .white, ops: [.digit("3")], "3", "", 17, 0, 0),
            Key(type: .white, ops: [.divide], "", Sym.divide, 0, 16, 2,
                                            "M", Sym.divide, 12, 12, 2),
            Key(type: .white, ops: [.digit("0")], "0", "", 17, 0, 0),
            Key(type: .white, ops: [.digit(".")], Sym.dot, "", 17, 0, 0, ""),
            Key(type: .white, "DSP", "", 15, 0, 0, ""),
        ]
    }
}
