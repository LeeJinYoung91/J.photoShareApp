//
//  ChatData.swift
//  J.AskingApp
//
//  Created by JinYoung Lee on 30/10/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit

struct ChatData {
    var userId:String?
    var userName:String?
    var chat:String?
    var regitDate:String?
    
    init(id:String?, name:String?, text:String?, date:String?) {
        userId = id
        userName = name
        chat = text
        regitDate = date
    }
}

struct ChannelData {
    var channelName:String?
    var updateDate:String?
    var channelId:String?
    
    init(name:String?, update:String?, id:String?) {
        channelName = name
        updateDate = update
        channelId = id
    }
}

struct MessagingData {
    let senderName:String?
    let senderId:String?
    let regitDate:String?
    var content:String?
    
    init(text:String?) {
        senderName = AccountManager.instance.UserProfile.UserName
        senderId = AccountManager.instance.UserProfile.UserId        
        content = text
        regitDate = "지금"
    }
}
