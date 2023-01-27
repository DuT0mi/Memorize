//
//  ContentView.swift
//  Memorize
//
//  Created by Dudas Tamas Alex on 2023. 01. 25..
//

import SwiftUI

struct ContentView: View {
    var emojis: Array<String> = ["🚗","🚕","🏎️","🚖","🚡","🚠","🚲","🛵","🚘","🚃","🚋","🚆","🛰️","🚁","⛵️","🛶","🚤","🛩️","🛥️","🛸","🚀"];
    @State var emojiCount: Int = 10;
    var body: some View {
        VStack{
            ScrollView { //For not smashing the buttons
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]){
                // With similar element in "emoji" does not work properly (cuz the similar string ID is the same
                ForEach(emojis[0..<emojiCount],id:\.self,content:{ emoji in
                    CardView(content:emoji).aspectRatio(2/3, contentMode: .fit) // 2 units width, 3 units high
                })
            }.foregroundColor(Color.red) // LazyGrid: fitting
        } // ScrollView
            Spacer(); // device independent
            HStack{
                add;
                Spacer();
                remove;
            }.padding(.horizontal).font(.largeTitle) // Bottom HStack
        } // VStack
         .padding(.horizontal)
    } // body View
    var remove: some View{
        return  Button(action: {
            if emojiCount > 1 {
                emojiCount -= 1;
                
            }
        }, label: {
            Image(systemName: "minus.circle");
        });
    }
    // more cleaner than "minus"
    var add: some View{
         Button{
            if emojiCount < emojis.count{
                emojiCount += 1;
            }
        }label: {
            Image(systemName: "plus.circle")
        };
    }
} // ContentView

struct CardView: View{
    var content: String;
    @State var isFaceUP: Bool = true;
    var body: some View{
        return ZStack {
            let shape: RoundedRectangle = RoundedRectangle(cornerRadius: 20.0);
            if isFaceUP{
                shape
                    .fill()
                    .foregroundColor(Color.white);
                
                shape.strokeBorder(lineWidth: 3) // For not cutting the edges (instead of stroke(...) )
                Text(content).font(.largeTitle)
            }
            else {
                shape.fill();
            }
        }.onTapGesture(perform: {
            // Also we could not to write out (perform)
            isFaceUP = !isFaceUP;
        })
    }
}
























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView().preferredColorScheme(.dark)
    }
}
