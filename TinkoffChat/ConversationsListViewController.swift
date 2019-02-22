//
//  ConversationsListViewController.swift
//  TinkoffChat
//
//  Created by Konstantin on 21/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var conversationItemsArray = [ConversationItemsForSection]()
    let selfUserProfileImage = UIImage(named: "placeholder-user")
    let selfUserProfileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10)) //(image: selfUserProfileImage)
    
    var tableView: UITableView = {
        var tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  selfUserProfileImageView.image = selfUserProfileImage
        conversationItemsArray = DataSource.parseDataSource()
        //   navigationItem.titleView = selfUserProfileImageView
        setUpNavigationBarItems()
        
    }
    
    func setUpNavigationBarItems() {
        // navigationItem.title = "Tinkoff Chat"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: selfUserProfileImage, style: UIBarButtonItem.Style.done, target: nil, action: nil)
        //        let button: UIButton = UIButton(type: .custom)
        //        button.setImage(UIImage(named: "icon"), for: .normal)
        //        button.frame = CGRect(x: 10, y: 10, width: 6, height: 6)
        //        let barButton = UIBarButtonItem(customView: button)
        //        self.navigationItem.rightBarButtonItem = barButton
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return conversationItemsArray.count
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
        if conversationItemsArray[indexPath.section].items[indexPath.row].message != nil {
            cell.lastUserMessage.text = conversationItemsArray[indexPath.section].items[indexPath.row].message
        } else {
            cell.lastUserMessage.text = "No messages yet"
        }
        if conversationItemsArray[indexPath.section].items[indexPath.row].online == false {
            cell.backgroundColor = #colorLiteral(red: 0.9357749809, green: 0.9764705896, blue: 0.7158226275, alpha: 1)
        }
        if conversationItemsArray[indexPath.section].items[indexPath.row].hasUnreadMessge == true {
            cell.lastUserMessage.font = UIFont.boldSystemFont(ofSize: 22.00)
        }

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
