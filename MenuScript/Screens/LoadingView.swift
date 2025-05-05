//
//  LoadingView.swift
//  MenuScript
//
//  Created by Renata Liu on 2025-05-04.
//

import SwiftUI

struct LoadingView: View {
    let image: UIImage
    let captionText: String
    let mainText: String
    
    var body: some View {
        VStack {
            Logo()
            Spacer()
            VStack {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
                VStack {
                    Text(captionText)
                        .font(.lunasimaBold(fontSize: 16))
                        .foregroundColor(.earthGreen)
                    Text(mainText)
                        .font(.titanOne(fontSize: 24))
                        .foregroundColor(.forestGreen)
                }
                .offset(y: -30)
            }
            .offset(y: -40)
            Spacer()
        }
    }
}

#Preview {
    LoadingView(image: .plainLogo,
                captionText: "decoding your menu...",
                mainText: "from foreign to familiar")
}
