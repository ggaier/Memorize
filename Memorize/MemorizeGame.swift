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
        cards.shuffle()
    }

    mutating func chooseCard(card: Card) {
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
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content: CardContent


        var bonusTimeLimit: TimeInterval = 6
        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0

        private var faceupTime: TimeInterval {
            if let lastFaceUpDate = lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }

        var bonusTimeRemaining: TimeInterval {
            return max(0, bonusTimeLimit - faceupTime)
        }

        var bonusRemaining: Double {
            return (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }

        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }

        var isConsumingBonusTime: Bool {
            return isFaceUp && !isMatched && bonusTimeRemaining > 0
        }

        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }

        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceupTime
            lastFaceUpDate = nil
        }
    }
}
