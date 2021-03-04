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
            CardView(card: card).onTapGesture {
                viewModel.choose(card: card)
            }
        }
            .foregroundColor(Color.orange)
            .padding()
    }
}

struct CardView: View {
    var card: MemorizeGameModel<String>.Card

    var body: some View {
        GeometryReader { geometry in
            body(for: min(geometry.size.width, geometry.size.height) * 0.75)
        }
    }

    private func body(for size: CGFloat) -> some View {
        return ZStack {
            if !card.isMatched {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: 10).fill(Color.white)
                    RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3.0)
                    Text(card.content)
                } else {
                    RoundedRectangle(cornerRadius: 10).fill()
                }
            }
        }.font(Font.system(size: size))
            .padding(5)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: MemorizeViewModel())
    }
}
