//
//  ContentView.swift
//  Memorize
//
//  Created by Dudas Tamas Alex on 2023. 01. 25..
//

// View

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame;
    
    var body: some View {
        VStack{
            ScrollView { //For not smashing the buttons
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]){
                // With similar element in "emoji" does not work properly (cuz the similar string ID is the same
                    ForEach(viewModel.cards,content:{ card in
                        CardView(card:card)
                            .aspectRatio(2/3, contentMode: .fit) // 2 units width, 3 units high
                            .onTapGesture{
                                // Intents coming here
                                viewModel.choose(card);
                            }
                })
            }.foregroundColor(Color.red) // LazyGrid: fitting
        } // ScrollView
            Spacer(); // device independent Bottom HStack
        } // VStack
         .padding(.horizontal)
    } // body View
} // ContentView

struct CardView: View{
    let card:MemoryGame<String>.Card; // let cuz read only
    var body: some View{
        
        return ZStack {
            let shape: RoundedRectangle = RoundedRectangle(cornerRadius: 20.0);
            if card.isFaceUp{
                shape
                    .fill()
                    .foregroundColor(Color.white);// white is a static var in Color class
                
                shape.strokeBorder(lineWidth: 3) // For not cutting the edges (instead of stroke(...) )
                Text(card.content).font(Font.largeTitle) // .largrTitle is a static var in Font
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
