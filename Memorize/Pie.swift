//
//  Pie.swift
//  Memorize
//
//  Created by momo on 2021/3/5.
//

import SwiftUI

struct Pie: Shape {

    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false

    var animatableData: AnimatablePair<Double, Double> {
        get {
            return AnimatablePair(startAngle.radians, endAngle.radians)
        }
        set {
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }

    func path(in rect: CGRect) -> Path {
        let center: CGPoint = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        var path = Path()
        path.move(to: center)
        path.addLine(
            to: CGPoint(
                x: center.x + radius * cos(CGFloat(startAngle.radians)),
                y: center.y + radius * sin(CGFloat(startAngle.radians))
            )
        )
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        path.move(to: center)
        return path
    }


}

struct Pie_Previews: PreviewProvider {
    static var previews: some View {
        Pie(startAngle: Angle.degrees(0 - 90),
            endAngle: Angle.degrees(110 - 90),
            clockwise: true)
            .foregroundColor(Color.orange)
            .padding()
    }
}
