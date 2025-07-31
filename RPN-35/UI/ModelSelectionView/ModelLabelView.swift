//
//  ModelLabelView.swift
//  RPN35
//
//  Created by Enrique Haro on 5/26/25.
//

import SwiftUI

struct ModelLabelView: View {
    @EnvironmentObject var appService: AppService

    var body: some View {
        logoLabelView()
    }

    func logoLabelView() -> some View {
        HStack {
            logoImage
                .aspectRatio(contentMode: .fit)
                .frame(height: 20.0)
            Text(" RPN \(Sym.dot) CALCULATOR \(modelText)")
                .font(.century(size: .mac ? 14.0 : 16.0))
                .kerning(5.0)
                .minimumScaleFactor(0.8)
                .lineLimit(1)
                .foregroundColor(.white)
        }
        .padding(.top, 5.0)
        .padding(.bottom, .mac ? 10.0 : 20.0)
        .padding(.horizontal, .mac ? 10.0 : 20.0)
        .onTapGesture {
            appService.showSelectionView.toggle()
        }
    }

    var logoImage: Image {
        .isHP45 ? Images.hpLogoGray : Images.hpLogoBlue
    }

    var modelText: String {
        switch Global.model {
        case .hp21 : "21"
        case .hp35 : "35"
        case .hp45 : "45"
        case .mk61 : "61"
        }
    }
}
