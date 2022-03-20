//
//  PhotoView.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/21.
//

import Foundation
import UIKit

class PhotoView : View , AlphaModifiable {
    func updateAlpha(_ alpha: Alpha) {
        self.alpha = alpha.scaledValue
    }
}
