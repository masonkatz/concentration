// ViewModel for EmojiMemoryGame

import SwiftUI

struct Theme {
    private let emojiSet: [String]
    private let pairs: Int

    let name: String
    let color: Color

    init(name: String, emojis: [String], color: Color, pairs: Int) {
        self.name = name
        self.emojiSet = emojis
        self.color = color
        self.pairs = pairs
    }

    var emojis: [String] {
        Array(emojiSet.shuffled()[0..<pairs])
    }

}

class EmojiMemoryGame: ObservableObject {
    private let themes = [
        Theme(
            name: "animals",
            emojis: [
                "🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵",
            ], color: .green, pairs: 14),
        Theme(
            name: "spooky", emojis: ["👻", "🎃", "🕷", "😈", "💀", "🕸", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"],
            color: .orange, pairs: 12),
        Theme(
            name: "transportation",
            emojis: ["🚔", "🚂", "🚲", "🚗", "🏍", "✈️", "⛵️", "🛵", "🛴", "🛸", "🚁", "🛶", "🚠"], color: .blue,
            pairs: 10),
    ]

    @Published private var game: MemoryGame<String>!
    private(set) var theme: Theme!

    init() {
        newGame()
    }

    private func newTheme() -> Theme {
        if let element = themes.randomElement() {
            return element
        }
        return Theme(name: "", emojis: [], color: .red, pairs: 0)
    }

    private func newGame(emojis: [String]) -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: max(emojis.count, 2)) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            }

            return "❓"
        }
    }

    var cards: [MemoryGame<String>.Card] {
        return game.cards
    }

    var score: Int { game.score }

    // MARK: Intents

    func newGame() {
        theme = newTheme()
        game = newGame(emojis: theme.emojis)
    }

    func shuffle() {
        game.shuffle()
    }

    func choose(_ card: MemoryGame<String>.Card) {
        game.choose(card)
    }

}
