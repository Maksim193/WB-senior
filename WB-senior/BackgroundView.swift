//
//  BackgroundView.swift
//  WB-senior
//
//  Created by Максим Косников on 30.06.2024.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Image("backgroundDalle", bundle: nil)
            .resizable()
            .edgesIgnoringSafeArea(.all)
            .blur(radius: 80, opaque: true)
    }
}

#Preview {
    BackgroundView()
}
