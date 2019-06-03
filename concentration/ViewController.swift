//
//  ViewController.swift
//  concentration
//
//  Created by Mason Katz on 6/2/19.
//  Copyright © 2019 Mason Katz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	lazy var game = Concentration(numberOfPairsOfCards: cardButtons.count / 2)

	var flipCount = 0 {
		didSet {
			flipCountLabel.text = "flips: \(flipCount)"
		}
	}
	

	@IBOutlet var cardButtons: [UIButton]!
	
	@IBOutlet weak var flipCountLabel: UILabel!
	
	@IBAction func touchCard(_ sender: UIButton) {
		flipCount += 1
		if let cardNumber = cardButtons.firstIndex(of:sender) {
			game.chooseCard(at: cardNumber)
			updateViewFromModel()
		} else {
			print("oops")
		}
	}

	func updateViewFromModel() {
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

	var emojiChoices = [ "🐶", "🐱", "🐭", "🐹", "🐰", "🦊",
			     "🐻", "🐼", "🐨", "🐯", "🦁", "🐮",
			     "🐷", "🐸", "🐵", "🐔", "🐙", "🐳" ]
	
	var emoji = [Int: String]()
	
	func emoji(for card: Card) -> String {
		if emoji[card.identifier] == nil, emojiChoices.count > 0 {
			let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
			emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
		}
		return emoji[card.identifier] ?? "?"
	}
	

}

