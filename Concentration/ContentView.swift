//
//  ContentView.swift
//  Concentration
//
//  Created by Mason Katz on 12/9/23.
//

import SwiftUI

enum Themes {
    case halloween
    case transportation
    case animals
}

struct Theme {
    let emojis: [String]
    let color: Color
}

struct ContentView: View {
    let themes = [
        Themes.halloween: Theme(
            emojis: [
                "👻", "🎃", "🕷", "😈", "💀", "🕸", "🧙‍♀️", "🙀", "👹",
                "😱", "☠️", "🍭",
            ],
            color: .orange
        ),
        Themes.transportation: Theme(
            emojis: [
                "🚔", "🚂", "🚲", "🚗", "🏍", "✈️", "⛵️", "🛵", "🛴",
                "🛸", "🚁", "🛶", "🚠",
            ],
            color: .blue
        ),
        Themes.animals: Theme(
            emojis: [
                "🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨",
                "🐯", "🦁", "🐮", "🐷", "🐸", "🐵",
            ],
            color: .green
        ),
    ]

    @State var emojis: [String] = []
    @State var color: Color = .black

    init() {
        let theme = themes[Themes.halloween]!

        _emojis = State(initialValue: getEmojis(from: Themes.halloween))
        _color = State(initialValue: theme.color)
    }

    func getEmojis(from theme: Themes) -> [String] {
        var emojis = themes[theme]!.emojis
        let numCards = Int.random(in: 2...emojis.count)

        emojis.shuffle()
        emojis = Array(emojis[..<numCards])
        emojis = emojis + emojis
        return emojis.shuffled()
    }

    func setTheme(to theme: Themes) {
        emojis = getEmojis(from: theme)
        color = themes[theme]!.color
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
        .foregroundColor(color)
    }

    func chooseTheme(theme: Themes, symbol: String, text: String) -> some View {
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

    var chooseHalloween: some View {
        chooseTheme(theme: Themes.halloween, symbol: "moon.haze.fill", text: "Halloween")
    }

    var chooseTransportation: some View {
        chooseTheme(theme: Themes.transportation, symbol: "car", text: "Transportation")
    }

    var chooseAnimals: some View {
        chooseTheme(theme: Themes.animals, symbol: "hare", text: "Animals")
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
