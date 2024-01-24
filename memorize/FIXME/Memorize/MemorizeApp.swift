//
//  MemoryApp.swift
//  Memory
//
//  Created by Mason Katz on 12/9/23.
//

import SwiftUI

@main
struct MemoryApp: App {
    @StateObject var game = EmojiMemoryGame()

    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
