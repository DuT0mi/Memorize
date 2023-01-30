//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Dudas Tamas Alex on 2023. 01. 25..
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame();   // free init
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game);
            
        }
    }
}























struct Previews_MemorizeApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
