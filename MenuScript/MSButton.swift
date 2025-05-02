//
//  MSButton.swift
//  MenuScript
//
//  Created by Renata Liu on 2025-05-01.
//

import SwiftUI

struct MSButton: View {
    let text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.mainBlue, lineWidth: 3)
                .background(.lightMint)
                .frame(width: 160, height: 50)
            Text(text)
                .fontWeight(.bold)
                .foregroundColor(.mainBlue)
                .font(.titanOne(fontSize: 20))
        }
    }
}

#Preview {
    MSButton(text: "Sample")
}
