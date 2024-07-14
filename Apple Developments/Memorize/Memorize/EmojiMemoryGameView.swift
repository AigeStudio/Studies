//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by AigeStudio on 10/7/2024.
//

import SwiftUI

/*
 结构体 struct 与类 class 的主要区别：
 1. 结构体 struct 是值类型，值类型在赋值或传递时会进行值拷贝，例如：
 ----------------------------------------------------
 struct Person {
     var name: String
 }
 var person1 = Person(name: "Alice")
 var person2 = person1// 值类型，拷贝
 person2.name = "Bob"

 print(person1.name) // 输出 "Alice"
 print(person2.name) // 输出 "Bob"
 ----------------------------------------------------
 与之相反，如果是 class 的话：
 ----------------------------------------------------
 class Person {
     var name: String
     init(name: String) {
         self.name = name
     }
 }
 var person1 = Person(name: "Alice")
 var person2 = person1// 引用类型，传递引用
 person2.name = "Bob"

 print(person1.name) // 输出 "Bob"
 print(person2.name) // 输出 "Bob"
 ----------------------------------------------------

 2. 结构体不能被继承但类可以

 3. 结构体会自动生成构造器，类不会自动生成需要显式声明：
 struct Point {
     var x: Int
     var y: Int
 }
 let point = Point(x: 10, y: 20)
 ----------------------------------------------------
 class Point {
     var x: Int
     var y: Int
     // 显式声明构造器
     init(x: Int, y: Int) {
         self.x = x
         self.y = y
     }
 }
 let point = Point(x: 10, y: 20)

 4. 类的对象使用引用计数（ARC - Automatic Reference Counting）来进行管理内存；结构体是值类型不使用引用计数，其生命周期由其作用域决定。

 5. 结构体如果是常量 let 则其所有的属性也是常量不能被修改；类的实例即使是常量 let，其（var）属性也可以被修改。

 6. 结构体：函数式编程；类（对象）：面向对象编程。
 */
struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    let emojis: [String] = ["👻", "🎃", "👽", "😈", "👻", "🎃", "👽", "😈", "👻", "🎃", "👽", "😈", "👻", "🎃", "👽"]
    @State var cardCount: Int = 4
    private let aspectRatio: CGFloat = 2 / 3
    private let spacing: CGFloat = 4
    /*
     除此之外，body 变量的声明还可以指定如下具体类型
     var body: Text {
        Text("")
     }
     */
    var body: some View /* “some View” 表示 body 变量为一个 “不透明” 的 View 类型， some 关键字类似于 Kotlin/Java 中的泛型和接口等*/ {
        VStack {
//            ScrollView {
            cards
                .foregroundColor(viewModel.color)
                .animation(.default, value: viewModel.cards)
//                .background(.red)
//            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
//            .background(Color.blue)
//            Spacer()
//            cardCountAdjusters
        }
//        .background(Color.yellow)// 将 background 设置在 padding 前后是有区别的
        .padding()
//        .background(Color.yellow)
    }

    /*
     这里的 cards 可以添加一个 @ViewBuilder 属性装饰器以表明该属性是一个 ViewBuilder，此时可以省略掉 “return” 关键字
     */
    private var cards: some View {
        // 这里的 return 可以被省略，因为这个函数体内实际上只有一行并且返回值正确，编译器可以自动推断这唯一的一行为返回值
        return AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(spacing)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
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

//// View 本身是 immutable 的
// struct CardView: View {
//    let content: String
//
//    // 修改 immutable 中的属性需要添加 @State 装饰器
//    @State var isFaceUp: Bool = true
//
//    var body: some View {
//        /*
//         这里的 content 参数可以被省略并将 {} 置于 () 之外，称之为 “trailing closure syntax” 尾随闭包语法
//         ZStack(alignment: .top, content: {})
//         等效于
//         ZStack(alignment: .top){}
//         */
//        ZStack(alignment: .center, content: {
//            let base = RoundedRectangle(cornerRadius: 12)
//            Group {
//                base.foregroundColor(.white)
//                base.strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10, 2]))
//                Image(systemName: "globe")
//                    .hidden()
//                    // 一般而言，View Modifier 的调用顺序不会影响结果，但是如果是 “封装 Modifier” 则需要注意调用顺序。
//                    // View Modifier 分为两种：In-place Modifier（原地 Modifier）和 Wrapper Modifier（封装 Modifier）
//                    // In-place Modifier：指直接作用于 View 本身的 Modifier，这些 Modifier 会在不改变 View 层次结构的情况下修改 View 的属性和行为，例如 padding、foregroundColor、font 等。
//                    // Wrapper Modifier：将一个 View 包裹在另一个 View 中的 Modifier，通常会改变 View 的层次结构。这类 Modifier 通常会创建一个新的容器 View，并将原始 View 作为子 View 放入其中。例如 overlay、clipShape、mask 等。
//                    // background 是个特殊的 Modifier，根据具体的实现既可以看作是 In-place Modifier 也可以是 Wrapper Modifier。
//                    .foregroundColor(Color.green) // View Modifier
//                    .imageScale(.large) // View Modifier
//                    .foregroundStyle(.tint) // View Modifier
//                Text("Hello CS193p!")
//                    .hidden()
//                    .padding()
//                Text(content)
//            }
//            .opacity(isFaceUp ? 1 : 0)
//            base.fill().opacity(isFaceUp ? 0 : 1)
//        })
//        .onTapGesture(count: 2 /* 设置指定 tap 次数后触发 */, perform: {
//            print("Tapped")
//            // 因为 View 是 immutable 的，所以直接使用下面这行代码会报错：无法修改 immutable 类中的属性，此时需要将可以被修改的属性使用 @State 装饰器修饰
//            // isFaceUp = !isFaceUp
//            isFaceUp.toggle() // 等效于 isFaceUp = !isFaceUp
//        })
//    }
// }

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
