//
//  Global.swift
//  RPN-35
//
//  Created by Enrique Haro on 2/12/24.
//

import Foundation

struct Global {
    static var model: Model = .hp35 {
        didSet {
            UserDefaults.standard.set("\(model)", forKey: UserDefaults.selectedModel)
            UserDefaults.standard.synchronize()
        }
    }
}

enum Model {
    case hp35, hp45, hp21, mk61
}
