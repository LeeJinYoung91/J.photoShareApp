//
//  PostModel.swift
//  J.photoShareApp
//
//  Created by JinYoung Lee on 29/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation

class PostModel: ContentBaseModel {
    private var imageUrl:URL?
    var ImageURL:URL {
        return imageUrl!
    }
    private var postTitle:String?
    var PostTitle:String {
        return postTitle!
    }
    private var postContent:String?
    var PostContent:String {
        return postContent!
    }
    
    func initialize(id:String, title:String, content:String, imagePath:String) -> PostModel? {
        let instance:PostModel? = super.initalize(id, type: .Post_Model) as? PostModel
        instance?.postTitle = title
        instance?.imageUrl = URL(string:imagePath)
        instance?.postContent = content
        return instance
    }
}
