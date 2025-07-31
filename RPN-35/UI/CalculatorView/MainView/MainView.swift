//
//  MainView.swift
//  RPN35
//
//  Created by Enrique Haro on 5/26/25.
//

import SwiftUI

struct MainView: View {
    @StateObject var appService = AppService()

    var body: some View {
        mainView()
            .padding(6.0)
            .padding(.top, 45.0)
    }

    func mainView() -> some View {
        VStack(spacing: 0.0) {
            DisplayView()
                .frame(height: 80.0)
                .padding(.bottom, 10.0)
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
                                appService.showInfo = false
                                appService.showKeyboard.toggle()
                            }
                    }
                }
            if appService.showKeyboard {
                KeyboardView()
                    #if os(macOS)
                    .frame(height: 580.0)
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
        .frame(width: 320.0)
        #else
        .frame(maxWidth: .infinity)
        #endif
    }
}
