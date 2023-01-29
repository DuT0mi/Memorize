//
//  MemoryGame.swift
//  Memorize
//
//  Created by Dudas Tamas Alex on 2023. 01. 29..
//

// Model

import Foundation


struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    
    mutating func choose(_ card: Card)-> Void{
        let chosenIndex = index(of:card);
        cards[chosenIndex].isFaceUp.toggle();   // isFaceUp = !isFaceUp (same as toggle())
    }
    func index(of card :Card) -> Int{
        for index in 0..<cards.count{
            if cards[index].id == card.id{
                return index;
            }
        }
                return 0;
    }
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
        var isFaceUp: Bool = true;
        var isMatched: Bool = true;
        var content: CardContent
    }
}
