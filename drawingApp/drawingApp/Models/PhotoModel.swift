//
//  PhotoModel.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/16.
//

import Foundation


class PhotoModel : Model, AlphaModifiable{
    
    func updateAlpha (_ alpha: Alpha) {
        self.alpha = alpha
    }
}
