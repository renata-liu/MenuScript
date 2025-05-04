//
//  GoogleTranslateResponse.swift
//  MenuScript
//
//  Created by Renata Liu on 2025-05-03.
//
import Foundation

struct GoogleTranslateResponse: Codable {
    struct Data: Codable {
        struct Translation: Codable {
            let translatedText: String
        }
        let translations: [Translation]
    }
    let data: Data
}

struct MenuItem: Codable {
    let name: String
    let price: String?
    let description: String
}
