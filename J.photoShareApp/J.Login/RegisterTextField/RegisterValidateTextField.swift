//
//  RegisterValidateTextField.swift
//  J.AskingApp
//
//  Created by JinYoung Lee on 09/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit

class RegisterValidateTextField: UIView {
    @IBOutlet weak var fieldTitle: UILabel?
    @IBOutlet weak var inputField: UITextField?
    @IBOutlet weak var validateView: UIView?
    @IBOutlet weak var validateLabel: UILabel?
    @IBOutlet var containerView: UIView!
    var notEmpty:Bool = false
    var isValidate:Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initalizeFromViewLoad()
    }
    
    deinit {
        inputField?.removeTarget(self, action: #selector(onEditTextField(_:)), for: UIControl.Event.editingChanged)
    }
    
    func initalizeFromViewLoad() {
        Bundle.main.loadNibNamed("RegisterValidateTextField", owner: self, options: nil)
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        inputField?.addTarget(self, action: #selector(onEditTextField(_:)), for: UIControl.Event.editingChanged)
        validateView?.alpha = 0
    }
    
    @objc func onEditTextField(_ textField:UITextField) {
        guard let input = textField.text else {
            return
        }
        onValidate(input)
    }
    
    func onValidate(_ text:String) {
        guard !text.isEmpty else {
            isValidate = false
            notEmpty = false
            dismissValidateView()
            return
        }
        notEmpty = true
    }
    
    func noticeNonValidate() {
        validateView?.alpha = 1
    }
    
    func dismissValidateView() {
        validateView?.alpha = 0
    }
}
