//
//  ContentView.swift
//  Memorize
//
//  Created by Dudas Tamas Alex on 2023. 01. 25..
//

// View

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]){
                    ForEach(viewModel.cards){ card in
                        CardView(card:card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture{
                                viewModel.choose(card);
                            }
                    }
                }
            }.foregroundColor(.red).padding(.horizontal)
        }
    }

struct CardView: View{
    let card:MemoryGame<String>.Card;
    
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
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
        ContentView(viewModel: game).preferredColorScheme(.dark)
    }
}
