//
//  CardView.swift
//  Memorize
//
//  Created by AigeStudio on 19/7/2024.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    let card: Card
    init(_ card: Card) {
        self.card = card
    }

    var body: some View {
//        ZStack(content: {
//            let base = RoundedRectangle(cornerRadius: 12)
//            Group {
//                base.fill(.white)
//                base.strokeBorder(StrokeStyle(lineWidth: 2))
//                Text(card.content).font(.largeTitle)
//            }
//            .opacity(card.isFaceUp ? 1 : 0)
//            base.fill().opacity(card.isFaceUp ? 0 : 1)
//        })
        Pie(endAngle: .degrees(240))
            .opacity(Constants.Pie.opacity)
            .overlay {
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.Pie.inset)
            }
            .padding(Constants.inset)
            .cardify(isFaceUp: card.isFaceUp)
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }

    private enum Constants {
        static let cornetRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        enum FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }

        enum Pie {
            static let inset: CGFloat = 5
            static let opacity: CGFloat = 0.4
        }
    }
}

/*
 我猜这个 #Preview 的实现可以参考非 ViewBuilder 的实现，在函数体内只有 View 时可以将这个 View 作为预览对象返回，但是当函数体内有其它代码逻辑时，需要 return 来显式返回这个 View。
 */
#Preview {
    typealias Card = CardView.Card
    return VStack {
        HStack {
            CardView(Card(isFaceUp: true, content: "X", id: "test1"))
                .aspectRatio(4 / 3, contentMode: .fit)
            CardView(Card(content: "X", id: "test1"))
        }
        HStack {
            CardView(Card(isFaceUp: true, isMatched: true, content: "This is a very long string and I hope it fits", id: "test1"))
            CardView(Card(isMatched: true, content: "X", id: "test1"))
        }
    }
    .padding()
    .foregroundColor(.green)
}
