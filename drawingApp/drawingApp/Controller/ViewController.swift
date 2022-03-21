//
//  ViewController.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/02/28.
//

import UIKit
import OSLog
import PhotosUI

class ViewController: UIViewController {
    
    //Model
    private var plane : ModelManagable?
    
    //Views
    private var rectangleGenerationButton : UIButton!
    private var photoGenerationButton : UIButton!
    private var panelView = PanelView()
    
    //Factories
    private var viewFactory : ViewProducible?
    private var modelFactory : ModelProducible?
    //PHPicker
    private var phpicker : PHPickerViewController!
    
    //View Constants
    let screenWdith = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let buttonWidth: Double = 130
    let buttonHeight: Double = 100
    let panelWidth : Double = 200
    
    
    //[Model : Configurable]
    private var modelViewList : [Model : View] = [:] {
        didSet {
            print("from modelList \(self) ")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.plane = Plane()
        
        setupLayout()
        setupSubViews()
        setupHandlers()
        addObservers()
        setupPHPicker()
        setupFactory(viewFactory: ViewFactory(), modelFactory: ModelFactory())
    }
    
    
    func setupSubViews() {
        view.addSubview(rectangleGenerationButton)
        view.addSubview(photoGenerationButton)
        view.addSubview(panelView)
    }
    
    func setupHandlers() {
        rectangleGenerationButton.addTarget(self, action: #selector(didTapRectangleButton), for:.touchUpInside)
        photoGenerationButton.addTarget(self, action: #selector(didTapPhotoButton), for:.touchUpInside)
        let tapGuestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapTriggered))
        tapGuestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGuestureRecognizer)
        panelView.colorRondomizeButton.addTarget(target, action: #selector(didTabColorRondomizeButton), for: .touchUpInside)
        panelView.alphaStepper.addTarget(target, action: #selector(didTabAlphaStepper), for: .valueChanged)
    }
    
    func setupLayout(){
        var rectangleButtonConfiguration = UIButton.Configuration.gray()
        rectangleButtonConfiguration.title = "사각형"
        rectangleButtonConfiguration.image = UIImage(systemName: "rectangle")
        rectangleButtonConfiguration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 40)
        rectangleButtonConfiguration.imagePlacement = .top
        rectangleGenerationButton = UIButton(configuration: rectangleButtonConfiguration, primaryAction: nil)
        rectangleGenerationButton.layer.borderWidth = 1
        rectangleGenerationButton.frame = CGRect(x: (screenWdith - panelWidth)/2 - (buttonWidth/2) - 30, y: screenHeight - buttonHeight, width: buttonWidth, height: buttonHeight)
        panelView.frame = CGRect(x: screenWdith - panelWidth, y: view.safeAreaInsets.top, width: panelWidth, height: screenHeight)
        
        var photoButtonConfiguration = UIButton.Configuration.gray()
        photoButtonConfiguration.title = "사진"
        photoButtonConfiguration.image = UIImage(systemName: "photo")
        photoButtonConfiguration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 40)
        photoButtonConfiguration.imagePlacement = .top
        photoGenerationButton = UIButton(configuration: photoButtonConfiguration, primaryAction: nil)
        photoGenerationButton.layer.borderWidth = 1
        photoGenerationButton.frame = CGRect(x: (screenWdith - panelWidth)/2 - (buttonWidth/2) + 100, y: screenHeight - buttonHeight, width: buttonWidth, height: buttonHeight)
        panelView.frame = CGRect(x: screenWdith - panelWidth, y: view.safeAreaInsets.top, width: panelWidth, height: screenHeight)
        
        
    }
    func setupPHPicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        self.phpicker = PHPickerViewController(configuration: configuration)
        phpicker.delegate = self
    }
    
    func setupFactory(viewFactory : ViewProducible, modelFactory : ModelProducible) {
        self.viewFactory = viewFactory
        self.modelFactory = modelFactory
        
    }
    
    //MARK: 사용자가 사각형 버튼을 누르면 plane 구역안에 뷰를 생성 시켜줄 팩토리 를 이용하여 모델생성 및 plane 에 추가.
    @objc func didTapRectangleButton() {
        self.modelFactory?.setPropertyFactory(PropertyFactory(referencePoint: Point(x: 0, y:20), boarderSize: Size(width: self.screenWdith - self.panelWidth, height: self.screenHeight - self.buttonHeight), width: 130, height: 120))
        plane?.addModel(modelFactory: modelFactory, modelType: RectangleModel.self)
    }
    
    //MARK: 사용자가 사진 버튼을 누르면 plane 구역안에 뷰를 생성 시켜줄 팩토리 를 이용하여 모델생성 및 plane 에 추가.
    @objc func didTapPhotoButton() {
        self.present(phpicker!, animated: true, completion: nil)
    }
    
    //MARK: 사용자가 ViewController 를 터치했을때 좌표를 기준으로 사각형을 찾음.
    @objc func tapTriggered(sender: UITapGestureRecognizer) {
        let tappedPoint = sender.location(in: self.view)
        plane?.selectModel(tapCoordinate : Point(x: tappedPoint.x, y: tappedPoint.y))
    }
    
    @objc func didTabColorRondomizeButton(sender: UIButton) {
        plane?.randomizeColorOnSelectedModel(modelFactory: modelFactory)
    }
    
    
    @objc func didTabAlphaStepper(sender: UIStepper) {
        plane?.changeAlphaOnSelectedModel(to: Alpha(rawValue: Int(sender.value)))
    }
    
    
    
    
    
    //MARK: Add Observers
    func addObservers () {
        //Plane 에서 오는 post 를 받을 옵저버 생성 및 액션 지정.
        NotificationCenter.default.addObserver(self, selector: #selector(createModelView), name: .DidMakeModel, object: plane
        )
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedModel), name: .DidSelectModel, object: plane
        )
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateModelView), name: .DidChangeColor, object: plane
        )
        NotificationCenter.default.addObserver(self, selector: #selector(updatePanelView), name: .DidChangeColor, object: plane
        )
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateModelView), name: .DidChangeAlpha, object: plane
        )
        NotificationCenter.default.addObserver(self, selector: #selector(updatePanelView), name: .DidChangeAlpha, object: plane
        )
    }
    
    
    @objc func createModelView(notification: Notification) {
        guard let newModel = notification.userInfo?[UserInfo.model] else {return}
        guard let model = newModel as? Model else {return}
        if let modelView = viewFactory?.make(model: model)  {
            modelViewList[model] = modelView as? View & ColorModifiable & AlphaModifiable
            view.addSubview(modelView)
        }
        
    }
    
    @objc func updateSelectedModel(notification: Notification) {
        guard let currentlySelectedModel = notification.userInfo?[UserInfo.currentModel] as? Model else {
            if let previouslySelectedModel = notification.userInfo?[UserInfo.previousModel] as? Model {
                updateHighlight(from: previouslySelectedModel)
            }
            panelView.setDefaultPanelValues()
            return
        }
        
        if let previouslySelectedModel = notification.userInfo?[UserInfo.previousModel] as? Model {
            updateHighlight(from: previouslySelectedModel)
        }
        updateHighlight(from: currentlySelectedModel)
        updatePanel(from: currentlySelectedModel)
    }
    
    
    @objc func updateModelView(notification: Notification) {
        guard let modifiedModel = notification.userInfo?[UserInfo.model] as? Model else {return}
        guard let modelView = modelViewList[modifiedModel] as? View & AlphaModifiable & ColorModifiable else {return}
        let colorChanged = notification.name == .DidChangeColor
        if colorChanged {
            modelView.updateColor(modifiedModel.color)
        }else{
            modelView.updateAlpha(modifiedModel.alpha)
        }
    }
    
    @objc func updatePanelView(notification: Notification) {
        guard let modifiedModel = notification.userInfo?[UserInfo.model] as? Model else {return}
        let colorChanged = notification.name == .DidChangeColor
        if colorChanged {
            panelView.updateRomdomizeColorButton(newColor: modifiedModel.color.tohexString)
        }else{
            panelView.updateAlpha(newAlphaValue: modifiedModel.alpha.scaledValue)
        }
    }
    
    
    //MARK: 사각형 뷰 선택에 따른 테두리 및 패널 뷰처리 함수.
    private func updateHighlight(from model: Model) {
        guard let modelView = modelViewList[model] else {return}
        modelView.select(isSelected: model.selectedStatus())
        
    }
    
    
    private func updatePanel(from model: Model) {
        if model.selectedStatus() {
            panelView.updateAlpha(newAlphaValue: model.alpha.scaledValue)
            panelView.updateRomdomizeColorButton(newColor: model.color.tohexString)
        }
        else{
            panelView.setDefaultPanelValues()
        }
    }
    
    //MARK: 색상, 알파 수정에 대한 뷰처리 함수.
//    private func manageAmendingViews(by model: Model, operation : (Model) -> ()){
//        return operation(model)
//    }
    
}

extension ViewController : PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard !results.isEmpty else {return}
        let itemProvider = results.first?.itemProvider
        itemProvider?.loadObject(ofClass: UIImage.self, completionHandler: {(object, error) in
            if let image = object as? UIImage {
                if let imageData = image.pngData() {
                    DispatchQueue.main.sync {
                        self.modelFactory?.setPropertyFactory(PhotoPropertyFactory(referencePoint: Point(x: 0, y:20), boarderSize: Size(width: self.screenWdith - self.panelWidth, height: self.screenHeight - self.buttonHeight), width: 130, height: 120, data: imageData))
                        
                        self.plane?.addModel(modelFactory: self.modelFactory, modelType: PhotoModel.self)
                    }
                }
            }
        })
        
    }
}


