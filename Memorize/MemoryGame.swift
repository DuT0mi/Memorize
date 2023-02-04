//
//  MemoryGame.swift
//  Memorize
//
//  Created by Dudas Tamas Alex on 2023. 01. 29..
//

// Model

import Foundation

struct MemoryGame<CardContent> where CardContent:Equatable {
    private(set) var cards: Array<Card>;
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?{
        get{
            return cards.indices.filter({ cards[$0].isFaceUp}).oneAndOnly;
        }
        set{
            cards.indices.forEach({cards[$0].isFaceUp = ($0 == newValue)}) // index is $0
        }
    }
    
    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(where: {  $0.id == card.id }), !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched {
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                    
                    cards[chosenIndex].isMatched = true;
                    cards[potentialMatchIndex].isMatched = true;
                }
                cards[chosenIndex].isFaceUp = true;
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex;
            }
        }
    }
    mutating func shuffle(){
        cards.shuffle();
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int)->CardContent){
        cards = [];
        // Add numberOfPairsOfCards * 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards{
            let content: CardContent = createCardContent(pairIndex);
            cards.append(Card(id:pairIndex * 2,content: content));
            cards.append(Card(id: pairIndex * 2 + 1,content: content));
        }
        cards.shuffle();
    }
    struct Card: Identifiable {
        let id: Int;
        var isFaceUp = false;
        var isMatched = false;
        let content: CardContent
    }
}


extension Array{
    var oneAndOnly: Element? {
        if count == 1 {    // self because it is an Array
            return first;   // same as self.first
        }else{
            return nil;
        }
    }
}
