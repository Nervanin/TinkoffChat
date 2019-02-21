//
//  ConversationsListViewController.swift
//  TinkoffChat
//
//  Created by Konstantin on 21/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var conversationItemsArray = [ChatItemsForSection]()
    
    var tableView: UITableView = {
        var tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conversationItemsArray = DataSource.parseDataSource()
        navigationItem.title = "Tinkoff Chat"
        
        // tableView.register(ConversationTableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 //
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversationItemsArray[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ConversationTableViewCell
        cell.userName.text = conversationItemsArray[indexPath.section].items[indexPath.row].name//"Мелешко Константин"
        cell.userName.font = UIFont.boldSystemFont(ofSize: 18.0)
        cell.userImageView?.image = UIImage(named: "placeholder-user")
        cell.userImageView?.layer.cornerRadius = 100
        cell.laseUserMessage?.text = "Тут последнее сообщение ,которое я хочу протестировать на количество строк"
        cell.dateOfLatsMessage.text = "12.50 pm"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return conversationItemsArray[section].status
    }
    
}
