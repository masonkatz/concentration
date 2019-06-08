//
//  Card.swift
//  concentration
//
//  Created by Mason Katz on 6/2/19.
//  Copyright © 2019 Mason Katz. All rights reserved.
//

import Foundation

struct Card {
	var isFaceUp = false
	var isMatched = false
	var identifier: Int
	
	init() {
		self.identifier = Card.getUniqueIdentifier()
		
	}
	
	private static var identifierFactory = 0
	
	private static func getUniqueIdentifier() -> Int {
		identifierFactory += 1
		return identifierFactory
	}
}
