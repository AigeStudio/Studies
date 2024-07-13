//
//  AspectVGrid.swift
//  Memorize
//
//  Created by AigeStudio on 19/7/2024.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    var items: [Item]
    var aspectRatio: CGFloat = 1
    var content: (Item) -> ItemView

    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }

    var body: some View {
        GeometryReader(content: { geometry in
            let gridItemSize: CGFloat = gridItemWidthThatFits(
                count: items.count, size: geometry.size, atAspectRatio: aspectRatio
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize /* 最小尺寸 */ ), spacing: 0)], spacing: 0, content /* content 参数是一个 ViewBuilder */: {
                // ForEach(0 ..< cardCount, id: \.self) { index in
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            })
        })
    }

    func gridItemWidthThatFits(
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
}
