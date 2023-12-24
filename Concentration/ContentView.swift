//
//  ContentView.swift
//  Concentration
//
//  Created by Mason Katz on 12/9/23.
//

import SwiftUI

enum Emojis {
    case halloween
    case transportation
    case animals
}

struct ContentView: View {
    let emojiMap = [
        Emojis.halloween:
            [
                "👻", "🎃", "🕷", "😈", "💀", "🕸", "🧙‍♀️",
                "🙀", "👹", "😱", "☠️", "🍭",
            ],
        Emojis.transportation:
            [
                "🚔", "🚂", "🚲", "🚗", "🏍", "✈️", "⛵️",
                "🛵", "🛴", "🛸", "🚁", "🛶", "🚠",
            ],
        Emojis.animals:
            [
                "🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻",
                "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵",
            ],
    ]

    @State var emojis: [String] = []

    init() {
        var cards = emojiMap[Emojis.halloween]!
        cards += cards
        cards = cards.shuffled()

        _emojis = State(initialValue: cards)
    }

    var body: some View {
        VStack {
            Text("Memorize!").font(.title)
            Spacer()
            ScrollView {
                cards
            }
            Spacer()
            emojiSelecter
        }
        .padding()
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 64))]) {
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(isFaceUp: false, content: emojis[index])
                    .aspectRatio(2 / 3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }

    func chooseEmojis(theme: Emojis, symbol: String, text: String) -> some View {
        VStack {
            Button(
                action: {
                    setTheme(to: theme)
                },
                label: {
                    VStack {
                        Image(systemName: symbol).font(.title)
                        Text(text).font(.caption)
                    }
                })
        }
    }

    func setTheme(to theme: Emojis) {
        var cards = emojiMap[theme]!
        cards += cards
        emojis = cards.shuffled()
    }

    var chooseHalloween: some View {
        chooseEmojis(theme: Emojis.halloween, symbol: "moon.haze.fill", text: "Halloween")
    }

    var chooseTransportation: some View {
        chooseEmojis(theme: Emojis.transportation, symbol: "car", text: "Transportation")
    }

    var chooseAnimals: some View {
        chooseEmojis(theme: Emojis.animals, symbol: "hare", text: "Animals")
    }

    var emojiSelecter: some View {
        HStack {
            Spacer()
            chooseHalloween
            Spacer()
            chooseTransportation
            Spacer()
            chooseAnimals
            Spacer()
        }
    }

}

struct CardView: View {
    let cornerRadius: CGFloat = 12
    let borderWidth: CGFloat = 2
    @State var isFaceUp = false
    let content: String

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: cornerRadius)

            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: borderWidth)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
