//
//  SwiftUI+Font.swift
//  MenuScript
//
//  Created by Renata Liu on 2025-05-01.
//
import SwiftUI

extension Font {
    static func titanOne(fontSize: CGFloat = 16) -> Font {
        return Font.custom("TitanOne", size: fontSize)
    }
    
    static func lunasimaRegular(fontSize: CGFloat = 16) -> Font {
        return Font.custom("Lunasima-Regular", size: fontSize)
    }
    
    static func lunasimaBold(fontSize: CGFloat = 16) -> Font {
        return Font.custom("Lunasima-Bold", size: fontSize)
    }
}
