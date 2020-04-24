//
//  UserUtility.swift
//  J.AskingApp
//
//  Created by JinYoung Lee on 20/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import FirebaseFirestore

class UserUtility: NSObject {
    private final let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String

    func updateUserInfo(_ userInfo:LoginInfo) {
    }
    
    func getIgnoreChannelList(listener:@escaping (([String])->Void)) {
    }
}
