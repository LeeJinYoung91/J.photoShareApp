//
//  ChatViewController.swift
//  J.AskingApp
//
//  Created by JinYoung Lee on 30/10/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private final let Side_Margin:CGFloat = 20.0
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var textFieldViewBottomConstraint: NSLayoutConstraint!
    private var channelData:ChannelData?
    var messageList:[ChatData] = [ChatData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
        setUpTableView()
        setNavigationItem()
        getMessageListOfCurrentChannel()
        addNotification()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func getMessageListOfCurrentChannel() {
        reloadAll()
        guard let channelId = channelData?.channelId else {
            return
        }
        
        ChatUtil().addChatObserver(channelId: channelId) { [weak self] (list) in
            self?.messageList.removeAll()
            for data in list {
                self?.messageList.append(ChatData(id: data.0, name: data.1, text: data.2, date: data.3))
            }
            self?.messageList.sort(by: { (current, next) -> Bool in
                return (current.regitDate)! < (next.regitDate)!
            })
            self?.tableView.reloadData()
            self?.scrollToBottom()
        }
    }
    
    private func scrollToBottom() {
        guard messageList.count != 0 else {
            return
        }
        let scrollPath = IndexPath(row: messageList.count - 1 , section: 0)
        tableView.scrollToRow(at: scrollPath, at: .bottom, animated: false)
    }
    
    private func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                textFieldViewBottomConstraint?.constant = 0.0
            } else {
                if let height = endFrame?.size.height {
                    textFieldViewBottomConstraint?.constant = height - view.safeAreaInsets.bottom
                }
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    private func reloadAll() {
        messageList.removeAll()
        tableView.reloadData()
    }
    
    func setChannelData(_ data:ChannelData) {
        channelData = data
    }
    
    private func setNavigationItem() {
        navigationItem.title = channelData?.channelName
    }
    
    private func initializeUI() {
        sendButton.layer.masksToBounds = true
        sendButton.layer.cornerRadius = sendButton.bounds.width / 4
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ChatCell?
        if messageList[indexPath.row].userId == AccountManager.instance.UserProfile.UserId {
            cell = tableView.dequeueReusableCell(withIdentifier: "chat_me", for: indexPath) as? ChatCell
            
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "chat_other", for: indexPath) as? ChatCell
        }
        
        cell?.bindData(ChatData(id: messageList[indexPath.row].userId, name: messageList[indexPath.row].userName, text: messageList[indexPath.row].chat, date: messageList[indexPath.row].regitDate))
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    @IBAction func onClickSend(_ sender: Any) {
        ChatUtil().sendMessage(channelId: (channelData?.channelId)!, message: MessagingData(text: textField.text))
        clearAndResignTextField()
        tableView.reloadData()
        scrollToBottom()
    }
    
    private func clearAndResignTextField() {
        textField.text = ""
        textField.resignFirstResponder()
    }
}
