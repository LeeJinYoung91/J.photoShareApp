//
//  PostingDataModel.swift
//  J.photoShareApp
//
//  Created by JinYoung Lee on 28/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit

struct Posting_Data {
    var input_img:UIImage?
    var input_title:String?
    var input_content:String?
    var input_category:String?
    
    init(image:UIImage?, title:String?, content:String?, category:String?) {
        input_img = image
        input_title = title
        input_content = content
        input_category = category
    }
}

class PostingDataModel: NSObject {
    private var uploadImage:UIImage?
    private var imageId:String?
    private var title:String?
    private var content:String?
    private var category:String?
    
    init(data:Posting_Data) {
        uploadImage = data.input_img
        title = data.input_title
        content = data.input_content
        category = data.input_category
    }
}
