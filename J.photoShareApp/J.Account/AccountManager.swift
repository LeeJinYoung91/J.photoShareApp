//
//  AccountManager.swift
//  J.AskingApp
//
//  Created by JinYoung Lee on 31/10/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase
import FBSDKLoginKit

class AccountManager: NSObject {
    static let instance:AccountManager = AccountManager()
    private var userProfile:LoginInfo?
    var UserProfile:LoginInfo {
        return userProfile!
    }
    
    func tryLoginInFirebaseAuth(_ creditional: AuthCredential, listener:@escaping (_ has:Bool)-> ()) {
        Auth.auth().signInAndRetrieveData(with: creditional) { (authResult, error) in
            guard error == nil else {
                FBSDKLoginManager.init().logOut()
                listener(false)
                return
            }
            self.saveUserProfile(authResult?.additionalUserInfo?.profile)
            listener(true)
        }
    }
    
    func tryLoginInFirebaseAuth(email:String, password:String, listener:@escaping (_ has:Bool)-> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            guard error == nil else {
                listener(false)
                return
            }
            self.saveUserProfile(authResult?.user)
            listener(true)
        }
    }
    
    func tryRegister(email:String, nickname:String, password:String, listener:@escaping (_ success:Bool) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (authData, error) in
            guard error == nil else {
                listener(false)
                return
            }
            
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = nickname
            changeRequest?.commitChanges(completion: { (error) in
                guard error == nil else {
                    listener(false)
                    return
                }
                listener(true)
            })
        }
    }
    
    func processOnLogout(listener:@escaping(_ success:Bool)->()) {
        FBSDKLoginManager.init().logOut()
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            clearSavedUserProfile()
            listener(true)
        } catch _ as NSError {
            listener(false)
        }
    }
    
    func saveUserProfile(_ profile:[String:NSObject]?) {
        guard let uProfile = profile else {
            return
        }
        userProfile = LoginInfo(name: uProfile["name"] as? String, email: uProfile["email"] as? String, id: uProfile["id"] as? String)
    }
    
    func saveUserProfile(_ user:User?) {
        guard let loginedUser = user else {
            return
        }
        userProfile = LoginInfo(name: loginedUser.displayName, email: loginedUser.email, id: loginedUser.providerID)
    }
    
    private func clearSavedUserProfile() {
        userProfile = nil
    }
}
