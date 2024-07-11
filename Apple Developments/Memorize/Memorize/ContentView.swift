//
//  ContentView.swift
//  Memorize
//
//  Created by AigeStudio on 10/7/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(content /* content 参数是一个 ViewBuilder */: {
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
        })
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    var isFaceUp: Bool = false

    var body: some View {
        ZStack(content: {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10, 2]))
                Image(systemName: "globe")
                    // 一般而言，View Modifier 的调用顺序不会影响结果，但是如果是 “封装 Modifier” 则需要注意调用顺序。
                    // View Modifier 分为两种：In-place Modifier（原地 Modifier）和 Wrapper Modifier（封装 Modifier）
                    // In-place Modifier：指直接作用于 View 本身的 Modifier，这些 Modifier 会在不改变 View 层次结构的情况下修改 View 的属性和行为，例如 padding、foregroundColor、font 等。
                    // Wrapper Modifier：将一个 View 包裹在另一个 View 中的 Modifier，通常会改变 View 的层次结构。这类 Modifier 通常会创建一个新的容器 View，并将原始 View 作为子 View 放入其中。例如 overlay、clipShape、mask 等。
                    // background 是个特殊的 Modifier，根据具体的实现既可以看作是 In-place Modifier 也可以是 Wrapper Modifier。
                    .foregroundColor(Color.green) // View Modifier
                    .imageScale(.small) // View Modifier
                    .foregroundStyle(.tint) // View Modifier
                Text("Hello CS193p!")
                    .padding()
                Text("👻")
            } else {
                RoundedRectangle(cornerRadius: 12)
            }
        })
    }
}

#Preview {
    ContentView()
}
