//
//  ChatUtil.swift
//  J.AskingApp
//
//  Created by JinYoung Lee on 31/10/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import FirebaseFirestore

class ChatUtil: NSObject {
    private let store = Firestore.firestore()
    private final let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    
    func addChatObserver(channelId:String, listener:(([(String, String, String, String)]) -> ())?) {
        store.collection(appName).document(appName).collection("channel").document(channelId).collection("message").addSnapshotListener { (snapShot, error) in
            if let documents = snapShot?.documents {
                var list:[(String, String, String, String)] = [(String, String, String, String)]()
                for doc in documents {
                    list.append((doc.data()["user_id"] as! String, doc.data()["user_name"] as! String, doc.data()["content"] as! String, doc.data()["regist_date"] as! String))
                }
                if list.count != 0 {
                    listener!(list)
                }
            }
        }        
    }
    
    func createNewChannel(channelName:String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd hh:mm:ss"
        let document = store.collection(appName).document(appName).collection("channel").document()
        document.setData([
            "name":channelName,
            "update":formatter.string(from: Date()),
            "id":document.documentID
            ])
    }
    
    func getChannelList(_ listener:(([(String, String, String)]) -> ())?) {
        store.collection(appName).document(appName).collection("channel").addSnapshotListener { (snapShot, error) in
            if let documents = snapShot?.documents {
                var list:[(String, String, String)] = [(String, String, String)]()
                for doc in documents {
                    list.append((doc.data()["name"] as! String, doc.data()["update"] as! String, doc.data()["id"] as! String))
                }
                if list.count != 0 {
                    listener!(list)
                }
            }
        }
    }
    
    func sendMessage(channelId:String, message:MessagingData) {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd hh:mm:ss"
        store.collection(appName).document(appName).collection("channel").document(channelId).collection("message").addDocument(data: [
            "content":message.content ?? "empty",
            "regist_date":formatter.string(from: Date()),
            "user_id":message.senderId ?? "empty",
            "user_name":message.senderName ?? "empty"
            ])
    }
}
