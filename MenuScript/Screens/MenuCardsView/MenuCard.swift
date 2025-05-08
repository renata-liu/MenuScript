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
    var imageURL: String?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .stroke(.earthGreen, lineWidth: 3)
                .padding(.horizontal, 20)
            
            HStack {
                if let imageURL = imageURL, let url = URL(string: imageURL) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120)
                            .clipped()
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 14,
                                    bottomLeadingRadius: 14,
                                    bottomTrailingRadius: 0,
                                    topTrailingRadius: 0
                                )
                            )
                            .padding(1.4)
                    } placeholder: {
                        Image(.logo)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 90, height: 90)
                    }
                } else {
                    Image(.plainLogo)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipped()
                        .clipShape(
                            .rect(
                                topLeadingRadius: 14,
                                bottomLeadingRadius: 14,
                                bottomTrailingRadius: 0,
                                topTrailingRadius: 0
                            )
                        )
                        .padding(1.4)
                        .offset(x: 8)
                }
                
                VStack (alignment: .leading){
                    HStack {
                        Text(dishName)
                            .font(.titanOne(fontSize: 18))
                            .foregroundColor(.forestGreen)
                            .padding(.top, 15)
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                        Text(price ?? "")
                            .font(.lunasimaBold(fontSize: 15))
                            .foregroundColor(.forestGreen)
                            .padding(.top, 15)
                    }
                    .padding(.trailing, 25)
                    .padding(.leading, 10)
                    Text(originalName.uppercased())
                        .foregroundStyle(.earthGreen)
                        .font(.lunasimaBold(fontSize: 15))
                        .padding(.bottom, 1)
                        .padding([.leading, .trailing], 10)
                    Text(description)
                        .font(.lunasimaRegular(fontSize: 15))
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, 15)
                        .padding([.leading, .trailing], 10)
                }
            }
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
    ScrollView {
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
