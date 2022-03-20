//
//  Plane.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/02.
//

import Foundation
import OSLog

protocol ModelManagable {
    var models : [Model] {get}
    func selectModel(tapCoordinate: Point)
    func randomizeColorOnSelectedModel(modelFactory: ModelProducible?)
    func changeAlphaOnSelectedModel(to alpha: Alpha?)
    func addModel(modelFactory : ModelProducible?, modelType : Model.Type)
    subscript(index: UInt64) -> Model? {get}
    
}


class Plane : ModelManagable {

    

    private (set) var models = [Model]()
    {
        didSet {
            print(models)
        }
    }
    
    private var selectedModel : Model? {
        didSet {
            //pre -> false, current -> ture
            if selectedModel != oldValue {
                oldValue?.configureSelected(to: false)
            }
            NotificationCenter.default.post(name: .DidSelectModel, object: self, userInfo: [UserInfo.currentModel: selectedModel as Any, UserInfo.previousModel: oldValue as Any]
            )
        }
    }
    var numberOfModel : Int {
        self.models.count
        
    }
    subscript(index: UInt64) -> Model?{
        get {
            guard numberOfModel > index else {return nil}
            return models[Int(index)]
        }
    }
    
  
    
    func addModel(modelFactory : ModelProducible?, modelType : Model.Type) {
        guard let newModel = modelFactory?.makeModel(type: modelType) else {return}
        self.models.append(newModel)
        NotificationCenter.default.post(name: .DidMakeModel, object: self, userInfo: [UserInfo.model: newModel])
    }

    func selectModel(tapCoordinate: Point) {
        
        var detectedModel : Model?
        for model in models {
            let minX = model.point.x
            let minY = model.point.y
            let maxX = model.point.x + model.size.width
            let maxY = model.point.y + model.size.height
            
            if (minX <= tapCoordinate.x && maxX >= tapCoordinate.x && minY <= tapCoordinate.y && maxY >= tapCoordinate.y){
                model.toggleSelected()
                detectedModel = model
            }
        }
        selectedModel = detectedModel
    }
    
    func randomizeColorOnSelectedModel(modelFactory: ModelProducible?){
        guard let targetModel = selectedModel as? ColorModifiable , let factory = modelFactory else{return}
        targetModel.updateColor(factory.propertyFactory!.makeColor())
        NotificationCenter.default.post(name: .DidChangeColor, object: self, userInfo: [UserInfo.model : targetModel])
    }
    
    func changeAlphaOnSelectedModel(to alpha: Alpha?){
        guard let newAlpha = alpha , let targetModel = selectedModel as? AlphaModifiable else{return}
        targetModel.updateAlpha(newAlpha)
        NotificationCenter.default.post(name: .DidChangeAlpha, object: self, userInfo: [UserInfo.model : targetModel])
    }

}


