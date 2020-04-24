//
//  UIViewControllExtension.swift
//  J.AskingApp
//
//  Created by JinYoung Lee on 30/10/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit
import ImagePicker

extension UIViewController {
    func afterLogout() {
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVC"))
    }
    
    func moveToMainPage() {
        self.dismiss(animated: false, completion: nil)
        UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "mainTabbarVC")
    }
    
    func showAlert(title:String, message:String, closeListener:(()->Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.show(animated: true, vibrate: true, style: UIBlurEffect.Style.extraLight) {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1, execute: {
                alert.dismiss(animated: true, completion: closeListener)
            })
        }
    }
}

extension UIViewController: ImagePickerDelegate, ImageSelectDelegate {
    func openImagePicker() {
        let configure = Configuration()
        configure.doneButtonTitle = "완료"
        configure.allowPinchToZoom = true
        configure.allowMultiplePhotoSelection = false
        let imagePicker = ImagePickerController(configuration: configure)
        imagePicker.delegate = self
        imagePicker.imageLimit = 1
        present(imagePicker, animated: true, completion: nil)
    }
    
    public func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        selectImage(images.first)
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    public func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        selectImage(images.first)
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    public func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func selectImage(_ image: UIImage?) { }
}
