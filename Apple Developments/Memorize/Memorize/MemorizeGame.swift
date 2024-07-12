//
//  MemorizeGame.swift
//  Memorize
//
//  Created by AigeStudio on 11/7/2024.
//

import Foundation

// 这是一个 Model
struct MemoryGame<CardContent> where CardContent: Equatable {
    // 将 cards 设置为 private(set) 作为 access control（访问控制）
    private(set) var cards: [Card]
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0 ..< max(2, numberOfPairsOfCards) {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }

    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = newValue == $0 }}
    }

    mutating func choose(_ card: Card) {
        // 注意这里的语法：函数作为参数
//        if let chosenIndex = index(of: card) {
//            cards[chosenIndex].isFaceUp.toggle()
//        }
        // chosenIndex 为点击选择的那个 Card 的 Index
        // 这个鬼畜语法也是有点东西，刚开始爹以为这个 chosenIndex 也是个 computed property，百思不得其解这个变量在后续的函数体外并没有使用。
        // 在爹的深度学习后得知这种语法称之为 optional binding（可选绑定），主要用于安全地进行 unwrap（解包）一个 optional value（可选值），其具体语法如下：
        // if let/var 变量名 = 可选值表达式 { 代码块 }
        // 比如下面的示例会先计算 “cards.firstIndex(where: { $0.id == card.id })”，当值不为 nil 时会进一步执行 “{}” 中的代码
        // 这语法鬼畜的点就在于可以在后续的 “代码块” 中使用这个 “变量”，这在其他的一些编译型语言中还不多见。
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            // 找到点击卡片的索引才会执行到这里
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                // 点击的卡片不是翻开的并且没有被匹配才到这里
                // 下面这段注意了，又是个鬼畜语法，
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }

//    private func index(of card: Card) -> Int? {
//        for index in cards.indices {
//            if cards[index].id == card.id {
//                return index
//            }
//        }
//        return nil
//    }

    // 将函数以 “mutating” 关键字标记以允许该函数可以修改结构体内的属性（默认情况下结构体内的属性是不可变的）
    mutating func shuffle() {
        cards.shuffle()
    }

    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        var id: String
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
