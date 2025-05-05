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
        ZStack {
            VStack {
                Logo()
                Spacer()
                
                VStack (alignment: .leading, spacing: 15) {
                    Text("Menu Items")
                        .font(.titanOne(fontSize: 30))
                        .padding(.leading, 20)
                        .foregroundStyle(Color.forestGreen)
                    
                    ScrollView {
//                        ForEach(0..<viewModel.menuItems.count, id: \.self) { index in
//                            let menuItem = viewModel.menuItems[index]
//                            MenuCard(dishName: menuItem.name,
//                                     originalName: menuItem.originalName,
//                                     price: menuItem.price,
//                                     description: menuItem.description)
//                        }
                        
                        ForEach(0..<MockData.menuItems.count, id: \.self) { index in
                            let menuItem = MockData.menuItems[index]
                            MenuCard(dishName: menuItem.name,
                                     originalName: menuItem.originalName,
                                     price: menuItem.price,
                                     description: menuItem.description)
                        }
                    }
                    Spacer()
                }
            }
            .onAppear {
//                viewModel.recognizeText()
            }
//            .opacity(viewModel.menuItems.isEmpty ? 0 : 1)
            
//            LoadingView(image: .plainLogo,
//                        captionText: "decoding your menu...",
//                        mainText: "from foreign to familiar")
//            .opacity(viewModel.menuItems.isEmpty ? 1 : 0)
        }
    }

}

#Preview {
    MenuCardsView(menuImage: .french)
}
