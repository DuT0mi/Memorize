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
            let faceUpCardIndices = cards.indices.filter({ cards[$0].isFaceUp})
            return faceUpCardIndices.oneAndOnly;
        }
        set{
            for index in cards.indices {
                if index != newValue{   // newValue is a speical built in keyword ( cuz we can not use indexOfTheOneAndOnlyFaceUpCard in its own definition
                    cards[index].isFaceUp = false;
                }else{
                    cards[index].isFaceUp = true;
                }
            }
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
    init(numberOfPairsOfCards: Int, createCardContent: (Int)->CardContent){
        cards = [];
        // Add numberOfPairsOfCards * 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards{
            let content: CardContent = createCardContent(pairIndex);
            cards.append(Card(id:pairIndex * 2,content: content));
            cards.append(Card(id: pairIndex * 2 + 1,content: content));
        }
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
        if count == 1 {    // self because it is an Array; same as self.count
            return first;   // same as self.first
        }else{
            return nil;
        }
    }
}
