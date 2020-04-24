//
//  ChatChannelListCell.swift
//  J.AskingApp
//
//  Created by JinYoung Lee on 31/10/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit

class ChatChannelListCell: UITableViewCell {
    @IBOutlet weak var channelName:UILabel!
    @IBOutlet weak var updateDate:UILabel!
    @IBOutlet weak var backView: UIView!
    private var chData:ChannelData?
    private weak var viewController:UIViewController?
    private var longTapGestureRecognizer:UILongPressGestureRecognizer?
    
    var ChannelData:ChannelData {
        return chData!
    }
    
    override func awakeFromNib() {
        backView.layer.cornerRadius = 7
        backView.layer.masksToBounds = true
        longTapGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(onLongTap))
    }
    
    func bindData(_ data:ChannelData, parent:UIViewController) {
        chData = data
        channelName.text = data.channelName
        updateDate.text = data.updateDate
        viewController = parent
        guard let recognizer = longTapGestureRecognizer else {
            return
        }
        removeGestureRecognizer(recognizer)
        addGestureRecognizer(recognizer)
        
    }
    
    @objc private func onLongTap() {
        let alertVC = UIAlertController(title: "channel", message: "option", preferredStyle: .actionSheet)
        let ignoreAction = UIAlertAction(title: "ignore", style: .default) { [weak self] (action) in

        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        alertVC.addAction(ignoreAction)
        alertVC.addAction(cancelAction)
        viewController?.present(alertVC, animated: true, completion: nil)
    }
}
