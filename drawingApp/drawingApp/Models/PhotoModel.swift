//
//  PhotoModel.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/16.
//

import Foundation


class PhotoModel : Model, AlphaModifiable{
    
    let photoData : Data?
    
    
    func updateAlpha (_ alpha: Alpha) {
        self.alpha = alpha
    }
    
    
    required init(propertyFactory: PropertyFactory) {
        let og = propertyFactory as? PhotoPropertyFactory
        self.photoData = og?.data
        super.init(propertyFactory: propertyFactory)
    }
    

}
