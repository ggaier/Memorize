//
//  MemorizeGameViewModel.swift
//  Memorize
//
//  Created by momo on 2021/2/25.
//

import Foundation

class MemorizeViewModel : ObservableObject{

    @Published
    private var model: MemorizeGameModel = createMemorizeGameModel()

    static func createMemorizeGameModel() -> MemorizeGameModel<String> {
        return MemorizeGameModel<String>(numberOfCards: 3) { index in
            let cards = ["👻", "😈", "🎃"]
            return cards[index]
        }
    }

    var cards: Array<MemorizeGameModel<String>.Card> {
        model.cards
    }

    func choose(card: MemorizeGameModel<String>.Card) {
        model.chooseCard(card: card)
    }
    
    func resetGame(){
        model = MemorizeViewModel.createMemorizeGameModel()
    }
}
