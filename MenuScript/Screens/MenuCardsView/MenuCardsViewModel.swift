//
//  Untitled.swift
//  MenuScript
//
//  Created by Renata Liu on 2025-05-03.
//
import SwiftUI
import Vision

final class MenuCardsViewModel: ObservableObject {
    @Published var recognizedText = ""
    @Published var translatedText = ""
    @Published var menuItems: [MenuItem] = []
    @Published var dishImage: String?
    let menuImage: UIImage
    
    init(menuImage: UIImage) {
        self.menuImage = menuImage
    }
    
    func recognizeText() {
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
                self.recognizedText = recognizedStrings.joined(separator: "\n")
                self.translateText(self.recognizedText) { result in
                    DispatchQueue.main.async {
                        self.translatedText = result ?? "Error when translating text"
                        
                        print("Translated Text:", self.translatedText)
                        self.extractMenuItems(translatedText: self.translatedText, originalText: self.recognizedText) { items in
                            DispatchQueue.main.async {
                                self.menuItems = items ?? []
                                
                                for index in self.menuItems.indices {
                                        let dishName = self.menuItems[index].name
                                        self.getImage(dishName) { imageURL in
                                            DispatchQueue.main.async {
                                                self.menuItems[index].imageURL = imageURL
                                                print(self.menuItems)
                                            }
                                        }
                                    }
                            }
                        }
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
            print("Missing Google Translate API key")
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
    
    
    private func extractMenuItems(translatedText: String, originalText: String, completion: @escaping ([MenuItem]?) -> Void) {
        guard let apiKey = ProcessInfo.processInfo.environment["OPENAI_API_KEY"] else {
            print("Missing OpenAI API key")
            completion(nil)
            return
        }
        
        let prompt = """
        Extract a structured menu from the text below that was scraped from a menu using OCR. Return a JSON array where each menu item has:
        - "name": dish name in english. Return the name in regular letter capitalization.
        - "originalName": dish name in the original menu's language. Use the original menu text provided below to match the english translation of the dish to the name listed on the menu.
        - "description": short description. If no description is provided in the menu text, generate a short, approximately 20 word description of the dish. If a description is provided but the descriptions exceeds 30 words, shorten it to around 20 words. 
        - "price": price of the dish if it is provided in the menu text. otherwise, fill this value with an empty string.

        Return ONLY JSON.

        Translated menu text:
        \(translatedText)
        
        Original menu text:
        \(originalText)
        """
        
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let requestBody: [String: Any] = [
            "model": "gpt-4.1-mini",
            "messages": [
                ["role": "system", "content": "You are a helpful assistant that parses menu text into structured JSON."],
                ["role": "user", "content": prompt]
            ],
            "temperature": 0.2
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch {
            print("Error encoding request body: \(error)")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error from OpenAI API:", error ?? "Unknown error")
                completion(nil)
                return
            }

            do {
                let decoded = try JSONDecoder().decode(OpenAIResponse.self, from: data)
                let jsonText = decoded.choices.first?.message.content ?? ""

                let itemsData = Data(jsonText.utf8)
                let items = try JSONDecoder().decode([MenuItem].self, from: itemsData)

                DispatchQueue.main.async {
                    completion(items)
                }
            } catch {
                print("Error decoding JSON from GPT response:", error)
                completion(nil)
            }
        }.resume()
    }
    
    private func getImage(_ dishName: String, completion: @escaping (String?) -> Void) {
        guard let apiKey = ProcessInfo.processInfo.environment["IMAGE_SEARCH_API_KEY"] else {
            print("Missing OpenSearch API key")
            completion(nil)
            return
        }
        
        guard let engineID = ProcessInfo.processInfo.environment["IMAGE_SEARCH_ENGINE_ID"] else {
            print("Missing Google Search Engine ID")
            completion(nil)
            return
        }

        let encodedQuery = dishName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? dishName
        let urlString = "https://www.googleapis.com/customsearch/v1?key=\(apiKey)&cx=\(engineID)&q=\(encodedQuery)&searchType=image&num=1"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print("OpenSearch API error:", error ?? "")
                completion(nil)
                return
            }

            do {
                let decoded = try JSONDecoder().decode(GoogleImageSearchResponse.self, from: data)
                let imageUrl = decoded.items.first?.link
                completion(imageUrl)
            } catch {
                print("Error decoding image search response:", error)
                completion(nil)
            }
        }.resume()
        
        struct GoogleImageSearchResponse: Codable {
            struct Item: Codable {
                let link: String
            }

            let items: [Item]
        }
    }
}
