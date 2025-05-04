//
//  MenuCardsView.swift
//  MenuScript
//
//  Created by Renata Liu on 2025-05-03.
//
import SwiftUI

struct MenuCardsView: View {
    @StateObject private var viewModel: MenuCardsViewModel
    let menuImage: UIImage
    
    init(menuImage: UIImage) {
        self.menuImage = menuImage
        _viewModel = StateObject(wrappedValue: MenuCardsViewModel(menuImage: menuImage))
    }
    
    var body: some View {
        VStack {
            Logo()
            Spacer()
            
            VStack (alignment: .leading, spacing: 15) {
                Text("Menu Items")
                    .font(.titanOne(fontSize: 30))
                    .padding(.leading, 20)
                    .foregroundStyle(Color.forestGreen)
                
                ScrollView {
                    ForEach(0..<viewModel.menuItems.count, id: \.self) { index in
                        let menuItem = viewModel.menuItems[index]
                        MenuCard(dishName: menuItem.name,
                                 price: menuItem.price,
                                 description: menuItem.description)
                    }
                }
                Spacer()
            }
        }
        .onAppear {
            viewModel.recognizeText()
        }
    }

}

struct MenuCard: View {
    var dishName: String
    var price: String?
    var description: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .stroke(.earthGreen, lineWidth: 3)
                .foregroundStyle(Color.white)
                .frame(width: UIScreen.main.bounds.width - 30, height: 120)
                .padding(.horizontal, 20)
            HStack {
                Image(.logo)
                    .resizable()
                    .frame(width: 90, height: 90)
                
                VStack (alignment: .leading){
                    HStack {
                        Text(dishName)
                            .font(.titanOne(fontSize: 18))
                            .foregroundColor(.forestGreen)
                            .padding(.bottom, 1)
                        Text(price ?? "")
                            .font(.lunasimaBold(fontSize: 15))
                            .foregroundColor(.forestGreen)
                    }
                    Text(description)
                        .font(.lunasimaRegular(fontSize: 15))
                        .padding(.trailing, 6)
                }
            }
            .frame(width: UIScreen.main.bounds.width - 40)
        }
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.offMint)
            )
    }
}

#Preview {
    MenuCardsView(menuImage: .french)
}
