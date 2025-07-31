//
//  RPN-35App.swift
//  RPN-35
//
//  Created by Enrique Haro on 1/11/24.
//

import SwiftUI

@main
struct RPN35App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @StateObject var appService = AppService()
    @StateObject var rpnEngine = RPNEngine()

    var body: some Scene {
        WindowGroup {
        #if os(iOS)
            ZStack {
                Rectangle()
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                MainView()
                tutorialView()
                ModelSelectionView()
                    .offset(x: appService.showSelectionView ? 0 : UIScreen.main.bounds.width)
                    .animation(.easeOut(duration: 0.25), value: appService.showSelectionView)
            }
            .ignoresSafeArea()
        #else
            MainView()
        #endif
        }
        .environmentObject(appService)
        .environmentObject(rpnEngine)
        .windowResizabilityContentSize()
    }
}

extension Scene {
    func windowResizabilityContentSize() -> some Scene {
        if #available(macOS 13.0, *) {
            return windowResizability(.contentSize)
        } else {
            return self
        }
    }
}
