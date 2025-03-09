//
//  Strings.swift
//  RPN35
//
//  Created by Enrique Haro on 3/4/25.
//

import Foundation

struct Cyrilic {
    static let mk61Label = "ЭЛЕКТРОНИКА MK 61"
    static let on = "Вкл"
    static let rad = "P"
    static let grd = "ГРД"
    static let deg = "Г"
    static let eh = "ЭН"
    static let w = "Ш"
    static let r = "Г"
    static let p = "П"
    static let d = "Б"
    static let b = "В"
    static let c = "С"
    static let o = "О"
    static let x = "Х"
    static let h = "Н"
    static let n = "И"
    static let s = "P"
    static let wr = Self.w + Self.r
    static let dn = Self.d + Self.p
    static let bn = Self.b + Self.p
    static let nn = Self.p + Self.p
    static let cx = Self.c + Self.x // СХ - CLR X
    static let hon = Self.h + Self.o + Self.p
    static let nrp = Self.p + Self.s + Self.r
    static let nhb = Self.n + Self.h + Self.b
    // П->Х - STO X
    // Х->П - RCL X
    // ВП   - EEX
    // СF   - CLR F
}
