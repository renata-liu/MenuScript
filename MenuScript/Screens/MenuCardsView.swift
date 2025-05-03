//
//  MenuCardsView.swift
//  MenuScript
//
//  Created by Renata Liu on 2025-05-02.
//

import SwiftUI
import Vision

struct MenuCardsView: View {
    
    @State private var recognizedText = ""
    let menuImage: UIImage
    
    var body: some View {
        VStack {
            Text("Testing OCR")
                .font(.title)
            Image(uiImage: menuImage)
                .resizable()
                .scaledToFit()
            
            
            Button("Scrape Text"){
                recognizeText()
            }
            
            TextEditor(text: $recognizedText)
        }
        .padding()
    }
    
    private func recognizeText() {
        guard let cgImage = menuImage.cgImage else { return }
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        let request = VNRecognizeTextRequest { request, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "Error occurred when parsing image text")
                return
            }
            guard let observations =
                    request.results as? [VNRecognizedTextObservation] else {
                return
            }
            let recognizedStrings = observations.compactMap { observation in
                return observation.topCandidates(1).first?.string
            }
            
            DispatchQueue.main.async {
                recognizedText = recognizedStrings.joined(separator: "\n")
            }
        }
        
        request.recognitionLevel = .accurate
        
        do {
            try requestHandler.perform([request])
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    MenuCardsView(menuImage: .test)
}
