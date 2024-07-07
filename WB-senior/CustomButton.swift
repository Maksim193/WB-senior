//
//  CustomButton.swift
//  WB-senior
//
//  Created by Максим Косников on 30.06.2024.
//

import SwiftUI

struct CustomButton<Content>: View where Content: View {
	
	private let action: () -> Void
	private let content: () -> Content
	
	@State private var tapped = false
	
	init(
		action: @escaping () -> Void,
		content: @escaping () -> Content
	) {
		self.action = action
		self.content = content
	}
	
	var body: some View {
		self.content()
			.frame(maxWidth: .infinity, maxHeight: 48)
			.background(Color.wbpurple)
			.clipShape(.rect(cornerRadius: 12))
			.padding([.leading, .trailing], 24)
			.font(Fonts.bodyMedium)
			.foregroundStyle(.white)
			.onTapGesture {
				self.action()
			}
			.onLongPressGesture(minimumDuration: 100, pressing: { isPress in
				self.tapped = isPress
			}, perform: {})
			.opacity(self.tapped ? 0.3 : 1)
	}
}


#Preview {
	EnterCodeScreen()
}
