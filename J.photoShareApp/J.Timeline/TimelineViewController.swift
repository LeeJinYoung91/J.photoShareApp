//
//  TimelineViewController.swift
//  J.photoShareApp
//
//  Created by JinYoung Lee on 29/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//
import Foundation
import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DataLoadDelegate {
    @IBOutlet weak var tableView: UITableView!
    private var categoryList:[String] = [String]()
    private var categoryFetcher:CategoryFetcher?
    private final let HEADER_CELL_SPACING:CGFloat = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
        initializeTableView()
        loadCategory()
    }
    
    private func initializeUI() {
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func initializeTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 185
    }
    
    private func loadCategory() {
        categoryFetcher = CategoryFetcher(self, fetchType:.Category)
        categoryFetcher?.loadModels()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell:CategoryListTableCell = tableView.dequeueReusableCell(withIdentifier: "id_categoryListCell", for: indexPath) as! CategoryListTableCell
        categoryCell.setCategory(categoryList[indexPath.section], section: indexPath.section)
        return categoryCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableCell(withIdentifier: "id_headerView") as? TimelineCategoryHeaderCell
        view?.setCategory(categoryList[section])
        view?.frame = CGRect(x: 0, y: 0, width: tableView.width, height: tableView.sectionHeaderHeight - 40)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func loadSuccess(type: Fetcher_Type) {
        if type == .Category {
            if let list = categoryFetcher?.modelList as? [String] {
                categoryList = list
                tableView.reloadData()
            }
        }
    }
    
    func loadFail(type: Fetcher_Type) {
        
    }
}
