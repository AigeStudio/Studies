//
//  MemorizeGame.swift
//  Memorize
//
//  Created by AigeStudio on 11/7/2024.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: [Card]
    func choose(card: Card) {}

    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
