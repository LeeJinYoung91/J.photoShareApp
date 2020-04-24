//
//  PostingViewController.swift
//  J.photoShareApp
//
//  Created by JinYoung Lee on 28/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit
import ImagePicker

class PostingViewController: UIViewController, DataLoadDelegate {
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var titleBackgroundView: UIView!
    @IBOutlet weak var categoryBackgroundView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var inputBodyField: UITextView!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var bottomMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var categoryLabel: UILabel!
    
    private final let TextView_BottomMargin:CGFloat = 8
    private var categoryList:[String]?
    private var loadFetcher:CategoryFetcher?
    private var categorySelected:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
        addTapGestureRecognizer()
        setUpKeyboard()
        setObserver()
        loadCategoryList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    private func initializeUI() {
        titleBackgroundView.layer.borderWidth = 1
        titleBackgroundView.layer.borderColor = UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1).cgColor
        categoryBackgroundView.layer.borderWidth = 1
        categoryBackgroundView.layer.borderColor = UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1).cgColor
        inputBodyField.layer.borderWidth = 1
        inputBodyField.layer.borderColor = UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1).cgColor
        categoryLabel.text = "카테고리를 선택하세요."
    }
    
    private func addTapGestureRecognizer() {
        selectedImageView.isUserInteractionEnabled = true
        categoryBackgroundView.isUserInteractionEnabled = true
        selectedImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickImageView)))
        categoryBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickCategoryView)))
    }
    
    private func setObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    private func loadCategoryList() {
        loadFetcher = CategoryFetcher(self, fetchType:.Category)
        loadFetcher?.loadModels()
    }
    
    private func setUpKeyboard() {
        let toolBarKeyboard = UIToolbar()
        let btnDoneBar = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonClick))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolBarKeyboard.items = [flexibleSpace, btnDoneBar]
        toolBarKeyboard.tintColor = UIColor.black
        toolBarKeyboard.sizeToFit()
        titleTextField.inputAccessoryView = toolBarKeyboard
        inputBodyField.inputAccessoryView = toolBarKeyboard
    }
    
    @objc func keyboardWillShow(notification:Notification) {
        if let userInfo = notification.userInfo {
            var iphoneXSafeAfrea:CGFloat = 0
            if UIDevice.current.userInterfaceIdiom == .phone {
                if UIScreen.main.nativeBounds.height == 2436 { // case iphoneX
                    iphoneXSafeAfrea = self.view.safeAreaInsets.bottom
                }
            }
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? TextView_BottomMargin
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                bottomMarginConstraint?.constant = TextView_BottomMargin
            } else {
                if let endfr = endFrame?.size.height {
                    bottomMarginConstraint?.constant = endfr - (iphoneXSafeAfrea - TextView_BottomMargin)
                }
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    @objc private func doneButtonClick() {
        if titleTextField.canResignFirstResponder {
            titleTextField.resignFirstResponder()
        }
        if inputBodyField.canResignFirstResponder {
            inputBodyField.resignFirstResponder()
        }
    }
    
    @objc private func onClickImageView() {
        openImagePicker()
    }
    
    @objc private func onClickCategoryView() {
        guard let list = categoryList else {
            return
        }
        
        let alertView = UIAlertController(title: "카테고리 선택", message: "카테고리 목록", preferredStyle: .alert)
        let value:PickerViewViewController.Values = [list.map({ $0 })]
        var selectValue:PickerViewViewController.Index?
        if let input = categoryLabel.text {
            var idx = 0
            for item in list {
                if item.elementsEqual(input) {
                    selectValue = (column: 0, row: list.indexes(of: item).first ?? 0)
                    break
                }
                idx += 1
            }
        }
        
        alertView.addPickerView(values: value, initialSelection: selectValue) { [weak self] (viewController, pickerView, index, values) in
            self?.categorySelected = true
            self?.categoryLabel.text = value.first?[index.row]
            alertView.dismiss(animated: true, completion: nil)
        }
        alertView.show(animated: true, vibrate: false, style: UIBlurEffect.Style.prominent, completion: nil)
    }
    
    @objc override func selectImage(_ image: UIImage?) {
        selectedImageView.image = image
    }
    @IBAction func onClickUpload(_ sender: Any) {
        if (titleTextField.text?.isEmpty)! || inputTextView.text.isEmpty || !categorySelected || selectedImageView.image == nil {
            showAlert(title: "에러", message: "비어있는 필드가 있습니다", closeListener: nil)
            return
        }
        
        UIController().showProgressIndicator()
        PostUploader().startUpload(Posting_Data(image: selectedImageView.image, title: titleTextField.text, content: inputBodyField.text, category: categoryLabel.text), listener: {(success) in
            UIController().hideProgressIndicator({
                if success {
                    self.showAlert(title: "성공", message: "업로드 완료") {
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    self.showAlert(title: "에러", message: "뭔가 문제가;;..", closeListener: nil)
                }
            })
        })
    }
    
    func loadSuccess(type: Fetcher_Type) {
        guard let models = loadFetcher?.Models else {
            showAlert(title: "에러", message: "뭔가 문제가;;..", closeListener: nil)
            return
        }
        if let list = models as? [String] {
            categoryList = list
        }
    }
    
    func loadFail(type: Fetcher_Type) {
        showAlert(title: "에러", message: "뭔가 문제가;;..", closeListener: nil)
    }    
}
