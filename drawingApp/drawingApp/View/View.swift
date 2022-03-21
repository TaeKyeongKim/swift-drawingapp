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
//    func setup(model : Model)
}


class View: UIImageView, ViewSelectable {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
        
    
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



