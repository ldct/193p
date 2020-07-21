//
//  Concentration.swift
//  Concentration
//
//  Created by Xuanji Li on 21/7/20.
//  Copyright © 2020 Xuanji Li. All rights reserved.
//

import Foundation

class Concentration {
    private(set) var cards = Array<Card>()
    
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
    
    func chooseCard(at index: Int) {
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
    }
    
    // todo: shuffle cards
}
