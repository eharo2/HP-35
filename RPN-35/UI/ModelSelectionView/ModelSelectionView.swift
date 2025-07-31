//
//  ModelSelectionView.swift
//  RPN35
//
//  Created by Enrique Haro on 11/30/24.
//

import SwiftUI

struct ModelSelectionView: View {
    @EnvironmentObject var appService: AppService
    @EnvironmentObject var rpnEngine: RPNEngine
//    @State var touchState = TouchState.ended
//    @State var touchPoint: CGPoint = .zero

    let models: [Model] = [.hp35, .hp45, .hp21, .mk61]

    var body: some View {
        VStack(spacing: 0.0) {
            backToolbar()
            modelSelectionView()
            sectionView()
                .padding(.top, 30.0)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .foregroundStyle(Color.white)
    }

    private func modelSelectionView() -> some View {
        VStack(spacing: 0.0) {
            HStack {
                Text("Model")
                    .font(.century(size: 16.0))
                    .kerning(1.0)
                Spacer()
            }
            .padding(.horizontal, 35.0)
            .padding(.bottom, 6.0)
            VStack(spacing: 0.0) {
                ForEach(models) { model in
                    modelCell(model)
                }
            }
            .background(Color.gray(0.15))
            .cornerRadius(8.0)
            .padding(.horizontal, 20.0)
        }
    }

    func backToolbar() -> some View {
        HStack(spacing: 0.0) {
            Image(systemName: "chevron.left")
                .frame(width: 26.0, height: 30.0)
            Text("Back")
            Spacer()
        }
        .foregroundStyle(Color.hp21_blue)
        .padding(.top, 50.0)
        .padding(.bottom, 20.0)
        .padding(.horizontal, 10.0)
        .onTapGesture {
            appService.showSelectionView = false
        }
    }

    func modelCell(_ model: Model) -> some View {
        VStack(spacing: 0.0) {
            HStack {
                Text(model.name)
                    .font(.century(size: 16.0))
                    .kerning(2.0)
                    .padding(.leading, 15.0)
                    .foregroundStyle(Color.white)
                            if model == .mk61 {
                                Spacer()
                            } else {
                                Rectangle()
                                    .foregroundStyle(Color.gray(0.15))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                            if model == Global.model {
                                Image(systemName: "checkmark")
                                    .frame(width: 30.0, height: 30.0)
                                    .foregroundStyle(Color.hp21_blue)
                                    .padding(.trailing, 5.0)
                            }
            }
            .frame(height: 40.0)
            Rectangle()
                .frame(height: 1.0)
                .foregroundStyle(Color.gray(0.2))
                .padding(.leading, 10.0)
                .padding(.trailing, 5.0)
        }
//        .onTouchBegan(touchState: $touchState) {
//            print("Began")
//        }
//        .onTouchMoved(touchState: $touchState) {
//            print("Moved")
//        }
//        .onTouchEnded(touchState: $touchState) {
//            print("Ended")
//        }
//        .touchHandler($touchState, $touchPoint)
//        .onChange(of: touchState) { _, touchState in
//            print("Touch state: \(touchState)")
//        }
        .onTapGesture {
            Global.model = model
            rpnEngine.resetView()
        }
    }

    private func sectionView() -> some View {
        VStack(spacing: 0.0) {
            VStack(spacing: 0.0) {
                HStack {
                    Text("")
                        .font(.century(size: 16.0))
                        .kerning(1.0)
                    Spacer()
                }
            }
            .padding(.horizontal, 35.0)
            .padding(.bottom, 6.0)
        }
    }
}
