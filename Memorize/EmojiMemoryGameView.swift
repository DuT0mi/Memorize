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
        VStack{
            gameBody;
            shuffle;
            }.padding()
        
        }
    @State private var dealt = Set<Int>() // Set is like HashSets in Java, there can not be ducplicated data in it
    private func deal(_ card:EmojiMemoryGame.Card){
        dealt.insert(card.id);
    }
    private func isUndealt(_ card: EmojiMemoryGame.Card)-> Bool{
        return !dealt.contains(card.id);
    }
    var gameBody: some View{
        AspectVGrid(items:game.cards, aspectRatio: 2/3){ card in
            cardView(for: card);
        }.onAppear{
            withAnimation{
                for card in game.cards{
                    deal(card);
                }
                
            }
        }
         .foregroundColor(.red)
    }
    var shuffle:some View{
        Button("Shuffle"){
            withAnimation(.easeInOut(duration: 1)){
                game.shuffle();
            } // Also works wout any argument
        }
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card)->some View{
        if isUndealt(card) || (card.isMatched && !card.isFaceUp){
            Color.clear
        }
        else{
            CardView(card)
                .padding(4)
                .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity)).animation(.easeInOut(duration: 2))
                .onTapGesture{
                    withAnimation{
                        game.choose(card);
                    }
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
        GeometryReader {
            geometry in
             ZStack {

                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90),clockwise: true).opacity(DrawingConstants.circleOpacity).padding(DrawingConstants.circlePadding);
                 Text(card.content)
                     .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                     .animation(Animation.easeInOut(duration: 2).repeatForever())
                     .font(Font.system(size: DrawingConstants.fontSystemConstant))
                     .scaleEffect(scale(thatFits:geometry.size))
            }
             .cardify(isFaceUp: card.isFaceUp);
        }
    }
    private func scale(thatFits size:CGSize)-> CGFloat{
        return min(size.width, size.height) / (DrawingConstants.fontSystemConstant/DrawingConstants.scaleFactor);
    }
    private func font(in size:CGSize)-> Font{
        Font.system(size: min(size.width,size.height) * DrawingConstants.scaleFactor);
    }
    private struct DrawingConstants{
        static let scaleFactor:CGFloat = 0.65;
        static let opacity:Double = 0;
        static let circleOpacity:Double = 0.5;
        static let circlePadding:CGFloat = 5;
        static let fontSystemConstant:CGFloat = 32.0;
    }
}

























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame();
       // game.choose(game.cards.first!); for testing
         EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
        EmojiMemoryGameView(game: game).preferredColorScheme(.dark)
    }
}
