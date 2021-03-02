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
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    viewModel.choose(card: card)
                }
            }
        }
            .foregroundColor(Color.orange)
            .padding()
            .font(Font.largeTitle)
    }
}

struct CardView: View {
    var card: MemorizeGameModel<String>.Card

    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10).fill(Color.white)
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3.0)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10).fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: MemorizeViewModel())
    }
}
