//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Dudas Tamas Alex on 2023. 01. 29..
//

// ViewModel

import SwiftUI
// It is part of the UI bot not the View, thats is why I import SwiftUI

class EmojiMemoryGame:ObservableObject {
    private static let emojis: Array<String> = ["🚗","🚕","🏎️","🚖","🚡","🚠","🚲","🛵","🚘","🚃","🚋","🚆","🛰️","🚁","⛵️","🛶","🚤","🛩️","🛥️","🛸","🚀"];
    private static func createMemoryGame()->MemoryGame<String>{
        MemoryGame<String>(numberOfPairsOfCards: 6 ){index in emojis[index]; };
    }
    @Published private var model: MemoryGame<String> = createMemoryGame();
    
    
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards;
    }
    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) -> Void{
        objectWillChange.send();
        model.choose(card);
    }
}
