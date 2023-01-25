//
//  ContentView.swift
//  Memorize
//
//  Created by Dudas Tamas Alex on 2023. 01. 25..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
         ZStack {
            RoundedRectangle(cornerRadius: 20.0)
                .stroke(lineWidth:3);
            Text("Hello There").foregroundColor(Color.orange);
            
        }.padding(.horizontal).foregroundColor(Color.red);

    }
}
























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
