//
//  PhotoTimelineCell.swift
//  photoShareApp
//
//  Created by JinYoung Lee on 28/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit

class PhotoTimelineCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        
    }
    
    func bindPostData(_ postData:PostModel) {
        titleLabel.text = postData.PostTitle
        NetworkRequest().loadImage(url: postData.ImageURL) { (success, img) in
            self.thumbnailView.image = img
        }
    }
}
