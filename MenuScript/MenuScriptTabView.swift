//
//  TabView.swift
//  MenuScript
//
//  Created by Renata Liu on 2025-05-01.
//

import SwiftUI

struct MenuScriptTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house") }
            
            CameraView()
                .tabItem { Label("Scan", systemImage: "camera") }
            
            ProfileView()
                .tabItem { Label("Account", systemImage: "person") }
        }
        .accentColor(.mainBlue)
    }
}

#Preview {
    MenuScriptTabView()
}
