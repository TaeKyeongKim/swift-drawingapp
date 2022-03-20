//
//  RectangleView.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/03.
//

import UIKit

//RectangleView 와 PhotoView 는 ViewConfigurable 프로토콜을 채택.

protocol ViewSelectable {
    
    func select(isSelected : Bool)
}


class View: UIView, ViewSelectable {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
//    func updateColor(_ color: Color) {
//        self.backgroundColor = UIColor(red: color.red.scaleRGB, green: color.green.scaleRGB, blue: color.blue.scaleRGB, alpha: 0.1)
//        
//    }
//    
//    func updateAlpha(_ alpha: Alpha) {
//        self.alpha = alpha.scaledValue
//    }

    
    
    func select(isSelected : Bool){
        if isSelected {
            self.layer.borderWidth = 4
            self.layer.borderColor = UIColor.blue.cgColor
        }else{
            self.layer.borderWidth = 0
            self.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    
}

class RectangleView : View , AlphaModifiable , ColorModifiable{
    func updateColor(_ color: Color) {
        self.backgroundColor = UIColor(red: color.red.scaleRGB, green: color.green.scaleRGB, blue: color.blue.scaleRGB, alpha: 0.1)
        
    }
    
    func updateAlpha(_ alpha: Alpha) {
        self.alpha = alpha.scaledValue
    }

}

class PhotoView : View , AlphaModifiable {
    func updateAlpha(_ alpha: Alpha) {
        self.alpha = alpha.scaledValue
    }
}
