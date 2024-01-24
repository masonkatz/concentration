// Model for MemoryGame

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]

    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).only }
        set { cards.indices.forEach({ cards[$0].isFaceUp = (newValue == $0) }) }
    }

    private(set) var score = 0

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []

        for i in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(i)

            cards.append(Card(content: content, id: "\(i+1)a"))
            cards.append(Card(content: content, id: "\(i+1)b"))
        }

        shuffle()
    }

    mutating func shuffle() {
        cards.shuffle()
    }

    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(matching: card) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    score += checkForMatch(chosenIndex, potentialMatchIndex)
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }

                cards[chosenIndex].isFaceUp = true
            }
        }
    }

    mutating func checkForMatch(_ i: Int, _ j: Int) -> Int {
        print("checkForMatch \(cards[i]) \(cards[j])")

        var points = 0

        if cards[i].matches(cards[j]) {
            cards[i].isMatched = true
            cards[j].isMatched = true
            points = 2
        } else {
            if cards[i].wasSeen {
                points -= 1
            }
            if cards[j].wasSeen {
                points -= 1
            }
            cards[i].wasSeen = true
            cards[j].wasSeen = true
        }

        return points
    }

    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String {
            return
                "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "") \(wasSeen ? "seen" : "")"
        }

        var isFaceUp = false
        var isMatched = false
        var wasSeen = false
        let content: CardContent

        func matches(_ card: Card) -> Bool {
            return card.content == self.content
        }

        var id: String

    }
}
