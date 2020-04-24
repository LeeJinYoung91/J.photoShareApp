//
//  UIController.swift
//  J.photoShareApp
//
//  Created by JinYoung Lee on 29/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import SVProgressHUD

class UIController: NSObject {
    func showProgressIndicator() {
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.show()
    }
    
    func hideProgressIndicator(_ completion:(()->Void)?) {
        SVProgressHUD.dismiss(completion: completion)
    }
}
