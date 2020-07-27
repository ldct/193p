//
//  Concentration.swift
//  Concentration
//
//  Created by Xuanji Li on 21/7/20.
//  Copyright © 2020 Xuanji Li. All rights reserved.
//

import Foundation

class Concentration {
    private(set) var flipCount = 0
    private(set) var cards = Array<Card>()
    
    private var emoji = Dictionary<Card, String>()


    
    private let themes = [
        "🎃😈☠🤡😱👻🦇🦉",
        "🇯🇵🇰🇷🇩🇪🇨🇳🇺🇸🇫🇷🇪🇸🇮🇹🇷🇺🇬🇧"
    ]
    
    private var emojiChoices : String;
    
    func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        } set {
            for i in cards.indices {
                cards[i].isFaceUp = (i == newValue)
            }
        }
    }
    
    func reset() {
        emojiChoices = themes.randomElement()!
        emoji.removeAll()
        flipCount = 0
        cards.shuffle()
        for i in cards.indices {
            cards[i].reset()
        }
    }
    
    func chooseCard(at index: Int) {
        flipCount += 1
        assert(cards.indices.contains(index), "chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "must have at least 1 pair of cards")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        flipCount = 0
        emojiChoices = themes.randomElement()!
        emoji.removeAll()
        reset()
    }
    
    // todo: shuffle cards
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
