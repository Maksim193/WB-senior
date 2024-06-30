//
//  OTPTextFieldModifier.swift
//  WB-senior
//
//  Created by Максим Косников on 30.06.2024.
//

import SwiftUI

enum FocusOTPTextField {
    case first
    case second
    case third
    case fourth
}

struct OTPTextFieldModifer: ViewModifier {

    @Binding var text : String

    var textLimt = 1

    func body(content: Content) -> some View {
        content
            .frame(width: 64, height: 80)
            .background(.white.opacity(0.08))
            .clipShape(.rect(cornerRadius: 12))
            .font(Font.custom("Montserrat-Black", size: 36))
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onChange(of: text, perform: { value in
                self.text = String(text.prefix(textLimt))
            })
    }
}
