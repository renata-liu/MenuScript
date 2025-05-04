//
//  MenuCardsView.swift
//  MenuScript
//
//  Created by Renata Liu on 2025-05-02.
//
import SwiftUI
import Vision

struct MenuCardsViewTemp: View {
    @StateObject private var viewModel: MenuCardsViewModel
    let menuImage: UIImage
    
    init(menuImage: UIImage) {
        self.menuImage = menuImage
        _viewModel = StateObject(wrappedValue: MenuCardsViewModel(menuImage: menuImage))
    }
    
    var body: some View {
        VStack {
            Text("Testing OCR")
                .font(.title)
            Image(uiImage: menuImage)
                .resizable()
                .scaledToFit()
            
            
            Button("Scrape Text"){
                viewModel.recognizeText()
            }
            
            ScrollView {
                Text(viewModel.translatedText)
            }
        }
        .padding()
    }

}

#Preview {
    MenuCardsViewTemp(menuImage: .french)
}
