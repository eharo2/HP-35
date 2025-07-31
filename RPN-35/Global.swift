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

enum Model: Identifiable {
    var id: String { UUID().uuidString }

    case hp35, hp45, hp21, mk61

    var name: String {
        switch self {
        case .hp35: "HP-35"
        case .hp45: "HP-45"
        case .hp21: "HP-21"
        case .mk61: Cyrilic.mk61Label
        }
    }
}
