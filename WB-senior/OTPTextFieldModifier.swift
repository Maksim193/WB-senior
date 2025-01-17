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
	@Binding var textFieldState: OTPTextFieldState
	
	var textLimt = 1
	
	func body(content: Content) -> some View {
		content
			.frame(width: 64, height: 80)
			.background(.white.opacity(0.08))
			.clipShape(.rect(cornerRadius: 12))
			.font(Fonts.titleHeader1)
			.foregroundStyle(.white)
			.tint(.clear)
			.multilineTextAlignment(.center)
			.keyboardType(.numberPad)
			.onChange(of: text, perform: { value in
				if value.count > textLimt {
					self.text = String(value.prefix(textLimt))
				}
			})
			.overlay(
				RoundedRectangle(cornerRadius: 14)
					.stroke(self.getBorderColor(), lineWidth: 2)
			)
	}
	
	private func getBorderColor() -> Color {
		switch textFieldState {
		case .clear:
			return .clear
		case .incorrect:
			return .opacityRed
		case .correct:
			return .opacityGreen
		}
	}
}

#Preview {
	ContentView()
}
