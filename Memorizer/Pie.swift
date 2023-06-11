//
//  Pie.swift
//  Memorizer
//
//  Created by Антон Нехаев on 28.08.2022.
//

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockWise = false
    
    func path(in rect: CGRect) -> Path {
        let centre = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: centre.x + radius * CGFloat(cos(startAngle.radians)),
            y: centre.y + radius * CGFloat(sin(startAngle.radians))
        )
//        let end = CGPoint(
//            x: centre.x + radius * CGFloat(cos(endAngle.radians)),
//            y: centre.y + radius * CGFloat(sin(endAngle.radians))
//        )
        
        var p = Path()
        
        p.move(to: centre)
        p.addLine(to: start)
//        p.addArc(tangent1End: start, tangent2End: end, radius: radius)
        p.addArc(center: centre,
                 radius: radius,
                 startAngle: startAngle,
                 endAngle: endAngle,
                 clockwise: !clockWise)
        p.addLine(to: centre)
        return p
    }
    
    
}
