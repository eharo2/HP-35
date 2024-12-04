//
//  DebugInspector.swift
//  RPN35
//
//  Created by Enrique Haro on 12/3/24.
//

import SwiftUI

extension ObservableObject {
    var instanceAddress: String {
        "\(Unmanaged.passUnretained(self).toOpaque())"
    }
}
