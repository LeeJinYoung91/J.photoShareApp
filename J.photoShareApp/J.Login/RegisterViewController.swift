//
//  RegisterViewController.swift
//  J.AskingApp
//
//  Created by JinYoung Lee on 09/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailView: RegisterEmailValidateTextField!
    @IBOutlet weak var nicknameView: RegisterNicknameValidateTextField!
    @IBOutlet weak var passwordView: RegisterPasswordValidateTextField!
    @IBOutlet weak var confirmView: RegisterConfirmValidateTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmView.bindPasswordValidateField(passwordView)
        passwordView.bindConfirmTextField(confirmView)
    }
    
    @IBAction func onClickBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickNextButton(_ sender: Any) {
        if emailView.isValidate && nicknameView.isValidate && passwordView.isValidate && confirmView.isValidate {
            AccountManager.instance.tryRegister(email: (emailView.inputField?.text)!, nickname: (nicknameView.inputField?.text)!, password: (passwordView.inputField?.text)!, listener: { [weak self](success) in
                if success {
                    AccountManager.instance.tryLoginInFirebaseAuth(email: (self?.emailView.inputField?.text)!, password: (self?.passwordView.inputField?.text)!, listener: { [weak self] (success) in
                        if success {
                            self?.moveToMainPage()
                        }
                    })
                }
            })
        }
    }
}
