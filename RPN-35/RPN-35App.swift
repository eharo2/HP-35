//
//  RPN-35App.swift
//  RPN-35
//
//  Created by Enrique Haro on 1/11/24.
//

import SwiftUI

@main
struct RPN35App: App {
    @StateObject var appService = AppService()
    @State var showKeyboard: Bool = !.mac
    @State var showInfo: Bool = false

    var body: some Scene {
        WindowGroup {
        #if os(iOS)
            ZStack {
                Rectangle()
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                mainView()
                    .padding(.top, 40)
            }
            .ignoresSafeArea()
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
                .if(!.hp21) {
                    $0.padding(.bottom, 5)
                }
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
                KeyboardView()
                    .environmentObject(appService)
                    #if os(macOS)
                    .frame(height: 580)
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
        .if(.hp21) { view in
            ZStack {
                Rectangle()
                    .border(Color.hp21_yellow, width: 6)
                    .cornerRadius(8)
                    .padding(.bottom, 30)
                view
                    .padding(6)
                    .padding(.bottom, 30)
            }
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
