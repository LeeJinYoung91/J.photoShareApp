//
//  ChatCell.swift
//  J.AskingApp
//
//  Created by JinYoung Lee on 31/10/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit

class ChatCell: UITableViewCell {
    @IBOutlet weak var userImage:UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var chatText:UILabel!
    @IBOutlet weak var bubblePod: UIView!
    @IBOutlet weak var bubbleImageView:UIImageView!
    private var userId:String?
    
    override func awakeFromNib() {
        chatText.numberOfLines = 0
        bubblePod.layer.cornerRadius = 6
        bubblePod.layer.masksToBounds = true
    }
    
    func bindData(_ data:ChatData) {
        userId = data.userId
        userImage.image = UIImage(named:"icon_userImage")
        userName.text = data.userName
        chatText.text = data.chat
        layoutIfNeeded()
    }
}
