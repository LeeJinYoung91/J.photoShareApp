//
//  RegisterPasswordValidateTextField.swift
//  J.AskingApp
//
//  Created by JinYoung Lee on 09/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit

class RegisterPasswordValidateTextField: RegisterValidateTextField {
    private var confirmTextField:RegisterConfirmValidateTextField?
    override func initalizeFromViewLoad() {
        super.initalizeFromViewLoad()
        fieldTitle?.text = "Password"
        inputField?.placeholder = "enter your password"
        validateLabel?.text = "input collect password"
    }
    
    func bindConfirmTextField(_ field:RegisterConfirmValidateTextField) {
        confirmTextField = field
    }
    
    override func onValidate(_ text: String) {
        super.onValidate(text)
        guard notEmpty else {
            return
        }
        isValidate = text.isValidPassword()
        if let field = confirmTextField, let confirmInputText = field.inputField?.text {
            confirmTextField?.onValidate(confirmInputText)
        }
        
        if isValidate {
            dismissValidateView()
        } else {
            noticeNonValidate()
        }
    }
}
