// ViewModel for EmojiMemoryGame

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private let themes = [
        Theme(
            name: "animals",
            emojis: [
                "🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵",
            ], color: "green", pairs: 14),
        Theme(
            name: "spooky", emojis: ["👻", "🎃", "🕷", "😈", "💀", "🕸", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"],
            color: "orange", pairs: 12),
        Theme(
            name: "transportation",
            emojis: ["🚔", "🚂", "🚲", "🚗", "🏍", "✈️", "⛵️", "🛵", "🛴", "🛸", "🚁", "🛶", "🚠"],
            color: "blue",
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
        return Theme(name: "", emojis: [], color: "red", pairs: 0)
    }

    private func newGame(emojis: [String]) -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: max(emojis.count, 2)) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            }

            return "❓"
        }
    }

    private func makeColor(from color: String) -> Color {
        switch color {
        case "blue":
            return Color.blue
        case "green":
            return Color.green
        case "orange":
            return Color.orange
        case "red":
            fallthrough
        default:
            return Color.red
        }
    }

    var cards: [MemoryGame<String>.Card] {
        return game.cards
    }

    var score: Int { game.score }

    var themeColor: Color { makeColor(from: theme.color) }

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
