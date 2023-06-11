//
//  MemoryGame.swift
//  Memorizer
//
//  Created by Антон Нехаев on 14.08.2022.
//

//  it is a model file!

import Foundation

extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        }
        return nil
    }
}

struct MemoryGame <CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    var indexOfAnotherFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFacedUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFacedUp = ($0 == newValue) } }
    }
    var score = 0
    
    private(set) var theme: Theme
    
    mutating func setTheme(_ newTheme: Theme) {
        self = MemoryGame(theme: newTheme)
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { element in element.id == card.id }),
           !cards[chosenIndex].isFacedUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfAnotherFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[potentialMatchIndex].isMatched = true
                    cards[chosenIndex].isMatched = true
                    score += 2
                } else {
                    if cards[chosenIndex].alreadyBeenSeen && cards[potentialMatchIndex].alreadyBeenSeen {
                        score -= 2
                    } else if cards[chosenIndex].alreadyBeenSeen || cards[potentialMatchIndex].alreadyBeenSeen{
                        score -= 1
                    }
                }
                cards[chosenIndex].alreadyBeenSeen = true
                cards[potentialMatchIndex].alreadyBeenSeen = true
//                indexOfAnotherFaceUpCard = nil
                cards[chosenIndex].isFacedUp.toggle()
            } else {
                indexOfAnotherFaceUpCard = chosenIndex
            }
        }
        
    }
    
    init(theme: Theme) {
        self.theme = theme
        cards = []
        var numberOfPairsOfCards = 0
        switch theme.numberOfPairsOfCards {
            case .all:
                numberOfPairsOfCards = theme.arrCardContent.count
            case .number(let amount):
                numberOfPairsOfCards = amount
            case .random:
                numberOfPairsOfCards = (4...theme.arrCardContent.count).randomElement()!
        }
        for pairIndex in 0..<numberOfPairsOfCards {
//            let tmpArrCardContent = theme.arrCardContent
            
            let tmpArrCardContent = theme.arrCardContent.shuffled()
            let content = tmpArrCardContent[pairIndex]
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
//        var isFacedUp = true
        var isFacedUp = false
        var isMatched = false
        var alreadyBeenSeen = false
        let content: CardContent
        
        var id: Int // important for ForEach
    }
    
    struct Theme {
        var name: String
        var arrCardContent: [CardContent]
        var numberOfPairsOfCards: Amount
        var color: String
        
        init(name: String, arrCardContent: [CardContent],
             numberOfPairsOfCards: Amount = .all, color: String) {
            self.name = name
            self.arrCardContent = arrCardContent
            self.numberOfPairsOfCards = numberOfPairsOfCards
            self.color = color
        }
        
        enum Amount {
            case all
            case number (Int)
            case random
        }
    }
}
