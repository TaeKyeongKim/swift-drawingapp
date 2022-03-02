//
//  Color.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/02.
//

import Foundation
//Color (RGB) 타입 정의
struct Color : CustomStringConvertible {
    let red : Double
    let green : Double
    let blue : Double
    var description: String {
        return "R:\(red), G:\(green), B:\(blue)"
    }
    
    init(r:Double, g: Double, b:Double){
        //각각의 rgb 가 0~255 사이의 값이 아닐시
        var values = [r,g,b]
        for i in 0..<values.count {
            if values[i] < 0 {
                values[i] = 0.0
            }else if values[i] > 255 {
                values[i] = 255.0
            }
        }
        
        self.red = values[0]
        self.green = values[1]
        self.blue = values[2]
        
    }
    
}
