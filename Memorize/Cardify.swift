//
//  Cardify.swift
//  Memorize
//
//  Created by Dudas Tamas Alex on 2023. 02. 03..
//

import SwiftUI

struct Cardify: AnimatableModifier { // Both of: Animatable and ViewModifier
    
    var rotation: Double; // in degrees
    var animatableData: Double {
        get{rotation;}
        set{rotation = newValue;}
    };
    
    init(isFaceUp:Bool){
        rotation = isFaceUp ? 0 : 180;
    }
    
    func body(content: Content) -> some View{
        ZStack {
            let shape: RoundedRectangle = RoundedRectangle(cornerRadius:DrawingConstants.cornerRadius);
           if rotation < 90{
               shape
                   .fill()
                   .foregroundColor(.white);
               shape.strokeBorder(lineWidth: DrawingConstants.lineWidth);
               // content; // On-screen when isFaceUp is true else will be off-screen
           }
           else {
               shape.fill();
           }
            content
                .opacity(rotation < 90 ? 1 : 0) // Now it is always on-screen, just a small tricky play with the opacity
       }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0)) // just the y axis
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
