//
//  Cardify.swift
//  Memorize
//
//  Created by Dudas Tamas Alex on 2023. 02. 03..
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp:Bool;
    
    func body(content: Content) -> some View{
        ZStack {
            let shape: RoundedRectangle = RoundedRectangle(cornerRadius:DrawingConstants.cornerRadius);
           if isFaceUp{
               shape
                   .fill()
                   .foregroundColor(.white);
               shape.strokeBorder(lineWidth: DrawingConstants.lineWidth);
               content
           }
           else {
               shape.fill();
           }
       }
    }
    private struct DrawingConstants{
        static let cornerRadius:CGFloat = 10.0;
        static let lineWidth:CGFloat = 3.0;
    }
}
extension View{
    func cardify(isFaceUp: Bool) -> some View{
        return self.modifier(Cardify(isFaceUp: isFaceUp));
    }
}
