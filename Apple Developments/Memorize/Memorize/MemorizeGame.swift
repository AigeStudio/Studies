//
//  MemorizeGame.swift
//  Memorize
//
//  Created by AigeStudio on 11/7/2024.
//

import Foundation

// 这是一个 Model
struct MemoryGame<CardContent> {
    // 将 cards 设置为 private(set) 作为 access control（访问控制）
    private(set) var cards: [Card]
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0 ..< max(2, numberOfPairsOfCards) {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }

    func choose(_ card: Card) {}

    // 将函数以 “mutating” 关键字标记以允许该函数可以修改结构体内的属性（默认情况下结构体内的属性是不可变的）
    mutating func shuffle() {
        cards.shuffle()
    }

    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
}
