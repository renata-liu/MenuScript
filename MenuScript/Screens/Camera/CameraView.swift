//
//  CameraView.swift
//  MenuScript
//
//  Created by Renata Liu on 2025-05-02.
//
import SwiftUI

struct CameraView: View {
    @StateObject private var model = CameraModel()
    @Binding var selectedTab: Int
 
    private static let barHeightFactor = 0.15
    
    var body: some View {
        
        NavigationStack {
            GeometryReader { geometry in
                ViewfinderView(image:  $model.viewfinderImage )
                    .overlay(alignment: .top) {
                        dismissView()
                    }
                    .overlay(alignment: .center)  {
                        Color.clear
                            .frame(height: geometry.size.height * (1 - (Self.barHeightFactor * 2)))
                            .accessibilityElement()
                            .accessibilityLabel("View Finder")
                            .accessibilityAddTraits([.isImage])
                    }
                    .background(.black)
                    .overlay(alignment: .bottom) {
                        buttonsView()
                    }
            }
            .task {
                await model.camera.start()
            }
            .navigationTitle("Camera")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .ignoresSafeArea()
            .statusBar(hidden: true)
            .fullScreenCover(isPresented: $model.showPhotoReview, content: {
                            if let photo = model.capturedPhoto {
                                PhotoPreviewView(photo: photo)
                            }
                        })
        }
    }
    
    private func dismissView() -> some View {
        Button {
            selectedTab = 0
            print("Tapped exit camera")
        } label: {
            HStack {
                Image(systemName: "x.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding(30)
        }
    }
    
    private func buttonsView() -> some View {
        HStack {
            
            Spacer()
            
            Button {
                model.camera.takePhoto()
            } label: {
                Label {
                    Text("Take Photo")
                } icon: {
                    ZStack {
                        Circle()
                            .strokeBorder(.white, lineWidth: 3)
                            .frame(width: 62, height: 62)
                        Circle()
                            .fill(.white)
                            .frame(width: 50, height: 50)
                    }
                }
            }
            
            Spacer()
        }
        .buttonStyle(.plain)
        .labelStyle(.iconOnly)
        .padding(.bottom, 80)
    }
}

#Preview {
    CameraView(selectedTab: .constant(1))
}
