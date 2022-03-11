//
//  Utils.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/04.
//

import Foundation
import UIKit

extension Double {
    var trim : Double {
        Double(Int(ceil(self)))
    }
    
    var scaleRGB : Double {
        return self/255.0
    }

}

extension CGFloat {
    var trim : Double {
        let str = String(format: "%.0f", self)
        return Double(str)!
    }
}

extension Color {
    
    var tohexString : String {
        let rgb:Int = (Int)(self.red)<<16 | (Int)(self.green)<<8 | (Int)(self.blue)<<0
        return String(format:"#%06x", rgb)
    }
        
  
    
    
}
