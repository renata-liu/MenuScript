//
//  PhotoPreviewView.swift
//  MenuScript
//
//  Created by Renata Liu on 2025-05-02.
//

import SwiftUI

struct PhotoPreviewView: View {
    let photo: UIImage
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.offMint.ignoresSafeArea()
            
            VStack {
                Logo()
                Spacer()
                Image(uiImage: photo)
                    .resizable()
                    .scaledToFit()
                    .accessibilityLabel("Captured photo")
                    .offset(y: -30)
                
                HStack (spacing: 20){
                    Button {
                        dismiss()
                    } label: {
                        SecondaryMSButton(text: "RETAKE")
                    }
                    
                    Button {
                        print("Process menu")
                    } label: {
                        PrimaryMSButton(text: "PROCESS")
                    }
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    PhotoPreviewView(photo: UIImage(resource: .flowers))
}
