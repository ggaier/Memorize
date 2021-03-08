//
//  Cardify.swift
//  Memorize
//
//  Created by momo on 2021/3/5.
//

import SwiftUI

struct Cardify: AnimatableModifier {

    var rotation: Double

    var isFaceUp: Bool {
        rotation < 90
    }

    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }

    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }

    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: stokeWidth)
                content
            }.opacity(isFaceUp ? 1 : 0)

            RoundedRectangle(cornerRadius: cornerRadius).fill()
                .opacity(isFaceUp ? 0 : 1)
        }
            .rotation3DEffect(Angle.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }

    private let cornerRadius: CGFloat = 10
    private let stokeWidth: CGFloat = 3.0
}

extension View {

    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }

}
