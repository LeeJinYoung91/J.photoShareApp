//
//  BaseFetcher.swift
//  J.photoShareApp
//
//  Created by JinYoung Lee on 29/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit

enum Fetcher_Type {
    case Category
    case Post
}

class BaseFetcher: NSObject {
    
    let AppName:String = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    var modelList:[Any]?
    var Models:[Any]? {
        return modelList
    }
    var filter:String?
    private var dataLoadDelegateViewController:(DataLoadDelegate)?
    var COUNT_PER_LOAD: Int = {
        return 10
    }()
    private var fetcherType:Fetcher_Type?
    var FetcherType:Fetcher_Type {
        return fetcherType!
    }
    
    init(_ viewController:(DataLoadDelegate), fetchType:Fetcher_Type) {
        modelList = [Any]()
        fetcherType = fetchType
        dataLoadDelegateViewController = viewController
    }
    
    func bindLoadFilter(_ fil:String) {
        filter = fil
    }
    
    func loadModels() {}
    
    
    func loadSuccess() {
        dataLoadDelegateViewController?.loadSuccess(type: fetcherType!)
    }
    
    func loadFail() {
        dataLoadDelegateViewController?.loadFail(type: fetcherType!)
    }
}
