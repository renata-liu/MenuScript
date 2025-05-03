//
//  Logo.swift
//  MenuScript
//
//  Created by Renata Liu on 2025-05-02.
//

import SwiftUI

struct Logo: View {
    var body: some View {
        Image("logo")
            .resizable()
            .frame(width: 80, height: 80)
    }
}

#Preview {
    Logo()
}
