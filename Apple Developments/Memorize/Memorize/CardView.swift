//
//  CardView.swift
//  Memorize
//
//  Created by AigeStudio on 19/7/2024.
//

import SwiftUI

struct CardView: View {
    let card: MemoryGame<String>.Card
    init(_ card: MemoryGame<String>.Card) {
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
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            if card.isFaceUp {
                base.fill(Color.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            } else {
                base.fill()
            }
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    CardView(MemoryGame<String>.Card(content: "X", id: "test1"))
        .padding()
        .foregroundColor(.green)
}
