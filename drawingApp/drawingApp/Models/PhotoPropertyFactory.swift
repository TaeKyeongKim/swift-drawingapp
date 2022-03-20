//
//  PhotoPropertyFactory.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/18.
//

import Foundation


protocol BinaryDataStorable {
    var data : Data? {get}
}


class PhotoPropertyFactory : PropertyFactory, BinaryDataStorable{
    
    let data : Data?
    
    override func makeColor() -> Color {
        return Color(r: 255, g: 255, b: 255)
    }
    
    init(referencePoint: Point , boarderSize : Size, width: Double, height : Double, data: Any) {
        self.data = data as? Data
        super.init(referencePoint: referencePoint, boarderSize: boarderSize, width: width, height: height)
    }
    
}

