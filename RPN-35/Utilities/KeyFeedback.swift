//
//  KeyFeedback.swift
//  RPN35
//
//  Created by Enrique Haro on 4/16/25.
//

import UIKit

class KeyFeedbackGenerator {
    static let shared = KeyFeedbackGenerator()

#if os(iOS)
    let haptic = UIImpactFeedbackGenerator(style: .soft)
#endif
    var onOffPosition: TogglePosition = .right

    private init() {}

    func vibrate(forceFeedback: Bool = false) {
        // On/Off Key should always vibrate
        guard onOffPosition == .right || forceFeedback else { return }
        KeyFeedbackGenerator.shared.haptic.impactOccurred()
    }
}


