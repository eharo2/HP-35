//
//  DataModelMK61.swift
//  RPN35
//
//  Created by Enrique Haro on 3/1/25.
//

import Foundation

extension DataModel {
    var mk_s1: CGFloat { 18.0 }
    var mk_s2: CGFloat { 14.0 }
    var mk_s3: CGFloat { 30.0 }

    var mk61Keys: [Key] {
        [
            // Row 0
            Key(type: .mkYellow, ops: [.fShift],
                "F", "", mk_s1, 0, 0),
            Key(type: .gray, ops: [.wr],
                Cyrilic.wr, "", 13, 0, 0,
                "x<0", "", mk_s2),
            Key(type: .gray, ops: [.rw],
                Cyrilic.wr, "", 13, 0, 0,
                "x>0", "", mk_s2),
            Key(type: .gray, ops: [.none],
                "B/O", "", mk_s2, 0, 0,
                "x\(Sym.greaterEqual)0", "", 15),
            Key(type: .gray, ops: [.none],
                "C/", Cyrilic.p, mk_s2, 15, 0,
                "x\(Sym.notEqual)0", "", 15),
            // Row 1
            Key(type: .mkBlue, ops: [.none],
                "K", "", mk_s1, 0, 0),
            Key(type: .gray, ops: [.sto(0, op: .none)],
                "\(Cyrilic.p)\(Sym.rightArrow)\(Cyrilic.x)", "", 14, 0, 0,
                "L0", "", mk_s2),
            Key(type: .gray, ops: [.rcl(0, op: .none)],
                "\(Cyrilic.x)\(Sym.rightArrow)\(Cyrilic.p)", "", 14, 0, 0,
                "L1", "", mk_s2),
            Key(type: .gray, ops: [.none],
                Cyrilic.dn, "", 15, 0, 0,
                "L2", "", mk_s2),
            Key(type: .gray, ops: [.none],
                Cyrilic.nn, "", 15, 0, 0,
                "L3", "", mk_s2),
            // Row 2
            Key(type: .mkWhite, ops: [.digit("7"), .sin, .int],
                "7", "", mk_s1, 0, 0,
                "sin", "", mk_s2, 0, 0,
                "[x]", "", mk_s2),
            Key(type: .mkWhite, ops: [.digit("8"), .cos, .frac],
                "8", "", mk_s1, 0, 0,
                "cos", "", mk_s2, 0, 0,
                "{x}", "", mk_s2),
            Key(type: .mkWhite, ops: [.digit("9"), .tan, .max],
                "9", "", mk_s1, 0, 0,
                "tg", "", mk_s2, 0, 0,
                "max", "", mk_s2),
            Key(type: .mkWhite, ops: [.substract, .sqrt],
                "", Sym.substract, 0, mk_s3, 0,
                Sym.sqrt, "", mk_s2),
            Key(type: .mkWhite, ops: [.divide, .inverse],
                "", Sym.divide, 0, mk_s3, 2, "1/",
                Sym.x, mk_s2, mk_s2, 0),
            // Row 3
            Key(type: .mkWhite, ops: [.digit("4"), .asin, .abs],
                "4", "", mk_s1, 0, 0,
                "sin", "-1", mk_s2, 10, 5,
                "|x|", "", mk_s2),
            Key(type: .mkWhite, ops: [.digit("5"), .acos],
                "5", "", mk_s1, 0, 0,
                "cos", "-1", mk_s2, 10, 5,
                Cyrilic.eh, "", mk_s2),
            Key(type: .mkWhite, ops: [.digit("6"), .atan],
                "6", "", mk_s1, 0, 0,
                "tg", "-1", mk_s2, 10, 5),
            Key(type: .mkWhite, ops: [.add, .pi], "",
                Sym.add, 0, mk_s3, 3,
                "", Sym.pi, 0, 18, 2),
            Key(type: .mkWhite, ops: [.multiply, .powTwo],
                "", Sym.multiply, 0, mk_s3, 4,
                Sym.x, "2", mk_s2, 10, 6),
            // Row 4
            Key(type: .mkWhite, ops: [.digit("1"), .ex],
                "1", "", mk_s1, 0, 0,
                Sym.e, Sym.x, 17, 12, 8),
            Key(type: .mkWhite, ops: [.digit("2"), .log],
                "2", "", mk_s1, 0, 0,
                "lg", "", mk_s2),
            Key(type: .mkWhite, ops: [.digit("3"), .ln],
                "3", "", mk_s1, 0, 0,
                "ln", "", mk_s2),
            Key(type: .mkWhite, ops: [.exchangeXY, .powerXY],
                Sym.leftRightArrow, "", mk_s1, 0, 0,
                Sym.x, Sym.y, 14, 12, 8),
            Key(type: .mkWhite, ops: [.enter, .lstX],
                Cyrilic.b, Sym.up35, 18, 18, 0,
                Cyrilic.b, Cyrilic.x, mk_s2, 12, -4,
                "C4", "", mk_s2),
            // Row 5
            Key(type: .mkWhite, ops: [.digit("0"), .tenX],
                "0", "", mk_s1, 0, 0,
                "10", Sym.x, mk_s2, 13, 12,
                "", Cyrilic.hon, 0, 13, 5),
            Key(type: .mkWhite, ops: [.digit("."), .rotateDown],
                Sym.dot, "", mk_s1, 0, 0),
            Key(type: .mkWhite, ops: [.chs],
                "/ - /", "", 17, 0, 0,
                "", "ABT", 0, mk_s2, 0),
            Key(type: .mkWhite, ops: [.eex],
                Cyrilic.bn, "", mk_s1, 0, 0,
                Cyrilic.nrp, "", mk_s2, 0, 0,
                Sym.plusCircle),
            Key(type: .mkRed, ops: [.clrX, .clr],
                Cyrilic.cx, "", mk_s1, 0, 0,
                "CF", "", mk_s2, 0, 0,
                Cyrilic.nhb, "", mk_s2),

// NOT USED
            Key(type: .mkWhite, ops: [.sto(0, op: .none), .toDMS], "STO", "", 14, 0, 0,
                                       Sym.right, "D.MS", 8, 12, 0),
            Key(type: .mkWhite, ops: [.rcl(0, op: .none), .fromDMS], "RCL", "", 14, 0, 0,
                                       "D.MS", Sym.right, 12, 8, 0),
            Key(type: .mkWhite, ops: [.percentage, .delta], "%", "", 16, 0, 0,
                                                         "", "\(Sym.delta)%", 0, 14, 2),
            Key(type: .mkWhite, ops: [.exchangeXY, .factorial], "", Sym.exchange, 0, 14, 4,
                                                                  "", "n!", 0, 16, 2),
            Key(type: .mkWhite, ops: [.rotateDown, .stdDev], "", "R\(Sym.down35)", 0, 14, 2,
                                                               "", "\(Sym.x)\(Sym.macron), s", 0, 16, 2),
            //            Key(type: .gray, ops: [.sin, .asin], "SIN", "", 14, 0, 0,
            //                                                "SIN", "-1", 13, 10, 6),
            //            Key(type: .gray, ops: [.cos, .acos], "COS", "", 14, 0, 0,
            //                                                "COS", "-1", 13, 10, 6),
            //            Key(type: .gray, ops: [.tan, .atan], "TAN", "", 14, 0, 0,
            //                                                "TAN", "-1", 13, 10, 6),
        Key(type: .gray, ops: [.toP, .toR], Sym.right, "P", 10, 14, 0,
                                                 Sym.right, "R", 10, 14, 2)
        ]
    }
}
