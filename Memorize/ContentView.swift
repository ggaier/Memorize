//
//  ContentView.swift
//  Memorize
//
//  Created by momo on 2021/2/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject
    var viewModel: MemorizeViewModel

    //read only computed property
    //opaque types, the reverse of generic types
    var body: some View {
        GridView(viewModel.cards) { card in
            CardView(card: card).onTapGesture { viewModel.choose(card: card) }
                .padding(5)
        }.foregroundColor(Color.orange)
            .padding()
    }
}

struct CardView: View {
    var card: MemorizeGameModel<String>.Card

    var body: some View {
        GeometryReader { geometry in body(for: geometry.size) }
    }

    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(0 - 90),
                    endAngle: Angle.degrees(110 - 90),
                    clockwise: true)
                    .padding(5)
                    .opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
            }.cardify(isFaceUp: card.isFaceUp)
        }
    }

    private func fontSize(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = MemorizeViewModel()
        vm.choose(card: vm.cards[0])
        return ContentView(viewModel: vm)
    }
}
