//
//  MemorizerApp.swift
//  Memorizer
//
//  Created by Антон Нехаев on 13.08.2022.
//

import SwiftUI

@main
struct MemorizerApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
