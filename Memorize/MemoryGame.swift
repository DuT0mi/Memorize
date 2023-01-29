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
    
    func choose(_ card: Card)-> Void{
        
    }
    init(numberOfPairsOfCards: Int, createCardContent: (Int)->CardContent){
        cards = Array<Card>();
        // Add numberOfPairsOfCards * 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards{
            let content: CardContent = createCardContent(pairIndex);
            cards.append(Card(isFaceUp: false, isMatched: false, content: content));
            cards.append(Card(isFaceUp: false, isMatched: false, content: content));
        }
        
    }
    struct Card {
        // By nesting it, it declares that a card in a card game, not just a card
        var isFaceUp: Bool = false;
        var isMatched: Bool = false;
        var content: CardContent
    }
}
