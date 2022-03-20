//
//  ViewFactory.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/18.
//

import Foundation
import UIKit

protocol ViewProducible {
    func make(model:Model) -> UIView 
}


struct ViewFactory : ViewProducible {

    func make(model : Model) -> UIView {
        let modelView = RectangleView(frame: CGRect(x: model.point.x.trim, y: model.point.y.trim, width: model.size.width, height: model.size.height))
        
        modelView.backgroundColor = UIColor(red: model.color.red.scaleRGB, green: model.color.green.scaleRGB, blue: model.color.blue.scaleRGB, alpha: model.alpha.scaledValue)
        return modelView
    }
}
       
