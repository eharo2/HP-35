//
//  AppDelegate.swift
//  RPN35
//
//  Created by Enrique Haro on 5/19/25.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("App started")
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(applicationWillResignActive),
                         name: UIApplication.willResignActiveNotification,
                         object: nil)
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(applicationDidBecomeActive),
                         name: UIApplication.didBecomeActiveNotification,
                         object: nil)
        if let model = UserDefaults.standard.value(forKey: UserDefaults.selectedModel) as? String {
            if model.contains("45") {
                Global.model = .hp45
            } else if model.contains("21") {
                Global.model = .hp21
            } else if model.contains("61") {
                Global.model = .mk61
            } else {
                Global.model = .hp35 // Default
            }
        }
        return true
    }

    @objc func applicationWillResignActive() {
        print("Will resign")
    }

    @objc func applicationDidBecomeActive() {
        print("Did become active")
    }
}

extension UserDefaults {
    static let selectedModel = "selectedModel"
}
