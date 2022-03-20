//
//  RandomGenerator.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/11.
//

import Foundation

protocol PropertyProducible {
    
    var width : Double {get}
    var height : Double {get}
    var referencePoint : Point {get}
    var boarderSize : Size {get}

    func makeOriginPoint() -> Point
    func makeSize() -> Size
    func makeId() -> String
    func makeColor() -> Color
    func makeAlpha() -> Alpha
}


class PropertyFactory: PropertyProducible{
    
    let referencePoint: Point
    let boarderSize: Size
    let width: Double
    let height: Double

    init(referencePoint: Point , boarderSize : Size, width: Double, height : Double) {
        self.referencePoint = referencePoint
        self.boarderSize = boarderSize
        self.width = width
        self.height = height
    }
    
    func makeOriginPoint() -> Point {
        let x = Double.random(in: referencePoint.x ..< boarderSize.width - width)
        let y = Double.random(in: referencePoint.y ..< boarderSize.height - height)
        return Point(x: x, y: y)
    }
    
    func makeSize() -> Size {
        Size(width: width, height: height)
    }
    
    func makeId() -> String {
        var UUID = UUID().uuidString.components(separatedBy: "-")
        for i in 1..<4 {
            UUID[i].removeFirst()
        }
        return UUID[1..<4].joined(separator:"-")
    }
    
    func makeAlpha() -> Alpha {
        Alpha.allCases.randomElement()!
    }
    
    func makeColor() -> Color {
        let red = Double.random(in: 0..<255)
        let green = Double.random(in: 0..<255)
        let blue = Double.random(in: 0..<255)
        return Color(r: red, g: green, b: blue)
    }
    

    
}
