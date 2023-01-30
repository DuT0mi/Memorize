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
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]){
                    ForEach(game.cards){ card in
                        CardView(card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture{
                                game.choose(card);
                            }
                    }
                }
            }.foregroundColor(.red).padding(.horizontal)
        }
    }

struct CardView: View{
    private let card:EmojiMemoryGame.Card;
    
    init(_ card: EmojiMemoryGame.Card){
        self.card = card;
    }
    var body: some View{
        return ZStack {
            let shape: RoundedRectangle = RoundedRectangle(cornerRadius: 20.0);
            if card.isFaceUp{
                shape
                    .fill()
                    .foregroundColor(.white);
                shape.strokeBorder(lineWidth: 3);
                Text(card.content).font(.largeTitle)
            } else if card.isMatched{
               shape.opacity(0);
            }
            else {
                shape.fill();
            }
        }
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
