//
//  MessageTableViewCell.swift
//  TinkoffChat
//
//  Created by Konstantin on 25/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell, MessageCellConfiguration {

    @IBOutlet var messageLabel: UILabel!
    
    var messageText: String? {
        didSet {
            messageLabel.text = messageText
        }
    }
    
    

}
