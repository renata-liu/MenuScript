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
    @State private var translatedText = ""
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
            
            ScrollView {
                Text(translatedText)
            }
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
                translateText(recognizedText) { result in
                    DispatchQueue.main.async {
                        translatedText = result ?? "Error when translating text"
                    }
                }
            }
        }
        
        request.recognitionLevel = .accurate
        
        do {
            try requestHandler.perform([request])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    private func translateText(_ text: String, to targetLanguage: String = "en", completion: @escaping (String?) -> Void) {
        guard let apiKey = ProcessInfo.processInfo.environment["GOOGLE_TRANSLATE_API_KEY"] else {
            print("Missing API key")
            completion(nil)
            return
        }

        let url = URL(string: "https://translation.googleapis.com/language/translate/v2?key=\(apiKey)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody: [String: Any] = [
            "q": text,
            "target": targetLanguage,
            "format": "text"
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print("Translation API error:", error ?? "")
                completion(nil)
                return
            }

            if let result = try? JSONDecoder().decode(GoogleTranslateResponse.self, from: data),
               let translatedText = result.data.translations.first?.translatedText {
                completion(translatedText)
            } else {
                completion(nil)
            }
        }.resume()
    }

    struct GoogleTranslateResponse: Codable {
        struct Data: Codable {
            struct Translation: Codable {
                let translatedText: String
            }
            let translations: [Translation]
        }
        let data: Data
    }

}

#Preview {
    MenuCardsView(menuImage: .french)
}
