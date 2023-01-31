//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Dudas Tamas Alex on 2023. 01. 25..
//

// View

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        AspectVGrid(items:game.cards, aspectRatio: 2/3){ card in
            cardView(for: card);
        }
         .foregroundColor(.red).padding(.horizontal)
        }
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card)->some View{
        if card.isMatched && !card.isFaceUp{
            Rectangle().opacity(0);
        }else{
            CardView(card)
                .padding(4)
                .onTapGesture{
                    game.choose(card);
                }
        }
    }
    }

struct CardView: View{
    private let card:EmojiMemoryGame.Card;
    
    init(_ card: EmojiMemoryGame.Card){
        self.card = card;
    }
    var body: some View{
        GeometryReader(content: {
            geometry in
             ZStack {
                 let shape: RoundedRectangle = RoundedRectangle(cornerRadius:DrawingConstants.cornerRadius);
                if card.isFaceUp{
                    shape
                        .fill()
                        .foregroundColor(.white);
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth);
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched{
                    shape.opacity(DrawingConstants.opacity);
                }
                else {
                    shape.fill();
                }
            }
        })
    }
    private func font(in size:CGSize)-> Font{
        Font.system(size: min(size.width,size.height) * DrawingConstants.scaleFactor);
    }
    private struct DrawingConstants{
        static let cornerRadius:CGFloat = 10.0;
        static let lineWidth:CGFloat = 3.0;
        static let scaleFactor:CGFloat = 0.85;
        static let opacity:Double = 0;
    }
}
























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame();
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
        EmojiMemoryGameView(game: game).preferredColorScheme(.dark)
    }
}
