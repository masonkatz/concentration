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

    func emojis() -> [String] {
        return Array(emojiSet.shuffled()[0..<pairs])
    }

}

class EmojiMemoryGame: ObservableObject {
    private static let themes = [
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

    static var theme = newTheme()

    private static func newTheme() -> Theme {
        if let theme = themes.randomElement() {
            return theme
        }

        return Theme(name: "", emojis: [], color: .red, pairs: 0)
    }

    private static func newGame() -> MemoryGame<String> {
        let emojis = theme.emojis()

        return MemoryGame(numberOfPairsOfCards: max(emojis.count, 2)) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            }

            return "❓"
        }
    }

    var theme: Theme { EmojiMemoryGame.theme }

    @Published private var game = newGame()

    var cards: [MemoryGame<String>.Card] {
        return game.cards
    }

    var score: Int { game.score }

    // MARK: Intents

    func newGame() {
        EmojiMemoryGame.theme = EmojiMemoryGame.newTheme()
        game = EmojiMemoryGame.newGame()
    }

    func shuffle() {
        game.shuffle()
    }

    func choose(_ card: MemoryGame<String>.Card) {
        game.choose(card)
    }

}
