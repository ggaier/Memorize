//
//  MemorizeGameModel.swift
//  Memorize
//
//  Created by momo on 2021/2/25.
//

import Foundation

struct MemorizeGameModel<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private var choosedOnlyCardIndex: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp == true }.only
        }
        set {
            for i in 0..<cards.count {
                cards[i].isFaceUp = newValue == i
            }
        }
    }

    init(numberOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for i in 0..<numberOfCards {
            cards.append(Card(id: i * 2, content: cardContentFactory(i)))
            cards.append(Card(id: i * 2 + 1, content: cardContentFactory(i)))
        }
    }

    mutating func chooseCard(card: Card) {
        print("choose card \(card)")
        if let newIndex = cards.firstIndex(of: card), !cards[newIndex].isFaceUp, !cards[newIndex].isMatched {
            if let choosenIndex = choosedOnlyCardIndex {
                if cards[choosenIndex].content == cards[newIndex].content {
                    cards[choosenIndex].isMatched = true
                    cards[newIndex].isMatched = true
                }
                cards[newIndex].isFaceUp = true
            } else if choosedOnlyCardIndex == nil {
                choosedOnlyCardIndex = newIndex
            }
        }
    }

    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
