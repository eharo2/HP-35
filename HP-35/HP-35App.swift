//
// HP-35App.swift
// HP-35
//
//  Created by Enrique Haro on 1/11/24.
//

import SwiftUI

@main
struct Retro35App: App {
    let global = Global()
    @StateObject var appService = AppService()
    #if os(iOS)
    @State var showKeyboard: Bool = true
    #else
    @State var showKeyboard: Bool = false
    #endif
    @State var showInfo: Bool = false

    var body: some Scene {
        WindowGroup {
        #if os(iOS)
            ZStack {
                Rectangle()
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                mainView()
            }
        #else
            mainView()
        #endif
        }
        .windowResizabilityContentSize()
    }

    func mainView() -> some View {
        VStack(spacing: 0) {
            DisplayView()
                .frame(height: 80)
                .environmentObject(appService)
                .toolbar {
                    HStack {
                        #if os(macOS)
                        Image(systemName: "book")
                            .onTapGesture {
                                showKeyboard = false
                                showInfo.toggle()
                            }
                        #endif
                        Image(systemName: "keyboard")
                            .onTapGesture {
                                showInfo = false
                                showKeyboard.toggle()
                            }
                    }
                }
            if showKeyboard {
                KeyboardView35()
                    .environmentObject(appService)
                    #if os(macOS)
                    .frame(height: 550)
                    #else
                    .frame(maxHeight: .infinity)
                    #endif
            }
            #if os(macOS)
            if showInfo {
                InfoView35()
            }
            #endif
        }
        #if os(macOS)
        .frame(width: 320)
        #else
        .frame(maxWidth: .infinity)
        #endif
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
