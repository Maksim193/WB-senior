//
//  MediumSatisfactionView.swift
//  WB-senior
//
//  Created by Максим Косников on 30.06.2024.
//

import SwiftUI

struct MediumSatisfactionView<Content>: View where Content: View {
    
    private let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.mediumSatisfactionColor1, Color.mediumSatisfactionColor2],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            self.content()
        }
        
        .clipShape(.rect(cornerRadius: 28))
    }

}
