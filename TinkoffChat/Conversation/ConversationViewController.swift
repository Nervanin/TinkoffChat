//
//  ConversationViewController.swift
//  TinkoffChat
//
//  Created by Konstantin on 24/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ConversationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var userProfileButton: UIButton!
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var sendMessageButton: UIButton!
    var conversation: ConversationModel?
    var communicatorManager: CommunicatorManager?
    
    var navigationTitle = String()
    var userImageName = String()
    let comingOutMessageCellId = "ComingOutMessageCellId"
    let outgoingMessageCellId = "OutgoingMessageCellId"
    
    
    /*
     let messageArray = [MessageModel(text: "1", incomingMessage: true),
     MessageModel(text: "2", incomingMessage: false),
     MessageModel(text: "Небольшое сообщение", incomingMessage: true),
     MessageModel(text: "Сообщение немного больше", incomingMessage: false),
     MessageModel(text: "Это будет достаточно длинное сообщение для проверки размеров моих лейблов. На самом деле я не совсем понимаю что тут писать. По этому тут будет небольшое bio из моей жизни. Меня зовут Никита Джигурда. И Я НОРМАЛЬНЫЙ!!!!! НОРМАЛЬНЫЙ Я!!!!!!!", incomingMessage: true),
     MessageModel(text: "Это будет достаточно длинное сообщение для проверки размеров моих лейблов. На самом деле я не совсем понимаю что тут писать. По этому тут будет небольшое bio из моей жизни. Меня зовут Никита Джигурда. И Я НОРМАЛЬНЫЙ!!!!! НОРМАЛЬНЫЙ Я!!!!!!!", incomingMessage: false),]
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = navigationTitle
        userProfileButton.setImage(UIImage(named: userImageName), for: .normal)
        userProfileButton.widthAnchor.constraint(equalToConstant: 35.0).isActive = true
        userProfileButton.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        userProfileButton.clipsToBounds = true
        userProfileButton.layer.cornerRadius = userProfileButton.bounds.height / 2
        
        tableView.tableFooterView = UIView()
        
        if let conversation = conversation {
            sendMessageButton.isEnabled = conversation.online
            
        }
        
        if let _ = conversation?.messages {
            scrollToBottom()
        }

    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messages = conversation?.messages {
            return messages.count
        } else {
            return 0
        }
    }

    
    
    /*
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
     */
    
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
    
    func scrollToBottom() {
        DispatchQueue.main.async {
            let rowsCount = self.tableView.numberOfRows(inSection: 0)
            if rowsCount > 0 {
                let indexPath = IndexPath(row: (self.conversation?.messages?.count)!-1, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
        }
    }
    
    @IBAction func sendMessageButtonPressed(_ sender: UIButton) {
        if let text = messageTextField.text {
            let message = MessageModel(text: text, isIncoming: false, messageID: nil, date: Date())
            conversation?.messages?.append(message)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            communicatorManager?.multipeerCommunicator?.sendMessage(string: messageTextField.text!, to: (conversation?.userId)!) {
                (success, error) in
                
                if let error = error {
                    print(error)
                }
            }
            
            messageTextField.text = ""
        }
        scrollToBottom()
    }
    
    func configureCell(tableView: UITableView, message: MessageModel) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: comingOutMessageCellId) as! MessageTableViewCell
        if message.isIncoming {
            cell.messageLabel.text = message.text
            let maximumLabelSize: CGSize = CGSize(width: 0, height: 9999)
            let expectedLabelSize: CGSize = cell.messageLabel.sizeThatFits(maximumLabelSize)
            var newFrame: CGRect = cell.messageLabel.frame
            cell.messageLabel.frame = newFrame
            newFrame.size.height = expectedLabelSize.height
            cell.messageLabel.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            cell.messageLabel.clipsToBounds = true
            cell.messageLabel.layer.cornerRadius = 6
            return cell
        } else {
            cell.messageLabel.text = message.text
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
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let messages = conversation?.messages {
            return configureCell(tableView: tableView, message: messages[indexPath.row])
        }
        return UITableViewCell()
    }

}



extension ConversationViewController: ConversationDelegate {
    
    func getMessage(messages: [MessageModel]) {
        conversation?.messages = messages
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didUserIsOnline(online: Bool) {
        self.sendMessageButton.isEnabled = online
        self.messageTextField.isUserInteractionEnabled = online
    }
    
    
}
