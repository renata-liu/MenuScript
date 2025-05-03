//
//  TabView.swift
//  MenuScript
//
//  Created by Renata Liu on 2025-05-01.
//

import SwiftUI

struct MenuScriptTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab){
            HomeView(selectedTab: $selectedTab)
                .tabItem { Label("Home", systemImage: "house") }
                .tag(0)
            
            CameraView(selectedTab: $selectedTab)
                .tabItem { Label("Scan", systemImage: "camera") }
                .tag(1)
            
            ProfileView()
                .tabItem { Label("Account", systemImage: "person") }
                .tag(2)
        }
        .accentColor(.mainBlue)
    }
}

#Preview {
    MenuScriptTabView()
}
