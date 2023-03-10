//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Dudas Tamas Alex on 2023. 01. 29..
//

// ViewModel

import SwiftUI

class EmojiMemoryGame:ObservableObject {
    typealias Card = MemoryGame<String>.Card;
    
    private static let emojis = ["đ","đ","đī¸","đ","đĄ","đ ","đ˛","đĩ","đ","đ","đ","đ","đ°ī¸","đ","âĩī¸","đļ","đ¤","đŠī¸","đĨī¸","đ¸","đ"];
    private static func createMemoryGame()->MemoryGame<String>{
        MemoryGame<String>(numberOfPairsOfCards: 8 ){index in emojis[index]; };
    }
    @Published private var model = createMemoryGame();
    
    
    var cards: Array<Card>{
        return model.cards;
    }
    // MARK: - Intent(s)
    func choose(_ card: Card) -> Void{
        objectWillChange.send();
        model.choose(card);
    }
    func shuffle(){
        model.shuffle();
    }
    func restart(){
        model = EmojiMemoryGame.createMemoryGame();
    }
}
