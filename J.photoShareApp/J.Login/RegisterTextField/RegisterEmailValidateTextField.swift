//
//  RegisterEmailValidateTextField.swift
//  J.AskingApp
//
//  Created by JinYoung Lee on 09/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit

class RegisterEmailValidateTextField: RegisterValidateTextField {
    override func initalizeFromViewLoad() {
        super.initalizeFromViewLoad()
        fieldTitle?.text = "E-mail"
        inputField?.placeholder = "enter your email"
        validateLabel?.text = "input collect email address"
    }
    
    override func onValidate(_ text: String) {
        super.onValidate(text)
        guard notEmpty else {
            return
        }
        isValidate = text.isValidEmail()
        if isValidate {
            dismissValidateView()
        } else {
            noticeNonValidate()
        }
    }
}
