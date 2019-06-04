//
//  Concentration.swift
//  concentration
//
//  Created by Mason Katz on 6/2/19.
//  Copyright © 2019 Mason Katz. All rights reserved.
//

import Foundation

class Concentration {
	
	var cards = [Card]()
	
	var indexOfOneAndOnlyFaceUpCard: Int?
	
	init(numberOfPairsOfCards: Int) {
		for _ in 1...numberOfPairsOfCards {
			let card = Card()
			cards += [ card, card ]
		}
		shuffleCards()
	}

//let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))

	func shuffleCards() {
		var copyOfCards = cards
		
		for index in cards.indices {
			let randomIndex = Int(arc4random_uniform(UInt32(copyOfCards.count)))
			let randomCard  = copyOfCards.remove(at: randomIndex)
			
			cards[index].identifier = randomCard.identifier
		}
	}

	
	func chooseCard(at index: Int) {
		if !cards[index].isMatched {
			if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
				if cards[matchIndex].identifier == cards[index].identifier {
					cards[matchIndex].isMatched = true
					cards[index].isMatched = true
				}
				cards[index].isFaceUp = true
				indexOfOneAndOnlyFaceUpCard = nil
			} else {
				for flipDownIndex in cards.indices {
					cards[flipDownIndex].isFaceUp = false
				}
				cards[index].isFaceUp = true
				indexOfOneAndOnlyFaceUpCard = index
			}
		}

	}
	
}
