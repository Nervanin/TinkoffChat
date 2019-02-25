//
//  ConversationTableViewCell.swift
//  TinkoffChat
//
//  Created by Konstantin on 21/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit

class ConversationTableViewCell: UITableViewCell, ConversationCellConfiguration {
    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var lastUserMessage: UILabel!
    @IBOutlet var dateOfLatsMessage: UILabel!
    
    var name: String? {
        didSet {
            userName.text = name
        }
    }
    var message: String? {
        didSet {
            lastUserMessage.text = message            
        }
    }
    var date: Date? {
        didSet{
            dateOfLatsMessage.text = formattedDate(date)
        }
    }
    var online: Bool? {
        didSet {
            if online == false {
                backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                backgroundColor = #colorLiteral(red: 0.9277957175, green: 1, blue: 0.5751780906, alpha: 1)
            }
        }
    }
    var hasUnreadMessge: Bool? = false {
        didSet {
            if message == nil {
                message = "No message yet"
                lastUserMessage.font = UIFont.italicSystemFont(ofSize: 18)
            } else {
                lastUserMessage.font = hasUnreadMessge ?? true ? UIFont.boldSystemFont(ofSize: 18) : UIFont.systemFont(ofSize: 18)
            }
        }
    }
    var userImage: String? {
        didSet {
            userImageView.image = UIImage(named: userImage ?? "placeholder-user")
        }
    }
    
    private func formattedDate(_ date: Date?) -> String? {
        guard let date = date else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            dateFormatter.dateFormat = "HH:mm"
        } else {
            dateFormatter.dateFormat = "dd MMM"
        }
        
        return dateFormatter.string(from: date)
    }
    
}
