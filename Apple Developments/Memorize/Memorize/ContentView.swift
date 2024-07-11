//
//  ContentView.swift
//  Memorize
//
//  Created by AigeStudio on 10/7/2024.
//

import SwiftUI

struct ContentView: View {
    let emojis: [String] = ["👻", "🎃", "👽", "😈", "👻", "🎃", "👽", "😈", "👻", "🎃", "👽", "😈"]
    @State var cardCount: Int = 4
    /*
     除此之外，body 变量的声明还可以指定如下具体类型
     var body: Text {
        Text("")
     }
     */
    var body: some View /* “some View” 表示 body 变量为一个 “不透明” 的 View 类型， some 关键字类似于 Kotlin/Java 中的泛型和接口等*/ {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }

    var cards: some View {
        // 这里的 return 可以被省略，因为这个函数体内实际上只有一行并且返回值正确，编译器可以自动推断这唯一的一行为返回值
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 120 /* 最小尺寸 */ ))], content /* content 参数是一个 ViewBuilder */: {
            ForEach(0 ..< cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2 / 3, contentMode: .fit)
            }
        })
        .foregroundColor(.orange)
    }

    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }

    // 函数的参数名可以分为 internal parameter name（内部参数名）和 external parameter name（外部参数名）：
    // func 函数名(外部参数名 内部参数名: 参数类型) -> 返回类型 {}
    // 顾名思义内部参数名就是在函数体内部使用的参数名称，外部参数名则是在外部调用该函数时使用的函数名称
    // 外部参数名可以使用 “_” 省略并替代，此时内外部参数名均为同一个：
    // func 函数名(_ 参数名: 参数类型) -> 返回类型 {}
    // 当然也可以直接省略掉 “_”：
    // // func 函数名(参数名: 参数类型) -> 返回类型 {}
    func cardCountAdjuster(by /* 外部参数名 */ offset /* 内部参数名 */: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset // 在函数体内部使用内部参数名
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }

    var cardRemover: some View {
        // 使用 return
        return cardCountAdjuster(by /* 在函数体外部调用函数使用外部参数名 */: -1, symbol: "rectangle.stack.badge.minus.fill")
    }

    var cardAdder: some View {
        // 不使用 return
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
}

// View 本身是 immutable 的
struct CardView: View {
    let content: String

    // 修改 immutable 中的属性需要添加 @State 装饰器
    @State var isFaceUp: Bool = true

    var body: some View {
        /*
         这里的 content 参数可以被省略并将 {} 置于 () 之外，称之为 “trailing closure syntax” 尾随闭包语法
         ZStack(alignment: .top, content: {})
         等效于
         ZStack(alignment: .top){}
         */
        ZStack(alignment: .center, content: {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10, 2]))
                Image(systemName: "globe")
                    .hidden()
                    // 一般而言，View Modifier 的调用顺序不会影响结果，但是如果是 “封装 Modifier” 则需要注意调用顺序。
                    // View Modifier 分为两种：In-place Modifier（原地 Modifier）和 Wrapper Modifier（封装 Modifier）
                    // In-place Modifier：指直接作用于 View 本身的 Modifier，这些 Modifier 会在不改变 View 层次结构的情况下修改 View 的属性和行为，例如 padding、foregroundColor、font 等。
                    // Wrapper Modifier：将一个 View 包裹在另一个 View 中的 Modifier，通常会改变 View 的层次结构。这类 Modifier 通常会创建一个新的容器 View，并将原始 View 作为子 View 放入其中。例如 overlay、clipShape、mask 等。
                    // background 是个特殊的 Modifier，根据具体的实现既可以看作是 In-place Modifier 也可以是 Wrapper Modifier。
                    .foregroundColor(Color.green) // View Modifier
                    .imageScale(.large) // View Modifier
                    .foregroundStyle(.tint) // View Modifier
                Text("Hello CS193p!")
                    .hidden()
                    .padding()
                Text(content)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        })
        .onTapGesture(count: 2 /* 设置指定 tap 次数后触发 */, perform: {
            print("Tapped")
            // 因为 View 是 immutable 的，所以直接使用下面这行代码会报错：无法修改 immutable 类中的属性，此时需要将可以被修改的属性使用 @State 装饰器修饰
            // isFaceUp = !isFaceUp
            isFaceUp.toggle() // 等效于 isFaceUp = !isFaceUp
        })
    }
}

#Preview {
    ContentView()
}
