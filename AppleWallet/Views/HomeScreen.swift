//
//  HomeScreen.swift
//  AppleWallet
//
//  Created by Sebastian Narvaez on 19/10/24.
//

import SwiftUI

let cardsData : [CardModel] = [
    CardModel(name: "Sebastian Narvaez", number: 1231231233123, color: .accent),
    CardModel(name: "Ana Sierra", number: 1231231233123, color: .warning),
    CardModel(name: "Carlos Gonzalez", number: 1231231233123, color: .success),
    CardModel(name: "Elene Rodriguez", number: 1231231233123, color: .danger),
]

struct HomeScreen: View {
    
    @State var cards: [CardModel] = cardsData
    var cardOffset: CGFloat = 60
    @GestureState var dragState: DragState = .inactive
    
    var body: some View {
        VStack{
            ZStack{
                ForEach(Array(cards.enumerated()), id: \.element.id){ index, card in
                    
                    CardView(card: card)
                        .offset(x: getXOffset(index:index), y: getYOffset(index: index))
                        .shadow(radius: 10, x: 0, y: -2)
                        .zIndex(getZIndex(index: index))
                        .animation(.bouncy, value: dragState.translation)
                        .gesture(LongPressGesture(minimumDuration: 0.02)
                            .sequenced(before: DragGesture())
                            .updating(self.$dragState, body: { value, state, transaction in
                                
                                switch value {
                                case .first(false):
                                    state = .pressing(index: index)
                                case .second(true, let drag):
                                    state = .dragging(index: index, translation: drag?.translation ?? .zero)
                                default:
                                    break
                                }
                                
                            }).onEnded({value in
                                guard case .second(true, let drag) = value else { return }
                                
                                withAnimation{
                                    self.reorderCards(index: index, yOffset: drag?.translation.height ?? .zero)
                                }
                            }))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.backgroundPrimary)
    }
    
    private func getZIndex(index: Int) -> Double {
        return dragState.index == index ?
        -Double(index) + (dragState.translation.height/cardOffset ) : -Double(index)
    }
    
    private func getYOffset(index: Int) -> CGFloat {
        let yOffset: CGFloat =
        self.dragState.isDragging && self.dragState.index == index
        ? (dragState.translation.height + CGFloat(index) * -cardOffset)
        : -CGFloat(index) * cardOffset
        
        return yOffset
    }
    
    private func getXOffset(index: Int) -> CGFloat {
        let xOffset: CGFloat =
        self.dragState.isDragging && self.dragState.index == index
        ? dragState.translation.width
        : 0
        
        return xOffset
    }
    
    private func reorderCards(index: Int, yOffset: CGFloat ) -> Void {
        var newCardIndex = index + Int(-yOffset/cardOffset)
        newCardIndex = newCardIndex >= cards.count ? cards.count - 1 : newCardIndex
        newCardIndex = newCardIndex < 0 ? 0 : newCardIndex
        
        let removedCard = cards.remove(at: index)
        cards.insert(removedCard, at: newCardIndex)
    }
}

#Preview {
    HomeScreen()
}
