// View for EmojiMemoryGame

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    private let aspectRatio: CGFloat = 2 / 3

    var body: some View {
        VStack {
            HStack {
                Text(viewModel.theme.name).font(.title)
                Spacer()
                HStack {
                    Text("score:").font(.subheadline)
                    Text("\(viewModel.score)").font(.subheadline)
                }
            }
            cards.animation(.default, value: viewModel.cards)
            Spacer()
            Button("new game") {
                viewModel.newGame()
            }
        }
        .padding()
    }

    var cards: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: viewModel.cards.count, size: geometry.size, aspectRatio: aspectRatio)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0)
            {
                ForEach(viewModel.cards) { card in
                    CardView(card)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(viewModel.themeColor)
    }

    func gridItemWidthThatFits(count: Int, size: CGSize, aspectRatio: CGFloat) -> CGFloat {
        let count = CGFloat(count)
        var cols = 1.0

        repeat {
            let width = size.width / cols
            let height = width / aspectRatio
            let rows = (count / cols).rounded(.up)

            if rows * height < size.height {
                return (size.width / cols).rounded(.down)
            }
            cols += 1
        } while cols < count

        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    let cornerRadius: CGFloat = 12
    let borderWidth: CGFloat = 2

    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: cornerRadius)

            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: borderWidth)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
