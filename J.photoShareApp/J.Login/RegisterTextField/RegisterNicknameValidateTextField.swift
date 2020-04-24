//
//  RegisterNicknameValidateTextField.swift
//  J.AskingApp
//
//  Created by JinYoung Lee on 09/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit

class RegisterNicknameValidateTextField: RegisterValidateTextField {
    override func initalizeFromViewLoad() {
        super.initalizeFromViewLoad()
        fieldTitle?.text = "Nickname"
        inputField?.placeholder = "enter your nickname"
        validateLabel?.text = "input collect nickname"
    }
        
    override func onValidate(_ text: String) {
        super.onValidate(text)
        guard notEmpty else {
            return
        }
        isValidate = text.isValidNickName()
        
        if isValidate {
            dismissValidateView()
        } else {
            noticeNonValidate()
        }
    }
}
