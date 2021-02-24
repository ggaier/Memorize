//
//  ContentView.swift
//  Memorize
//
//  Created by momo on 2021/2/23.
//

import SwiftUI

struct ContentView: View {
    //read only computed property
    //opaque types, the reverse of generic types
    var body: some View {
        return HStack {
            ForEach(0..<4) {index in
                ZStack {
                    CardView(isFaceUp: false)
                }
            }
        }
        .foregroundColor(Color.orange)
        .padding()
        .font(Font.largeTitle)
    }
}

struct CardView: View {
    
    var isFaceUp: Bool
    
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 10).fill(Color.white)
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3.0)
                Text("👻")
            }else{
                RoundedRectangle(cornerRadius: 10).fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
