//
//  CreateRectangle.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/02/28.
//


import Foundation
//MARK: 기존 정적 팩토리 에서 -> 추상 생산자(protocol) 를 만들어 구상 생산자 (팩토리)를 구현
/*
기존 VC 에서 사각형 생성 버튼이 눌렸을때 정적 메소드가 호출되어 모델을 만들어주는 것은 -> Tightly coupled 했음.
따라서 추상 생산자 를 구현하여 VC 에 역주입 해줄 예정.
*/
protocol ModelProducible  {

    var propertyFactory : PropertyFactory? {get}
    
    func makeModel(type : Model.Type) -> Model
    func setPropertyFactory(_ propertyFactory : PropertyFactory)
}


class ModelFactory: ModelProducible {
    
    var propertyFactory : PropertyFactory?

    func setPropertyFactory(_ propertyFactory : PropertyFactory){
        
        self.propertyFactory = propertyFactory
    }
    
    func makeModel(type : Model.Type) -> Model {
        let model = type.init(propertyFactory: self.propertyFactory!)
        return model
    }
  
}

  

    
  
