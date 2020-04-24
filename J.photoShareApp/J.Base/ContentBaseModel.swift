//
//  ContentBaseModel.swift
//  J.photoShareApp
//
//  Created by JinYoung Lee on 28/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
class ContentBaseModel: NSObject {
    private var uniqueId:Model_ID?
    lazy var ID:Model_ID? = { [weak self] in
        return uniqueId
    }()
    
    func initalize(_ id:Model_ID, type:ModelManager.Model_Type) -> ContentBaseModel? {
        var instance = ModelManager.getInstance().getContentModel(id: id, modelType: type)
        if instance == nil {
            instance = self
            instance?.uniqueId = id
            ModelManager.getInstance().addContentModel(instance, modelType: type)
        }
        return instance
    }
}
