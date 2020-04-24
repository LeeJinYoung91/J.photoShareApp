//
//  TimelineCategoryHeaderCell.swift
//  J.photoShareApp
//
//  Created by JinYoung Lee on 29/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit

class TimelineCategoryHeaderCell: UITableViewCell {
    @IBOutlet weak var backgroundImageView:UIImageView!
    @IBOutlet weak var categoryTitleLabel:UILabel!
    
    func setCategory(_ category:String) {
        categoryTitleLabel.text = category
    }
}
