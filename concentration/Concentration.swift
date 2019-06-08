//
//  Concentration.swift
//  concentration
//
//  Created by Mason Katz on 6/2/19.
//  Copyright © 2019 Mason Katz. All rights reserved.
//

import Foundation

class Concentration {
	
	private(set) var cards = [Card]()
	private(set) var flipCount = 0
	
	private var indexOfOneAndOnlyFaceUpCard: Int? {
		get {
			var foundIndex: Int?
			
			for index in cards.indices {
				if cards[index].isFaceUp {
					if foundIndex == nil {
						foundIndex = index
					} else {
						return nil
					}
				}
			}
			return foundIndex
		}
		set {
			for index in cards.indices {
				cards[index].isFaceUp = (index == newValue)
			}
		}
	}
	
	init(numberOfPairsOfCards: Int) {
		assert(numberOfPairsOfCards > 0, "Concentration.init")
		for _ in 1...numberOfPairsOfCards {
			let card = Card()
			cards += [ card, card ]
		}
		shuffleCards()
	}


	private func shuffleCards() {
		var copyOfCards = cards
		
		for index in cards.indices {
			let randomCard  = copyOfCards.remove(at: copyOfCards.count.arc4random)
			
			cards[index].identifier = randomCard.identifier
		}
	}

	
	func chooseCard(at index: Int) {
		assert(cards.indices.contains(index), "Concentration.chooseCard")
		
		if !cards[index].isFaceUp {
			flipCount += 1
		}
		
		if !cards[index].isMatched {
			if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
				if cards[matchIndex].identifier == cards[index].identifier {
					cards[matchIndex].isMatched = true
					cards[index].isMatched = true
				}
				cards[index].isFaceUp = true
			} else {
				indexOfOneAndOnlyFaceUpCard = index
			}
		}
	}
	
}
