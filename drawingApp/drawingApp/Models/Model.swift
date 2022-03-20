//
//  Rectangle.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/02/28.
//

/*
목적: 사각형 뷰를 표현하는 모델 클래스(class)를 설계한다.
요구사항 : 고유아이디(String), 크기(Width, Height), 위치(X, Y), 배경색(R, G, B), 투명도(Alpha)

고유아이디는 랜덤값으로 3자리-3자리-3자리 형태

크기는 CGSize를 사용하면 안되며, Double 타입을 기준으로 처리한다. 필요하면 Size 타입을 선언해도 된다.

위치는 CGPoint를 사용하면 안되며, Double 타입을 기준으로 처리한다. 필요하면 Point 타입을 선언해도 된다.

배경색도 UIColor나 CGClor를 사용하면 안되며, RGB 각각 0부터 255 사이 값으로 처리한다.

투명도는 1-10사이값으로 10단계로 표현한다.
*/

import Foundation
import OSLog

protocol Drawable {
    var id : String {get}
    var size : Size {get}
    var point : Point {get}
    var color : Color {get}
    var alpha : Alpha {get}

}

protocol Selectable {
    var isSelected : Bool {get}
    func toggleSelected()
    func configureSelected(to: Bool)
    func selectedStatus() -> Bool
}

protocol AlphaModifiable {
    func updateAlpha (_ alpha: Alpha)
}
protocol ColorModifiable {
    func updateColor (_ color: Color)
}




//뷰에 나타날 사각형의 데이터.
class Model : Drawable, Selectable {
   
    let id : String
    let size : Size
    let point : Point
    var color : Color {
        didSet {
            os_log(.debug, "모델 색상 변경감지: \(oldValue) -> \(self.color)")
        }
    }
    var alpha : Alpha {
        didSet {
            os_log(.debug, "모델 알파 변경감지: \(oldValue) -> \(self.alpha)")
        }
    }

    private (set) var isSelected = false
    
    required init(propertyFactory : PropertyFactory) {
        self.id = propertyFactory.makeId()
        self.size = propertyFactory.makeSize()
        self.point = propertyFactory.makeOriginPoint()
        self.color = propertyFactory.makeColor()
        self.alpha = propertyFactory.makeAlpha()
    }
  
    
    func toggleSelected(){
        self.isSelected = !isSelected
    }
    
    func configureSelected(to newState: Bool){
        self.isSelected = newState
    }
    
    func selectedStatus() -> Bool {
        isSelected
    }
    
   
    
}


//형태 : (fxd-0fz-4b9), X:10,Y:200, W150, H120, R:245, G:0, B:245, Alpha: 9
extension Model : CustomStringConvertible {
    var description: String {
        return "(\(id)), \(point), \(size), \(color), \(alpha)"
    }
}

//비교가능 하게 만들기
extension Model : Equatable {
    static func == (lhs: Model, rhs: Model) -> Bool {
        return lhs.id == rhs.id
    }
}
//hash 값 생성
extension Model : Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}







