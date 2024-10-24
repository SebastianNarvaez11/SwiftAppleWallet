//
//  CardModel.swift
//  AppleWallet
//
//  Created by Sebastian on 8/10/24.
//

import Foundation
import SwiftUI


let colors: [Color] = [.accentColor, .success, .danger, .warning]


struct CardModel: Identifiable {
    let id = UUID()
    let image: URL?
    let name: String
    let number: Int
    let color: Color
    
    init(image: URL? = nil, name: String, number: Int, color: Color) {
        self.image = image
        self.name = name
        self.number = number
        self.color = color
    }
}

