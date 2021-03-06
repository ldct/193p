//
//  Card.swift
//  Concentration
//
//  Created by Xuanji Li on 21/7/20.
//  Copyright © 2020 Xuanji Li. All rights reserved.
//

import Foundation

struct Card : Equatable & Hashable {
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: Card, rhs: Card)
    -> Bool {
        return (lhs.identifier == rhs.identifier)
    }
    
    private static var identifierFactory = 0
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    mutating func reset() {
        isFaceUp = false
        isMatched = false
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
