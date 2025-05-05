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
    let originalName: String
    let price: String?
    let description: String
}

struct OpenAIResponse: Codable {
    struct Choice: Codable {
        struct Message: Codable {
            let content: String
        }
        let message: Message
    }
    let choices: [Choice]
}

struct MockData {
    static let sampleMenuItem = MenuItem(
        name: "Spaghetti Carbonara",
        originalName: "Spaghetti Carbonara",
        price: "$12.99",
        description: "Spaghetti with pancetta, eggs, cheese, and black pepper."
    )
    
    static let sampleMenuItem1 = MenuItem(
        name: "Goat Cheese Galette",
        originalName: "Galette de fromage de chèvre",
        price: "€11",
        description: "Goat cheese galette with spinach and prosciutto, topped with a cream and brandy sauce."
    )
    
    static let sampleMenuItem2 = MenuItem(
        name: "Shrimp With Boursin Sauce",
        originalName: "Escargots de Bourgogne",
        price: "€11",
        description: "Shrimp sautéed with tomatoes, corn, and leeks in a garlic and herb sauce."
    )
    
    static let sampleMenuItem3 = MenuItem(
        name: "Button Mushrooms with 4 Cheeses",
        originalName: "Champignons en Croute avec 4 fromages",
        price: "€12",
        description: "Grilled mushrooms stuffed with Gruyère, Brie, and Pont-l'Évêque, served in a herb sauce."
    )
    
    static let sampleMenuItem4 = MenuItem(
        name: "Mushes Marinière In Cream",
        originalName: "Muscelli Marinari en Crema",
        price: "€10",
        description: "Garlic mussels, with or without cream, cooked in a wine sauce."
    )
    
    static let sampleMenuItem5 = MenuItem(
        name: "Burgundy Escargots",
        originalName: "Escargots de Bourgogne",
        price: "€15.50",
        description: "Snails prepared in a butter and garlic purée."
    )
    
    static let sampleMenuItem6 = MenuItem(
        name: "Smoked Salmon",
        originalName: "Saumon fumé",
        price: "$13.50",
        description: "Pan-fried salmon served with garden vegetables, capers, and shallots."
    )
    
    static let menuItems = [sampleMenuItem1, sampleMenuItem2, sampleMenuItem3, sampleMenuItem4, sampleMenuItem5, sampleMenuItem6]
}
