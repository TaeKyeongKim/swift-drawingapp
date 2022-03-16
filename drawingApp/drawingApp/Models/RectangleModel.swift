//
//  RectangleModel.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/16.
//

import Foundation
class RectangleModel : Model , ColorModifiable , AlphaModifiable{
    func updateColor (_ color: Color) {
        self.color = color
    }
    
    func updateAlpha (_ alpha: Alpha) {
        self.alpha = alpha
    }
}
