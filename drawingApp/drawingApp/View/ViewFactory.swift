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
    
//    let typeList : =
    
    func make(model : Model) -> UIView {
        
        print(type(of: model.self))
            
        let modelView = View(frame: CGRect(x: model.point.x.trim, y: model.point.y.trim, width: model.size.width, height: model.size.height))
        
        
        modelView.backgroundColor = UIColor(red: model.color.red.scaleRGB, green: model.color.green.scaleRGB, blue: model.color.blue.scaleRGB, alpha: model.alpha.scaledValue)
        
//        modelView.image = UIImage(data: model!.photoData!)
        
        return modelView
    }
}
       
