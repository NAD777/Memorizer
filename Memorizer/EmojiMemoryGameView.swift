//
//  EmojiMemoryGameView.swift
//  Memorizer
//
//  Created by Антон Нехаев on 13.08.2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            HStack {
                Text(game.themeName)
                    .padding(.leading)
                Spacer()
                Text(game.score)
                    .padding(.trailing)
                
            }
            .font(.largeTitle)
            AspectVGrid(items: game.cards, aspectRatio: 2/3)  {
                card in
                if card.isMatched && !card.isFacedUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .cardify(isFacedUp: card.isFacedUp)
                        .padding(3)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
                
            }
            .foregroundColor(game.themeColor)
            .padding(.horizontal)
            
            Spacer()
            HStack{
                Button {
                    game.newGame()
                } label: {
                    Text("New game")
                        .font(.title)
                }
            }
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(0), clockWise: false)
                    .padding(4)
                    .opacity(0.5)
                Text(card.content).font(font(in: geometry.size))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .font(.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFacedUp: card.isFacedUp)
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
        
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.6
        static let fontSize: CGFloat = 32
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        var game = EmojiMemoryGame()
        return EmojiMemoryGameView(game: game)
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
    }
}
