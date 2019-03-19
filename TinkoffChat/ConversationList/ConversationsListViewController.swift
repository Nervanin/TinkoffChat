//
//  ConversationsListViewController.swift
//  TinkoffChat
//
//  Created by Konstantin on 21/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ThemesViewControllerDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var userProfileButton: UIButton!
   // var conversationItemsArray = [ConversationModel]()
    var conversations = [[ConversationModel]]()
    var communicatorManager: CommunicatorManager?
    var onlineSection = [ConversationModel]()
    var historySection = [ConversationModel]()
    
    /*
     //var conversationItemsArray = [
     //MARK: Online
     [ConversationModel(name: "Тралл", message: "За молот рока!", date: Date(timeIntervalSinceNow: 0), online: true, hasUnreadMessge: false, userImage: "Trall"),
     ConversationModel(name: "Артас Менетил", message: "За моего отца!", date: Date(timeIntervalSinceNow: 0), online: true, hasUnreadMessge: false, userImage: "Artas"),
     ConversationModel(name: "Джайна Праудмур", message: "Орда ответит за это!", date: Date(from: "26.02.2019 00:47")!, online: true, hasUnreadMessge: false, userImage: "Jaina"),
     ConversationModel(name: "Сильвана", message: "За орду!", date: Date(from: "26.02.2019 01:54")!, online: true, hasUnreadMessge: false, userImage: "Silvana"),
     ConversationModel(name: "Король Лич", message: "Я получил власть, которая и не снилась моему отцу", date: Date(from: "24.02.2019 15:47")!, online: true, hasUnreadMessge: false, userImage: "Lich"),
     ConversationModel(name: "Гарош", message: "За орду!", date: Date(from: "22.02.2019 03:23")!, online: true, hasUnreadMessge: false, userImage: "Garosh"),
     ConversationModel(name: "Иллидан", message: "я ждал этого 10000 лет", date: Date(from: "22.02.2019 16:44")!, online: true, hasUnreadMessge: false, userImage: "Illidan"),
     ConversationModel(name: "Малфурион", message: "Иллидан, стой!", date: Date(from: "21.02.2019 15:47")!, online: true, hasUnreadMessge: true, userImage: "Malfurion"),
     ConversationModel(name: "Тиранда", message: "Малфурион, любовь моя", date: Date(from: "11.02.2019 09:12")!, online: true, hasUnreadMessge: true, userImage: "Tyranda"),
     ConversationModel(name: "Ксавий", message: "тебя одалела тень, моей истинной силы", date: Date(from: "06.02.2019 15:47")!, online: true, hasUnreadMessge: true, userImage: "Ksaviy"),
     ConversationModel(name: "Утер", message: "Артас, ты предал свет!", date: Date(from: "02.02.2019 13:34")!, online: true, hasUnreadMessge: true, userImage: "Uter"),
     ConversationModel(name: "Маев", message: "Иллидан где-то рядом", date: Date(from: "25.01.2019 23:31")!, online: true, hasUnreadMessge: true, userImage: "Maev"),
     ConversationModel(name: "Гулдан", message: "Твоя душа познает муки", date: Date(from: "16.01.2019 11:12")!, online: true, hasUnreadMessge: true, userImage: "Guldan"),
     ConversationModel(name: "Кадгар", message: nil, date: nil, online: true, hasUnreadMessge: true, userImage: "Kadgar")],
     // MARK: History
     [ConversationModel(name: "Slark", message: "Узник морских пучин", date: Date(from: "02.02.2019 11:11")!, online: false, hasUnreadMessge: false, userImage: "Slark_icon"),
     ConversationModel(name: "Earth Shaker", message: "СИЛА ЗЕМЛИ!", date: Date(from: "02.02.2019 12:12")!, online: false, hasUnreadMessge: false, userImage: "Earthshaker_icon"),
     ConversationModel(name: "Puck", message: "PUUUUCK!", date: Date(from: "02.02.2019 13:34")!, online: false, hasUnreadMessge: false, userImage: "Puck_icon"),
     ConversationModel(name: "BloodSeecker", message: "чую кровь", date: Date(from: "01.02.2019 14:44")!, online: false, hasUnreadMessge: false, userImage: "Bloodseeker_icon"),
     ConversationModel(name: "Pudge", message: "FRESH MEAT!!!!!", date: Date(from: "01.02.2019 15:34")!, online: false, hasUnreadMessge: false, userImage: "Pudge_icon"),
     ConversationModel(name: "Sven", message: "...", date: Date(from: "30.01.2019 16:54")!, online: false, hasUnreadMessge: true, userImage: "Sven_icon"),
     ConversationModel(name: "Lion", message: "...", date: Date(from: "29.01.2019 17:34")!, online: false, hasUnreadMessge: true, userImage: "Lion_icon"),
     ConversationModel(name: "KOTL", message: "чё-то там про свет", date: Date(from: "28.01.2019 13:34")!, online: false, hasUnreadMessge: true, userImage: "Keeper_of_the_Light_icon"),
     ConversationModel(name: "Abbadon", message: "а тут про дом Авенсис", date: Date(from: "28.01.2019 09:34")!, online: false, hasUnreadMessge: true, userImage: "Abaddon_icon"),
     ConversationModel(name: "Storm Spirit", message: nil, date: nil, online: false, hasUnreadMessge: true, userImage: "Storm_Spirit_icon"),
     ConversationModel(name: "Никита Джигурда", message: nil, date: nil, online: false, hasUnreadMessge: true, userImage: "GOD")]
     ]
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Tinkoff Chat"
        
        communicatorManager = CommunicatorManager()
        communicatorManager?.communicateManagersDelegate = self
        
        userProfileButton.setImage(UIImage(named: "placeholder-user"), for: .normal)
        userProfileButton.widthAnchor.constraint(equalToConstant: 35.0).isActive = true
        userProfileButton.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        userProfileButton.clipsToBounds = true
        userProfileButton.layer.cornerRadius = userProfileButton.bounds.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func userProfileButtonPressed(_ sender: UIButton) {
        let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let profileNavigationController = profileStoryboard.instantiateViewController(withIdentifier: "ProfileNavigationController")
        if sender == userProfileButton {
            print("райботай")
            present(profileNavigationController, animated: true, completion: nil)
        }
    }
    
    func themesViewController(_ controller: ThemesViewController!, didSelectTheme selectedTheme: UIColor!) {
        guard let theme = selectedTheme else {
            return
        }
        
        controller?.view.backgroundColor = theme
        logThemeChanging(selectedTheme: theme)
        
        ThemesManager.sharedInstance.applyTheme(theme)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentConversation = conversations[indexPath.section][indexPath.row]
        return configerationCell(tableView: tableView, model: currentConversation)
    }
    
    func configerationCell(tableView: UITableView, model: ConversationModel) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as! ConversationTableViewCell
        //cell.userName.text = model.name
        cell.name = "123"
        cell.dateOfLatsMessage.text = "\(Date.prepareDateToText(date: model.messages?.last?.date))"
        cell.conversation = model
        
        if let messages = model.messages,
            model.messages!.count > 0 {
            if model.hasUnreadMessge! {
                cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            } else {
                cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            }
            cell.textLabel?.text = messages.last?.text
        } else {
            cell.textLabel?.text = "No messages yet"
            cell.textLabel?.font = UIFont.italicSystemFont(ofSize: 14)
        }
        return cell
    }
    
    
    /*
     var cell: ConversationTableViewCell
     
     if let dequeueReusableCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? ConversationTableViewCell {
     cell = dequeueReusableCell
     } else {
     cell = ConversationTableViewCell()
     }
     
     let pathToProperty = conversationItemsArray[indexPath.section][indexPath.row]
     cell.name = pathToProperty?.name
     cell.userImage = pathToProperty?.userImage ?? "placeholder-user"
     
     cell.message = pathToProperty?.message
     cell.date = pathToProperty?.date
     cell.online = pathToProperty?.online
     cell.hasUnreadMessge = pathToProperty?.hasUnreadMessge
     cell.userImageView.clipsToBounds = true
     cell.userImageView.layer.cornerRadius = cell.userImageView.bounds.height / 2
     
     return cell
     }
     */
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    enum Sections: Int {
        case online = 0
        case history
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == Sections.online.rawValue {
            return "Online"
        } else if section == Sections.history.rawValue {
            return "History"
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToCoversationViewController" {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let destinationViewController = segue.destination as? ConversationViewController {
                    let itemsArray = conversations[indexPath.section][indexPath.row]
                    destinationViewController.navigationTitle = itemsArray.name ?? ""
                    destinationViewController.userImageName = itemsArray.userImage ?? "placeholder-user"
                }
            }
        }
        if segue.identifier == "ToThemesSegue" {
            if let navigationDestination = segue.destination as? UINavigationController {
                if let objcDestination = navigationDestination.viewControllers.first as? ThemesViewController {
                    objcDestination.delegate = self
                } else if let swiftDestination = navigationDestination.viewControllers.first as? ThemesViewControllerSwift {
                    swiftDestination.closure = { [unowned self] (controller: ThemesViewControllerSwift, selectedTheme: UIColor?) in
                        guard let theme = selectedTheme else {
                            return
                        }
                        
                        controller.view.backgroundColor = theme
                        self.logThemeChanging(selectedTheme: theme)
                        
                        ThemesManager.sharedInstance.applyTheme(theme)
                    }
                }
            }
        }
    }
    // MARK: ThemesViewControllerDelegate is realised
    
    private func logThemeChanging(selectedTheme: UIColor) {
        guard let redGreenBlue = selectedTheme.redGreenBlue255() else {
            return
        }
        print(redGreenBlue)
    }
    
    func removeSections() {
        conversations.removeAll()
        onlineSection.removeAll()
        historySection.removeAll()
    }
    
    func prepareTableViewFromData(data: [ConversationModel]) {
        removeSections()
        
        for conversation in data {
            if conversation.online == true {
                onlineSection.append(conversation)
            } else {
                historySection.append(conversation)
            }
        }
        conversations.append(onlineSection)
        conversations.append(historySection)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension ConversationsListViewController: CommunicatorManagerProtocol {
    func updateConversation(conversations: [ConversationModel]) {
        prepareTableViewFromData(data: conversations)
    }

    
}
