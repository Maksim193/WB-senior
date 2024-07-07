//
//  EnterCodeScreen.swift
//  WB-senior
//
//  Created by Максим Косников on 30.06.2024.
//

import SwiftUI

enum OTPTextFieldState {
	case clear
	case incorrect
	case correct
}

struct EnterCodeScreen: View {
	
	@FocusState private var oTPTextFieldFocusState : FocusOTPTextField?
	@State var firstDigit: String = ""
	@State var secondDigit: String = ""
	@State var thirdDigit: String = ""
	@State var fourthDigit: String = ""
	@State var textFieldState: OTPTextFieldState = .clear
	
	private let phoneNumber: String = "+7 (921) 233-123-44"
	private var secondsToRetryOTP: Int = 56
	
	var body: some View {
		ZStack {
			BackgroundView()
			VStack {
				MediumSatisfactionView() {
					VStack(spacing: 0) {
						envelopeView
						phoneText
						OTPView
						requestOTP
						authButton
					}
				}
				.frame(maxWidth: 400, maxHeight: 429)
				.padding(.horizontal, 16)
				backButton
			}
		}
	}
	
	// MARK: - Private methods
	
	private func auth() {
		if firstDigit + secondDigit + thirdDigit + fourthDigit == "1234" {
			textFieldState = .correct
		} else {
			textFieldState = .incorrect
		}
	}
}

// MARK: - Views

extension EnterCodeScreen {
	private var envelopeView: some View {
		Image("envelope")
			.padding(.top, 46)
	}
	
	private var phoneText: some View {
		Text(phoneNumber)
			.frame(maxHeight: 29)
			.font(Fonts.titleHeader2)
			.foregroundStyle(.white)
			.padding(.top, 22)
			.padding(.bottom, 24)
	}
	
	private var OTPView: some View {
		VStack {
			HStack(spacing:24) {
				TextField("", text: $firstDigit)
					.modifier(OTPTextFieldModifer(text:$firstDigit, textFieldState: $textFieldState))
					.onChange(of:firstDigit) { value in
						textFieldState = .clear
						if (value.count == 2) {
							oTPTextFieldFocusState = .second
							guard let nextDigit = value.last else { return }
							secondDigit = String(nextDigit)
						}
					}
					.focused($oTPTextFieldFocusState, equals: .first)
				TextField("", text:  $secondDigit)
					.modifier(OTPTextFieldModifer(text:$secondDigit, textFieldState: $textFieldState))
					.onChange(of:secondDigit) { value in
						if (value.count == 2) {
							oTPTextFieldFocusState = .third
							guard let nextDigit = value.last else { return }
							thirdDigit = String(nextDigit)
						} else if (value.count == 0) {
							oTPTextFieldFocusState = .first
						}
					}
					.focused($oTPTextFieldFocusState, equals: .second)
				TextField("", text:$thirdDigit)
					.modifier(OTPTextFieldModifer(text:$thirdDigit, textFieldState: $textFieldState))
					.onChange(of:thirdDigit) { value in
						if (value.count == 2) {
							oTPTextFieldFocusState = .fourth
							guard let nextDigit = value.last else { return }
							fourthDigit = String(nextDigit)
						} else if (value.count == 0) {
							oTPTextFieldFocusState = .second
						}
					}
					.focused($oTPTextFieldFocusState, equals: .third)
				TextField("", text:$fourthDigit)
					.modifier(OTPTextFieldModifer(text:$fourthDigit, textFieldState: $textFieldState))
					.onChange(of:fourthDigit) { value in
						if (value.count == 0) {
							oTPTextFieldFocusState = .third
							textFieldState = .clear
						} else {
							auth()
						}
					}
					.focused($oTPTextFieldFocusState, equals: .fourth)
			}
			Text("Неверный пароль")
				.foregroundStyle(.opacityRed)
				.opacity(textFieldState == .incorrect ? 1 : 0)
		}
		.padding(.vertical)
		.frame(maxHeight: 80)
		.padding(.top, 18)
		.padding(.bottom, 30)
	}
	
	private var requestOTP: some View {
		Text("Запросить повторно через \(secondsToRetryOTP) сек")
			.font(Fonts.body)
			.foregroundStyle(.white)
			.padding([.top], 15)
	}
	
	private var authButton: some View {
		CustomButton {
			self.auth()
		} content: {
			Text("Авторизоваться")
		}
		.padding(.top, 24)
		.padding(.bottom, 48)
	}
	
	private var backButton: some View {
		Button { } label: {
			Label("Вернуться назад", systemImage: "chevron.left")
				.foregroundStyle(.white)
				.font(Fonts.body)
		}
		.padding(.top, 32)
	}
}

#Preview {
	EnterCodeScreen()
}
