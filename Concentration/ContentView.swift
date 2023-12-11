//
//  ContentView.swift
//  Concentration
//
//  Created by Mason Katz on 12/9/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            ForEach(1...4, id: \.self) { _ in
                CardView(isFaceUp: true, emoji: "😂")
            }
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    let cornerRadius: CGFloat = 12
    let borderWidth: CGFloat = 2
    var isFaceUp = false
    var emoji = "😎"

    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(lineWidth: borderWidth)
                Text(emoji).font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: cornerRadius)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
