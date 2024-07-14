//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by AigeStudio on 11/7/2024.
//

import SwiftUI

func createCardContent(forPairAtIndex index: Int) -> String {
    return ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧑‍🌾", "🙀", "🦁", "💩", "👺", "👾", "🤡", "🧠", "🧶"][index]
}

// 这是一个 ViewModel
// 类继承自 ObservableObject 表示该类是一个可以被观察的协议类
// ObservableObject 通常搭配 @Published、 @ObservedObject 以及 @StateObject 一起使用。其中， @Published 用于标记 ObservableObject 类中需要被观察的属性，比如这里的 model：
//
// @Published private var model: MemoryGame<String> = createMemoryGame()
//
// 在使用 EmojiMemoryGame 的地方，通过 @ObservedObject 注入实例，在生成 EmojiMemoryGame 的地方使用 @StateObject 创建并初始化实例，比如我们在 App 结构体中执行创建并注入给 View：
//
// struct MemorizeApp: App {
//    @StateObject var game = EmojiMemoryGame()
//    var body: some Scene {
//        WindowGroup {
//            EmojiMemoryGameView(viewModel: game)
//        }
//    }
// }
//
// 在 View 中通过 @ObservedObject 获取对象：
//
// struct EmojiMemoryGameView: View {
//    @ObservedObject var viewModel: EmojiMemoryGame
// }
//
// 每当 model 改变时， @ObservedObject 标记的 viewModel 都会是最新的一个 EmojiMemoryGame 实例并触发 View 重新绘制。
// 因为 EmojiMemoryGame 是一个结构体，所以即使是 EmojiMemoryGame 内部的属性改变也会触发变化通知。
class EmojiMemoryGame: ObservableObject {
    // 将 model 设置为 private 作为 access control（访问控制）
    // private var model: MemoryGame<String> = MemoryGame(numberOfPairsOfCards: 4, cardContentFactory: createCardContent)
    // 可以将函数 createCardContent 作为 closure syntax（闭包表达式）的形式直接写在参数的位置：
    /*
      // 第一步：将 createCardContent 函数从 “(” 开始整个函数体拷贝替换至 “createCardContent” 参数的位置：
      private var model: MemoryGame<String> = MemoryGame(numberOfPairsOfCards: 4, cardContentFactory: (forPairAtIndex index: Int) -> String {
          return ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧑‍🌾", "🙀", "🦁", "💩", "👺", "👾", "🤡", "🧠", "🧶"][index]
      })
      // 第二步：将 “{” 前置在 “(” 前面
      private var model: MemoryGame<String> = MemoryGame(numberOfPairsOfCards: 4, cardContentFactory: { (forPairAtIndex index: Int) -> String
          return ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧑‍🌾", "🙀", "🦁", "💩", "👺", "👾", "🤡", "🧠", "🧶"][index]
      })
      // 最后一步：去掉外部参数名，在 String 后加 “in” 关键字，并省略掉 “return” 关键字
     */
//    private var model: MemoryGame<String> = MemoryGame(numberOfPairsOfCards: 4, cardContentFactory: { (index: Int) -> String in
//        ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧑‍🌾", "🙀", "🦁", "💩", "👺", "👾", "🤡", "🧠", "🧶"][index]
//    })
    // 进一步优化简洁：
    // 1. 因为返回值可以被推断，因此返回值 String 以及其表达式可以被省略：
//    private var model: MemoryGame<String> = MemoryGame(numberOfPairsOfCards: 4, cardContentFactory: { (index: Int) in
//        ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧑‍🌾", "🙀", "🦁", "💩", "👺", "👾", "🤡", "🧠", "🧶"][index]
//    })
    // 2. 省略输入参数类型：
//    private var model: MemoryGame<String> = MemoryGame(numberOfPairsOfCards: 4, cardContentFactory: { (index) in
//        ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧑‍🌾", "🙀", "🦁", "💩", "👺", "👾", "🤡", "🧠", "🧶"][index]
//    })
    // 3. 省略输入参数括号
//    private var model: MemoryGame<String> = MemoryGame(numberOfPairsOfCards: 4, cardContentFactory: { index in
//        ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧑‍🌾", "🙀", "🦁", "💩", "👺", "👾", "🤡", "🧠", "🧶"][index]
//    })
    // 4. 当闭包表达式为最后一个参数时可以将其外置（和 Kotlin 一样）
//    private var model: MemoryGame<String> = MemoryGame(numberOfPairsOfCards: 4) { index in
//        ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧑‍🌾", "🙀", "🦁", "💩", "👺", "👾", "🤡", "🧠", "🧶"][index]
//    }
    // 5. 在不声明输入参数名的情况下，参数名默认为 “$0, $1 ...... $n”，此时可以直接省略输入参数的声明直接使用 $0
//    private var model: MemoryGame<String> = MemoryGame(numberOfPairsOfCards: 4) {
//        ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧑‍🌾", "🙀", "🦁", "💩", "👺", "👾", "🤡", "🧠", "🧶"][$0]
//    }
    // 6. 大部分情况下为了代码的可读性，我们还是会为闭包表达式的输入参数指定一个可读性强的名称：
//    private var model: MemoryGame<String> = MemoryGame(numberOfPairsOfCards: 4) { pairIndex in
//        ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧑‍🌾", "🙀", "🦁", "💩", "👺", "👾", "🤡", "🧠", "🧶"][pairIndex]
//    }
    private static let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧑‍🌾", "🙀", "🦁", "💩", "👺", "👾", "🤡", "🧠", "🧶"]
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 2) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                // 静态成员的调用可以指明类名也可以省略
                EmojiMemoryGame.emojis[pairIndex]
            } else {
                "⁉️"
            }
        }
    }

    typealias Card = MemoryGame<String>.Card

    @Published private var model: MemoryGame<String> = createMemoryGame() // 省略类名调用静态函数

    var cards: [Card] {
        return model.cards
    }

    var color: Color {
        return .orange
    }

    // MARK: - Intents

    func shuffle() {
        model.shuffle()
    }

    func choose(_ card: Card) {
        model.choose(card)
    }
}
