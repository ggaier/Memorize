//
//  GridView.swift
//  Memorize
//
//  Created by momo on 2021/3/3.
//

import SwiftUI

struct GridView<Item, ItemView>: View where Item: Identifiable, ItemView: View {

    var items: [Item]
    var viewForItem: (Item) -> ItemView

    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }

    var body: some View {
        GeometryReader { geometry in
            gridBody(for: GridLayout(itemCount: items.count, in: geometry.size))
        }
    }

    func gridBody(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            itemView(for: item, in: layout)
        }
    }

    func itemView(for item: Item, in layout: GridLayout ) -> some View {
        let index = items.firstIndex(of: item)!
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
}

