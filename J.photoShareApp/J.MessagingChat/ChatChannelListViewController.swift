//
//  ChatChannelListViewController.swift
//  J.AskingApp
//
//  Created by JinYoung Lee on 30/10/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit

class ChatChannelListViewController: UITableViewController {
    private var channelList:[(String, String, String)] = [(String, String, String)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getChannelList()
        addListenerOnBarItems()
    }
    
    private func addListenerOnBarItems() {
        navigationItem.leftBarButtonItem?.target = self
        navigationItem.leftBarButtonItem?.action = #selector(onBackClick)
    }
    
    @objc private func onBackClick() {
        dismiss(animated: true, completion: nil)
    }
    
    func getChannelList() {
        reloadChannelList()
        ChatUtil().getChannelList { [weak self] (list) in
            self?.channelList = list
            self?.tableView.reloadData()
        }
    }
    
    private func reloadChannelList() {
        channelList.removeAll()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ChatChannelListCell = tableView.dequeueReusableCell(withIdentifier: "chatListCell", for: indexPath) as! ChatChannelListCell
        cell.bindData(ChannelData(name: channelList[indexPath.row].0, update: channelList[indexPath.row].1, id:channelList[indexPath.row].2), parent: self)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channelList.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enterChannel" {
            if let chatVC = segue.destination as? ChatViewController {
                let cell:ChatChannelListCell = sender as! ChatChannelListCell
                chatVC.setChannelData(cell.ChannelData)
            }
        }
    }
    
    @IBAction func openAddChannelListAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Channel", message: "can add user channel", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "add new channel name"
        }
        alertController.addAction(UIAlertAction(title: "Create", style: .default, handler: { (ok) in
            if let field = alertController.textFields?.first {
                if let inputText = field.text {
                    ChatUtil().createNewChannel(channelName: inputText)
                }
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}


