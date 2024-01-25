//
//  EmojiTheme.swift
//  Memorize
//
//  Created by Mason Katz on 1/5/24.
//

import Foundation

struct Theme {
    private let emojiSet: [String]
    private let pairs: Int?

    let name: String
    let color: String

    init(name: String, emojis: [String], color: String, pairs: Int?) {
        self.name = name
        self.emojiSet = emojis
        self.color = color
        self.pairs = pairs
    }

    var emojis: [String] {
        let emojiSet = emojiSet.shuffled()  // a subset is a randown subset not the first N emojis

        if let pairs = pairs {
            return Array(emojiSet[0..<pairs])
        } else {
            return Array(emojiSet[0..<Int.random(in: 0..<emojiSet.count)])  // random subset size
        }
    }

}
