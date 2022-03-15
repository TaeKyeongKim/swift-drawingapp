//
//  Alpha.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/02.
//

import Foundation
//값이 낮을수록 투명함.
enum Alpha : Int , CustomStringConvertible , CaseIterable{
    case One = 1
    case Two
    case Three
    case Four
    case Five
    case Six
    case Seven
    case Eight
    case Nine
    case Ten
    case Opaque
    case Clear
    var description: String {
        "Alpha : \(self.rawValue)"
    }
    var scaledValue : Double {
        switch self {
        case .Clear :
            return 0.1
        case .One :
            return 0.1
        case .Two :
            return 0.2
        case .Three :
            return 0.3
        case .Four :
            return 0.4
        case .Five :
            return 0.5
        case .Six :
            return 0.6
        case .Seven :
            return 0.7
        case .Eight :
            return 0.8
        case .Nine :
            return 0.9
        case .Ten :
            return 1.0
        case .Opaque :
            return 1.0
        }
    }
    
   
}
