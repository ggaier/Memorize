//
//  MemorizeGameModel.swift
//  Memorize
//
//  Created by momo on 2021/2/25.
//

import Foundation

struct MemorizeGameModel<CardContent> {
    var cards: Array<Card>

    init(numberOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for i in 0..<numberOfCards {
            cards.append(Card(id: i * 2, content: cardContentFactory(i)))
            cards.append(Card(id: i * 2 + 1, content: cardContentFactory(i)))
        }
    }

    mutating func chooseCard(card: Card) {
        print("choose card \(card)")
        let choosenIndex = index(of: card)
        cards[choosenIndex].isFaceUp = !card.isFaceUp
    }

    private func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        //TODO: bogus
        return 0
    }

    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
    }
}
