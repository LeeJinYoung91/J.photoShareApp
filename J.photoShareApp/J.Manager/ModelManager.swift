//
//  ModelManager.swift
//  J.photoShareApp
//
//  Created by JinYoung Lee on 28/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
typealias Model_ID = String

class ModelManager: NSObject {
    enum Model_Type {
        case Post_Model
        case User_Model
    }
    
    private var modelContainer:[Model_Type:[Model_ID:ContentBaseModel]]?
    
    private static let instance = ModelManager()
    class func getInstance() -> ModelManager {
        return instance
    }
    
    override init() {
        super.init()
        initializeContainer()
    }
    
    private func initializeContainer() {
        modelContainer = [Model_Type.Post_Model:[Model_ID:ContentBaseModel]()]
    }
    
    func addContentModel(_ content:ContentBaseModel?, modelType:Model_Type) {
        guard let model = content else {
            fatalError("model is nil")
        }
        
        guard modelContainer?[modelType] != nil else {
            fatalError("not initialize modelCotnainer type: \(modelType)")
        }
        modelContainer?[modelType]![model.ID!] = model
    }
    
    func getContentModel(id:String?, modelType:Model_Type) -> ContentBaseModel? {
        guard let modelId = id else {
            return nil
        }
        
        if let model:ContentBaseModel = modelContainer![modelType]?[modelId] {
            return model
        }
        
        return nil
    }
}
