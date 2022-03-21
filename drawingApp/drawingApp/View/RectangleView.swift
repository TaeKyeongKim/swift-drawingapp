//
//  RectangleView.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/21.
//

import Foundation
import UIKit

class RectangleView : View , AlphaModifiable , ColorModifiable{
    
    func updateColor(_ color: Color) {
        self.backgroundColor = UIColor(red: color.red.scaleRGB, green: color.green.scaleRGB, blue: color.blue.scaleRGB, alpha: self.alpha)
    }
    
    func updateAlpha(_ alpha: Alpha) {
        self.alpha = alpha.scaledValue
    }
    
    

}
