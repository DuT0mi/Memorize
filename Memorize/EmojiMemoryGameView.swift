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
    @Namespace private var dealingNamespace;
    var body: some View {
        ZStack(alignment: .bottom){
            VStack{
                gameBody;
                HStack{
                    restart;
                    Spacer();
                    shuffle;
                }.padding(.horizontal)
            }
            deckBody;
            }.padding()
        
        }
    @State private var dealt = Set<Int>() // Set is like HashSets in Java, there can not be ducplicated data in it
    private func deal(_ card:EmojiMemoryGame.Card){
        dealt.insert(card.id);
    }
    private func isUndealt(_ card: EmojiMemoryGame.Card)-> Bool{
        return !dealt.contains(card.id);
    }
    private func dealAnimation(for card:EmojiMemoryGame.Card) -> Animation{
        var delay = 0.0;
        if let index = game.cards.firstIndex(where: {$0.id == card.id}){
            delay = Double(index) * (CardConstants.totalDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay);
    }
    private func zIndex(of card:EmojiMemoryGame.Card)->Double{
        -Double(game.cards.firstIndex(where: {$0.id == card.id}) ?? 0);
    }
    var gameBody: some View{
        AspectVGrid(items:game.cards, aspectRatio: 2/3){ card in
            cardView(for: card);
        }
        .foregroundColor(CardConstants.color)
    }
    var shuffle:some View{
        Button("Shuffle"){
            withAnimation(.easeInOut(duration: 1)){
                game.shuffle();
            } // Also works wout any argument
        }
    }
    var restart:some View{
        Button("Restart") {
            withAnimation{
                dealt = [] // empty set
                game.restart();
            }
        }
    }
    var deckBody:some View{
        ZStack{
            ForEach(game.cards.filter(isUndealt)){
                card in CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace).transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture{
            for card in game.cards{
                withAnimation(dealAnimation(for: card)){
                    deal(card);
                }
            }
        }
    }
    private struct CardConstants{
        static let color = Color.red;
        static let aspectRation:CGFloat = 2/3;
        static let dealDuration:Double = 0.6;
        static let totalDuration:Double = 2;
        static let undealtHeight:CGFloat = 90;
        static let undealtWidth = undealtHeight * aspectRation;
    }
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card)->some View{
        if isUndealt(card) || (card.isMatched && !card.isFaceUp){
            Color.clear
        }
        else{
            CardView(card)
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .padding(4)
                .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                .zIndex(zIndex(of:card))
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
