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
    static let emojis: Array<String> = ["🚗","🚕","🏎️","🚖","🚡","🚠","🚲","🛵","🚘","🚃","🚋","🚆","🛰️","🚁","⛵️","🛶","🚤","🛩️","🛥️","🛸","🚀"];
    static func createMemoryGame()->MemoryGame<String>{
        MemoryGame<String>(numberOfPairsOfCards: 4 ){index in emojis[index]; }; // Cuz they are emojis, "in" just separates the argument and the code which have to be executed
        // Also Swift knows the types, we can left thme behind (index:int), < -> String >, return too (before the emoji), and createCardContent: also
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
