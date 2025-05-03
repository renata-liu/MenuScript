//
//  CameraModel.swift
//  MenuScript
//
//  Created by Renata Liu on 2025-05-02.
//

import AVFoundation
import SwiftUI
import os.log

final class CameraModel: ObservableObject {
    let camera = Camera()
    
    @Published var viewfinderImage: Image?
    @Published var capturedPhoto: UIImage?
    @Published var showPhotoReview = false
    
    init() {
        Task {
            await handleCameraPreviews()
        }
        
        Task {
            await handleCapturedPhotos()
        }
    }
    
    func handleCameraPreviews() async {
        let imageStream = camera.previewStream
            .map { $0.image }

        for await image in imageStream {
            Task { @MainActor in
                viewfinderImage = image
            }
        }
    }
    
    func handleCapturedPhotos() async {
        let photoStream = camera.photoStream
        
        for await photo in photoStream {
            guard let imageData = photo.fileDataRepresentation() else {
                logger.error("Failed to get image data from capture")
                return
            }
            
            guard let uiImage = UIImage(data: imageData) else {
                logger.error("Failed to create UIImage from image data")
                return
            }
            
            Task { @MainActor in
                capturedPhoto = uiImage
                showPhotoReview = true
            }
        }
    }
}

fileprivate extension CIImage {
    var image: Image? {
        let ciContext = CIContext()
        guard let cgImage = ciContext.createCGImage(self, from: self.extent) else { return nil }
        return Image(decorative: cgImage, scale: 1, orientation: .up)
    }
}

fileprivate extension Image.Orientation {

    init(_ cgImageOrientation: CGImagePropertyOrientation) {
        switch cgImageOrientation {
        case .up: self = .up
        case .upMirrored: self = .upMirrored
        case .down: self = .down
        case .downMirrored: self = .downMirrored
        case .left: self = .left
        case .leftMirrored: self = .leftMirrored
        case .right: self = .right
        case .rightMirrored: self = .rightMirrored
        }
    }
}

fileprivate let logger = Logger(subsystem: "com.apple.swiftplaygroundscontent.capturingphotos", category: "DataModel")
