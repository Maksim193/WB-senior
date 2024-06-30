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
        .background(Color("Purple"))
        .clipShape(.rect(cornerRadius: 12))
        .padding([.leading, .trailing], 24)
        .font(Font.custom("Montserrat-Medium", size: 16))
        .foregroundStyle(.white)
    }
}


#Preview {
    EnterCodeScreen()
}
