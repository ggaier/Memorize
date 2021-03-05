//
//  Cardify.swift
//  Memorize
//
//  Created by momo on 2021/3/5.
//

import SwiftUI

struct Cardify: ViewModifier {

    var isFaceUp: Bool

    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 10).fill(Color.white)
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3.0)
                content
            } else {
                RoundedRectangle(cornerRadius: 10).fill()
            }
        }
    }
}

extension View {

    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }

}
