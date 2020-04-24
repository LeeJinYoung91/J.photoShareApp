//
//  PostFetcher.swift
//  J.photoShareApp
//
//  Created by JinYoung Lee on 29/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore

class PostFetcher: BaseFetcher {
    private var loadedQuery:Query?
    private var lastSnapshot:DocumentSnapshot?
    
    override func loadModels() {
        if loadedQuery == nil {
            let filterCollection = filter ?? "default"
            loadedQuery = Firestore.firestore().collection(AppName).document(AppName).collection("Post").document("Category").collection(filterCollection).limit(to: COUNT_PER_LOAD).order(by: "regist_date", descending: true)
        }
        if let snapShot = lastSnapshot {
            loadedQuery = loadedQuery?.start(afterDocument: snapShot)
        }
        
        loadedQuery?.addSnapshotListener({ (querySnapShot, error) in
            guard error == nil, let shots = querySnapShot else {
                self.loadFail()
                return
            }

            self.lastSnapshot = shots.documents.last

            for document in shots.documents {
                if document.data()["image_url"] == nil {
                    continue
                }
                if let postModel = PostModel().initialize(id: document.data()["posting_id"] as! String, title: document.data()["posting_title"] as! String, content: document.data()["posting_content"] as! String, imagePath: document.data()["image_url"] as! String) {

                    if self.modelList != nil {
                        if !(self.modelList?.contains(where: { $0 as? PostModel == postModel }))! {
                            self.modelList?.append(postModel)
                        }
                    }
                }
            }
            self.loadSuccess()
        })
    }
}
