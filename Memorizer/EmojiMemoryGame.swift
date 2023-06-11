//
//  EmojiMemoryGame.swift
//  Memorizer
//
//  Created by Антон Нехаев on 14.08.2022.
//

// This is a ViewModel


import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let themeVehicles = MemoryGame<String>.Theme(name: "Vehicle",
                                                        arrCardContent: ["✈️", "🚗", "🚀", "🚘", "🚙", "🚛", "🏎", "🚕", "🚚", "🚐", "🚑", "🚲", "🚜", "🛻", "🚅", "🚢", "🚔", "🚁", "🛵", "🚒"],
                                                        numberOfPairsOfCards: .random, color: "red")
    private static let themeFood = MemoryGame<String>.Theme(name: "Food",
                                                        arrCardContent: ["🍔", "🌭", "🌮", "🥗", "🍕", "🍟", "🍿", "🍳", "🍰", "🍎", "🍛", "🥔", "🥚", "🍍"],
                                                    numberOfPairsOfCards: .number(10), color: "green")
    private static let themeSmiles = MemoryGame<String>.Theme(name: "Smiles",
                                                        arrCardContent: ["😀", "😇", "🥳", "😎", "🥸", "🤯", "😶‍🌫️", "😳", "🫤", "😧", "🥴", "💩", "👻", "👽", "🤠"], color: "orange")
    
    private var themes = [themeVehicles, themeFood, themeSmiles]

    static func createMemoryGame(theme: MemoryGame<String>.Theme) -> MemoryGame<String> {
        MemoryGame<String>(theme: theme)
    }
    
    @Published private var model = createMemoryGame(theme: themeFood)
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    var themeName: String {
        model.theme.name
    }
    
    var themeColor: Color {
        switch model.theme.color {
        case "red":
            return Color.red
        case "green":
            return Color.green
        case "orange":
            return Color.orange
        default:
            return Color.red
        }
    }
    
    var score: String {
        var stringScore = String(abs(model.score))
        if stringScore.count <= 2 {
            for _ in 0...(2 - stringScore.count){
                stringScore.insert("0", at: stringScore.startIndex)
            }
        }
        return model.score >= 0 ? stringScore : {
            stringScore.insert("-", at: stringScore.startIndex)
            return stringScore
        }()
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
//        objectWillChange.send()
        
        model.choose(card)
    }
    
    func newGame() {
        model.setTheme(themes.randomElement()!)
    }
}
