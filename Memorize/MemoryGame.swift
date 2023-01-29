//
//  MemoryGame.swift
//  Memorize
//
//  Created by Dudas Tamas Alex on 2023. 01. 29..
//

// Model

import Foundation

struct MemoryGame<CardContent> where CardContent:Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?;
    
    
    mutating func choose(_ card: Card)-> Void{
        // same as if let chosenIndex = index(of: card)
        if let chosenIndex = cards.firstIndex(where: {  $0.id == card.id }), cards[chosenIndex].isFaceUp,!cards[chosenIndex].isMatched {   // aCardInTheCardsArray in aCardInTheCardsArray.id == card.id
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                    cards[chosenIndex].isMatched = true;
                    cards[potentialMatchIndex].isMatched = true;
                }
                indexOfTheOneAndOnlyFaceUpCard = nil;
            } else {
                for index in cards.indices { // same as 0..<cards.count
                    cards[index].isFaceUp = false;
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex;
            }
            cards[chosenIndex].isFaceUp.toggle();
        }
    }
    /*
    func index(of card :Card) -> Int? {
        for index in 0..<cards.count{
            if cards[index].id == card.id{
                return index;
            }
        }
                return nil;
    }
     */
    init(numberOfPairsOfCards: Int, createCardContent: (Int)->CardContent){
        cards = Array<Card>();
        // Add numberOfPairsOfCards * 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards{
            let content: CardContent = createCardContent(pairIndex);
            cards.append(Card(id:pairIndex * 2,content: content));
            cards.append(Card(id: pairIndex * 2 + 1,content: content));
        }
        
    }
    // By nesting it, it declares that a card in a card game, not just a card
    struct Card: Identifiable {
        var id: Int;
        var isFaceUp: Bool = false;
        var isMatched: Bool = true;
        var content: CardContent
    }
}
