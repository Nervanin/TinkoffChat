//
//  ConversationViewController.swift
//  TinkoffChat
//
//  Created by Konstantin on 24/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var userProfileButton: UIButton!
    
    var navigationTitle = String()
    var userImageName = String()
    let comingOutMessageCellId = "ComingOutMessageCellId"
    let outgoingMessageCellId = "OutgoingMessageCellId"
    
    let messageArray = [MessageModel(text: "1", incomingMessage: true),
                        MessageModel(text: "2", incomingMessage: false),
                        MessageModel(text: "Небольшое сообщение", incomingMessage: true),
                        MessageModel(text: "Сообщение немного больше", incomingMessage: false),
                        MessageModel(text: "Это будет достаточно длинное сообщение для проверки размеров моих лейблов. На самом деле я не совсем понимаю что тут писать. По этому тут будет небольшое bio из моей жизни. Меня зовут Никита Джигурда. И Я НОРМАЛЬНЫЙ!!!!! НОРМАЛЬНЫЙ Я!!!!!!!", incomingMessage: true),
                        MessageModel(text: "Это будет достаточно длинное сообщение для проверки размеров моих лейблов. На самом деле я не совсем понимаю что тут писать. По этому тут будет небольшое bio из моей жизни. Меня зовут Никита Джигурда. И Я НОРМАЛЬНЫЙ!!!!! НОРМАЛЬНЫЙ Я!!!!!!!", incomingMessage: false),]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = navigationTitle
        userProfileButton.setImage(UIImage(named: userImageName), for: .normal)
        userProfileButton.widthAnchor.constraint(equalToConstant: 35.0).isActive = true
        userProfileButton.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        userProfileButton.clipsToBounds = true
        userProfileButton.layer.cornerRadius = userProfileButton.bounds.height / 2
        
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: MessageTableViewCell
        let message = messageArray[indexPath.row]
        let identifier = message.incomingMessage ? comingOutMessageCellId : outgoingMessageCellId
        
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MessageTableViewCell {
            cell = dequeuedCell
        } else {
            cell = MessageTableViewCell(style: .default, reuseIdentifier: identifier)
        }
        cell.messageText = message.text
        let maximumLabelSize: CGSize = CGSize(width: 0, height: 9999)
        let expectedLabelSize: CGSize = cell.messageLabel.sizeThatFits(maximumLabelSize)
        var newFrame: CGRect = cell.messageLabel.frame
        cell.messageLabel.frame = newFrame
        newFrame.size.height = expectedLabelSize.height
        cell.messageLabel.backgroundColor = #colorLiteral(red: 0.3489332866, green: 0.5910597314, blue: 0.7568627596, alpha: 1)
        cell.messageLabel.clipsToBounds = true
        cell.messageLabel.layer.cornerRadius = 6
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    @IBAction func buttonUserProfilePressed(_ sender: UIButton) {
        if sender == userProfileButton {
            let alertController = UIAlertController(title: "ВОУ ВОУ", message: "По причине криворукости разработчика, кнопка временно не работает. Как только научится - так сделает.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}
