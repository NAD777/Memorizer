//
//  Cardify.swift
//  Memorizer
//
//  Created by Антон Нехаев on 29.08.2022.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFacedUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if isFacedUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
//                content
            } else {
                shape.fill()
            }
            content.opacity(isFacedUp ? 1 : 0)
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(isFacedUp: Bool) -> some View {
        self.modifier(Cardify(isFacedUp: isFacedUp))
    }
}
