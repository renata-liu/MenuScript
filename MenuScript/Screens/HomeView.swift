//
//  ContentView.swift
//  MenuScript
//
//  Created by Renata Liu on 2025-05-01.
//

import SwiftUI

struct HomeView: View {
    @Binding var isShowingCameraSheet: Bool
    
    var body: some View {
        VStack {
            Logo()
            SloganText()
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 300, height: 370)
                    .foregroundColor(.offMint)
                    .shadow(color:.earthGreen, radius: 10)
                
                VStack {
                    Image(.camera)
                        .resizable()
                        .frame(width: 200, height: 155)
                        .aspectRatio(contentMode: .fit)
                    Button {
                        isShowingCameraSheet = true
                    } label: {
                        PrimaryMSButton(text: "SCAN MENU")
                    }
                    .padding(.top, 20)
                }
            }
            Spacer()
        }
        .sheet(isPresented: $isShowingCameraSheet) {
            CameraView(isShowingCameraSheet: $isShowingCameraSheet)
        }
    }
}

struct SloganText: View {
    var body: some View {
        VStack (alignment: .leading) {
            Text("Eat globally,")
                .foregroundColor(.mainBlue)
            Text("Understand locally.")
                .foregroundColor(.earthGreen)
        }
        .font(.titanOne(fontSize: 30))
        .padding([.top, .bottom], 50)
        .offset(y: -10)
    }
}

#Preview {
    HomeView(isShowingCameraSheet: .constant(false))
}
