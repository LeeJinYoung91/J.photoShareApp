//
//  TimelineCollectionView.swift
//  J.photoShareApp
//
//  Created by JinYoung Lee on 29/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit

class TimelineCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, DataLoadDelegate {
    private var fetchers:[Int:PostFetcher] = [Int:PostFetcher]()
    private var postList:[PostModel] = [PostModel]()
    private var currentSection:Int = 0
    private let Count_Load_Needs_More = 2
    private let Between_Cell_Margin = 8
    
    func bindFilter(_ filter:String, section:Int) {
        currentSection = section
        if let curFetcher = fetchers[section] {
            if let posts = curFetcher.Models as? [PostModel] {
                postList = posts
                reloadData()
            }
        } else {
            reloadData()
            createFetcher(filter: filter)
        }
        
        self.delegate = self
        self.dataSource = self
    }
    
    private func createFetcher(filter:String) {
        let fetcher = PostFetcher(self, fetchType: .Post)
        fetcher.bindLoadFilter(filter)
        fetcher.loadModels()
        fetchers[currentSection] = fetcher
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "id_photoReuseCell", for: indexPath) as? PhotoTimelineCell
        cell?.bindPostData(postList[indexPath.row])
        loadModelIfNeed(indexPath)
        return cell!
    }
    
    private func loadModelIfNeed(_ indexPath:IndexPath) {
        if let modelCount = fetchers[currentSection]?.Models?.count {
            if indexPath.row + Count_Load_Needs_More == modelCount {
                fetchers[currentSection]?.loadModels()
            }
        }
    }    
    
    func loadSuccess(type: Fetcher_Type) {
        guard type == .Post else {
            return
        }
        
        if let posts = fetchers[currentSection]?.Models as? [PostModel] {
            postList = posts
        }
        reloadData()
    }
    
    func loadFail(type: Fetcher_Type) {
        guard type == .Post else {
            return
        }
        reloadData()
    }
}
