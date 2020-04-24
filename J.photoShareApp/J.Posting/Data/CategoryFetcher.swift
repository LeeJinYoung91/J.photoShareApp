//
//  CategoryFetcher.swift
//  J.photoShareApp
//
//  Created by JinYoung Lee on 29/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import FirebaseFirestore

class CategoryFetcher: BaseFetcher {
    private final let CategoryList:String = "CategoryList"
    
    override func loadModels() {
        Firestore.firestore().collection(AppName).document(AppName).collection(CategoryList).document(CategoryList).getDocument { (snapShot, error) in
            guard error == nil, let dataShot = snapShot?.data() else {
                self.loadFail()
                return
            }
            
            if let categoryList = dataShot["list"] as? [String] {
                self.modelList = categoryList
                self.loadSuccess()
            }
        }
    }
}
