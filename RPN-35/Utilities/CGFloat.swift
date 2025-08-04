//
//  CGFloat.swift
//  RPN35
//
//  Created by Enrique Haro on 8/4/25.
//

import UIKit

extension CGFloat {
    init(_ iPhone: CGFloat, _ iPadOrSmallScreen: CGFloat) {
        self = (Bool.isSE || Bool.iPad) ? iPadOrSmallScreen : iPhone
    }
}
