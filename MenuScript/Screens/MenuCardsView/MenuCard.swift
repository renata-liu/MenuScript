//
//  MenuCardView.swift
//  MenuScript
//
//  Created by Renata Liu on 2025-05-04.
//

import SwiftUI

struct MenuCard: View {
    var dishName: String
    var originalName: String
    var price: String?
    var description: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .stroke(.earthGreen, lineWidth: 3)
                .padding(.horizontal, 20)
            
            HStack {
                Image(.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 90)
                
                VStack (alignment: .leading){
                    HStack {
                        Text(dishName)
                            .font(.titanOne(fontSize: 18))
                            .foregroundColor(.forestGreen)
                            .padding(.bottom, 1)
                        Spacer()
                        Text(price ?? "")
                            .font(.lunasimaBold(fontSize: 15))
                            .foregroundColor(.forestGreen)
                            .padding(.trailing, 15)
                    }
                    Text(originalName.uppercased())
                        .foregroundStyle(.earthGreen)
                        .offset(y: -5)
                        .font(.lunasimaBold(fontSize: 15))
                    Text(description)
                        .font(.lunasimaRegular(fontSize: 15))
                        .padding(.trailing, 6)
                        .padding(.top, 1)
                        .offset(y: -5)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(12)
            .frame(width: UIScreen.main.bounds.width - 40)
        }
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.offMint)
            )
        .padding(.top, 6)
    }
}

#Preview {
    VStack {
        MenuCard(dishName: MockData.sampleMenuItem1.name,
                 originalName: MockData.sampleMenuItem1.originalName,
                 price: MockData.sampleMenuItem3.price,
                 description: MockData.sampleMenuItem3.description)
        MenuCard(dishName: MockData.sampleMenuItem3.name,
                 originalName: MockData.sampleMenuItem3.originalName,
                 price: MockData.sampleMenuItem3.price,
                 description: MockData.sampleMenuItem3.description)
    }
}
