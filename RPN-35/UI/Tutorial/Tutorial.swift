//
//  Tutorial.swift
//  RPN35
//
//  Created by Enrique Haro on 4/16/25.
//

import SwiftUI

extension RPN35App {
    @ViewBuilder func tutorialView() -> some View {
        if appService.showTutorial {
            ZStack {
                Rectangle()
                    .foregroundColor(.gray).opacity(0.6)
                VStack {
                    Spacer()
                    VStack {
                        Text("Select the calculator model clicking on the Model Name bar below")
                            .font(Font.custom("Century Gothic", size: 20))
                            .foregroundColor(.black)
                        HStack {
                            Spacer()
                            Text("Got it...")
                                .font(Font.custom("Century Gothic", size: 20.0))
                                .foregroundColor(.keyCyan35)
                        }
                    }
                    .padding(15.0)
                    .background(Color.keyWhite45)
                    .cornerRadius(12.0)
                    .padding(.horizontal, 12.0)
                    .padding(.bottom, 60.0)
                    .onTapGesture {
                        appService.dismissTutorialView()
                    }
                }
            }
        } else {
            EmptyView()
        }
    }
}
