//
//  ContentView.swift
//  Memorize
//
//  Created by momo on 2021/2/23.
//

import SwiftUI

struct ContentView: View {

    private let cardAnimationDuration: Double = 0.5
    private let cardPadding: CGFloat = 3

    @ObservedObject
    var viewModel: MemorizeViewModel

    //read only computed property
    //opaque types, the reverse of generic types
    var body: some View {
        VStack {
            GridView(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(Animation.linear(duration: cardAnimationDuration)) {
                        viewModel.choose(card: card)
                    }
                }.padding(cardPadding)
            }.foregroundColor(Color.orange)
                .padding()
            Button(action: {
                withAnimation(Animation.easeInOut) {
                    viewModel.resetGame()
                }
            }) {
                Text("New Game")
            }
        }
    }
}

struct CardView: View {
    var card: MemorizeGameModel<String>.Card

    var body: some View {
        GeometryReader { geometry in body(for: geometry.size) }
    }

    @State private var animatedBonusRemaing: Double = 0 {
        didSet {
            print("animatedBoundRemaining: \(animatedBonusRemaing)")
        }
    }

    private func startBonusTimeAnimation() {
        animatedBonusRemaing = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaing = 0
        }
    }

    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if(card.isConsumingBonusTime) {
                        Pie(startAngle: Angle.degrees(0 - 90),
                            endAngle: Angle.degrees(-animatedBonusRemaing * 360 - 90),
                            clockwise: true)
                            .onAppear {
                            startBonusTimeAnimation()
                        }
                    } else {
                        Pie(startAngle: Angle.degrees(0 - 90),
                            endAngle: Angle.degrees(-card.bonusRemaining * 360 - 90),
                            clockwise: true)
                    }
                }
                    .padding(5)
                    .opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }.cardify(isFaceUp: card.isFaceUp)
                .transition(AnyTransition.scale)
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
