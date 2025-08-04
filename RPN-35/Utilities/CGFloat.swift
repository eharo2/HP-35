//
//  CGFloat.swift
//  RPN35
//
//  Created by Enrique Haro on 8/4/25.
//

import UIKit

extension CGFloat {
    init(_ iPhone: CGFloat, _ iPad: CGFloat) {
        self = Bool.iPhone ? iPhone : iPad
    }
}
