//
//  LoginInfo.swift
//  J.AskingApp
//
//  Created by JinYoung Lee on 09/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation

class LoginInfo: NSObject {
    private var userName:String?
    var UserName:String {
        return userName!
    }
    private var userEmail:String?
    var UserEmail:String {
        return userEmail!
    }
    
    private var userId:String?
    var UserId:String {
        return userId!
    }
    
    init(name:String?, email:String?, id:String?) {
        userName = name
        userEmail = email
        userId = id
    }
    
    func setUserName(_ name:String?) {
        userName = name
    }
    
    func setUserEmail(_ email:String?) {
        userEmail = email
    }
    
    func setUserId(_ id:String?) {
        userId = id
    }
}
