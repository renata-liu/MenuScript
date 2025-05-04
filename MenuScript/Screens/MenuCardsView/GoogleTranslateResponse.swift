struct GoogleTranslateResponse: Codable {
        struct Data: Codable {
            struct Translation: Codable {
                let translatedText: String
            }
            let translations: [Translation]
        }
        let data: Data
    }