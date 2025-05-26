//
//  AppService.swift.swift
//  RPN35
//
//  Created by Enrique Haro on 5/26/25.
//

import SwiftUI

class AppService: ObservableObject {
    @Published var showTutorial: Bool = true
    @Published var showModelSelectionView = false
    @Published var showKeyboard: Bool = !.mac
    @Published var showInfo: Bool = false

    let didShowTutorialKey: String = "didShowTutorial"

    init() {
        showTutorial = !didShowTutorialInUserDefaults()
    }

    func dismissTutorialView() {
        showTutorial = false
        UserDefaults.standard.set(!showTutorial, forKey: didShowTutorialKey)
        UserDefaults.standard.synchronize()
    }

    func didShowTutorialInUserDefaults() -> Bool {
        UserDefaults.standard.value(forKey: didShowTutorialKey) as? Bool ?? false
    }
}

extension UserDefaults {
    struct Key {
        let selectedModel: String = "selectedModel"
    }
}
