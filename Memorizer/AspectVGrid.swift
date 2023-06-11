//
//  AspectVGrid.swift
//  Memorizer
//
//  Created by Антон Нехаев on 24.08.2022.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    var items: [Item]
    var aspectRatio: CGFloat
    @ViewBuilder var content: (Item) -> ItemView
    
    var body: some View {
        GeometryReader { geometry in
            let width = widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: 2/3)
            LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
        
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var item = GridItem(.adaptive(minimum: width))
        item.spacing = 0
        return item
    }
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        
        if columnCount > itemCount {
            columnCount = itemCount
        }
        return floor(size.width / CGFloat(columnCount))
    }
}
