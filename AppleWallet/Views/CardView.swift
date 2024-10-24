//
//  CardView.swift
//  WordyCards
//
//  Created by Sebastian on 25/09/24.
//

import SwiftUI

struct CardView: View {
    
    var card: CardModel
    
    
    var body: some View {
        VStack{
            Text(card.name).typography(.bold, 30, .white).transition(.blurReplace)
        }
        .frame(maxWidth: UIScreen.main.bounds.width - 100, maxHeight: 230)
        .background(card.color)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        
        
    }
}

#Preview {
    CardView(
        card: CardModel(
            image: nil,
            name: "attach",
            number: 123412341234,
            color: .accentColor)
    )
}
