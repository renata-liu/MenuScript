//
//  MSButton.swift
//  MenuScript
//
//  Created by Renata Liu on 2025-05-01.
//

import SwiftUI

struct PrimaryMSButton: View {
    let text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.mainBlue, lineWidth: 4)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.lightMint)
                    )
                .frame(width: 160, height: 50)
            Text(text)
                .fontWeight(.bold)
                .foregroundColor(.mainBlue)
                .font(.titanOne(fontSize: 20))
        }
    }
}

struct SecondaryMSButton: View {
    let text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.accentOrange, lineWidth: 4)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.lightOrange)
                    )
                .frame(width: 160, height: 50)
            Text(text)
                .fontWeight(.bold)
                .foregroundColor(.accentOrange)
                .font(.titanOne(fontSize: 20))
        }
    }
}

#Preview {
    HStack {
        PrimaryMSButton(text: "PRIMARY")
        SecondaryMSButton(text:"SECONDARY")
    }
}
