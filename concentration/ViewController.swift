//
//  ViewController.swift
//  concentration
//
//  Created by Mason Katz on 6/2/19.
//  Copyright © 2019 Mason Katz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
	
	var numberOfPairsOfCards: Int {
		return (cardButtons.count+1) / 2
	}

	@IBOutlet private var cardButtons: [UIButton]!
	
	@IBOutlet private weak var flipCountLabel: UILabel!
	
	@IBAction private func touchCard(_ sender: UIButton) {
		if let cardNumber = cardButtons.firstIndex(of:sender) {
			game.chooseCard(at: cardNumber)
			updateViewFromModel()
		} else {
			print("oops")
		}
	}

	private func updateViewFromModel() {
		flipCountLabel.text = "flips: \(game.flipCount)"
		for index in cardButtons.indices {
			let button = cardButtons[index]
			let card   = game.cards[index]
			
			if card.isFaceUp {
				button.setTitle(emoji(for: card), for: UIControl.State.normal)
				button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
			} else {
				button.setTitle("", for: UIControl.State.normal)
				button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 0.8562871814, green: 0.2501284182, blue: 0.4774048328, alpha: 1)
			}
		}
	}

	private var emojiChoices = [ "🐶", "🐱", "🐭", "🐹", "🐰", "🦊",
			     "🐻", "🐼", "🐨", "🐯", "🦁", "🐮",
			     "🐷", "🐸", "🐵", "🐔", "🐙", "🐳" ]
	
	private var emoji = [Int: String]()
	
	private func emoji(for card: Card) -> String {
		if emoji[card.identifier] == nil, emojiChoices.count > 0 {
			emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
		}
		return emoji[card.identifier] ?? "?"
	}
	

}

extension Int {
	var arc4random: Int {
		if self > 0 {
			return Int(arc4random_uniform(UInt32(self)))
		} else if self < 0 {
			return -Int(arc4random_uniform(UInt32(abs(self))))
		} else {
			return 0
		}
	}

}
