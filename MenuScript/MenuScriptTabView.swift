//
//  TabView.swift
//  MenuScript
//
//  Created by Renata Liu on 2025-05-01.
//

import SwiftUI

struct MenuScriptTabView: View {
    @State var isShowingCameraSheet: Bool = false
    
    var body: some View {
        TabView(){
            HomeView(isShowingCameraSheet: $isShowingCameraSheet)
                .tabItem { Label("Home", systemImage: "house") }
            
//            CameraView(isShowingCameraSheet: $isShowingCameraSheet)
//                .tabItem { Label("Scan", systemImage: "camera") }
            
            ProfileView()
                .tabItem { Label("Account", systemImage: "person") }
        }
        .accentColor(.mainBlue)
    }
}

#Preview {
    MenuScriptTabView()
}
