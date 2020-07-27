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
    
    private var emoji = Dictionary<Int, String>()

    private let themes = [
        ["🎃", "😈", "☠", "🤡", "😱", "👻", "🦇", "🦉"],
        ["🇯🇵", "🇰🇷", "🇩🇪", "🇨🇳", "🇺🇸", "🇫🇷", "🇪🇸", "🇮🇹", "🇷🇺", "🇬🇧"]
    ]
    
    private var emojiChoices : [String];
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for i in cards.indices {
                if cards[i].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = i
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
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
                if cards[matchIndex].identifier == cards[index].identifier {
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
        reset()
    }
    
    // todo: shuffle cards
}
