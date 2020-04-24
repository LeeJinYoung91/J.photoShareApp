//
//  DataLoadDelegate.swift
//  J.photoShareApp
//
//  Created by JinYoung Lee on 29/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation

protocol DataLoadDelegate {
    func loadSuccess(type:Fetcher_Type)
    func loadFail(type:Fetcher_Type)
}
