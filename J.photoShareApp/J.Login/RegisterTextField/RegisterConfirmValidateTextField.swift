//
//  RegisterConfirmValidateTextField.swift
//  J.AskingApp
//
//  Created by JinYoung Lee on 09/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit

class RegisterConfirmValidateTextField: RegisterValidateTextField {
    var passwordValidateField:RegisterPasswordValidateTextField?
    override func initalizeFromViewLoad() {
        super.initalizeFromViewLoad()
        fieldTitle?.text = "Confirm"
        inputField?.placeholder = "reenter password"
        validateLabel?.text = "input same password"
    }
    
    func bindPasswordValidateField(_ field: RegisterPasswordValidateTextField) {
        passwordValidateField = field
    }
    
    override func onValidate(_ text: String) {
        super.onValidate(text)
        guard notEmpty else {
            return
        }
        
        guard let compareInputText = passwordValidateField?.inputField?.text else {
            return
        }
        
        guard !compareInputText.isEmpty else {
            return
        }
        
        guard (passwordValidateField?.isValidate)! else {
            return
        }
        
        isValidate = text.elementsEqual(compareInputText)
        if isValidate {
            dismissValidateView()
        } else {
            noticeNonValidate()
        }
    }
}
