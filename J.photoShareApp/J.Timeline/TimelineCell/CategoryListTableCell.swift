//
//  CategoryListTableCell.swift
//  J.photoShareApp
//
//  Created by JinYoung Lee on 29/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit

class CategoryListTableCell: UITableViewCell {
    @IBOutlet weak var collectionView: TimelineCollectionView!
    
    func setCategory(_ categoryFilter:String, section:Int) {
        collectionView.bindFilter(categoryFilter, section: section)
    }
}
