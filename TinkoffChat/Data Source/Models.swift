//
//  Models.swift
//  TinkoffChat
//
//  Created by Konstantin on 17/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit
import Foundation
import MultipeerConnectivity

import UIKit

class ProfileModel {
    
    var name: String?
    var information: String?
    var image: UIImage?
    var previousImageData: Data?
}

class ConversationModel {
    var name: String?
    var messages: [MessageModel]?
    var userId: String?
    var message: String?
    var date: Date?
    var online: Bool
    var hasUnreadMessages: Bool
    var userImage: String?
    
   
    init(name: String?, messages: [MessageModel]?, message: String?, date: Date?, online: Bool, userId: String, hasUnreadMessages: Bool) {
        self.name = name
        self.messages = messages
        self.message = message
        self.date = date
        self.online = online
        self.userId = userId
        self.hasUnreadMessages = hasUnreadMessages
    }
}


class MessageModel {
    var messageID: String?
    var text: String?
    var isIncoming: Bool
    var date: Date?
    
    init(text: String?, isIncoming: Bool, messageID: String?, date: Date?) {
        self.text = text
        self.isIncoming = isIncoming
        self.messageID = messageID
        self.date = date
    }
//    var text: String?
//    var incomingMessage: Bool
//
//    init(text: String?, incomingMessage: Bool) {
//        self.text = text
//        self.incomingMessage = incomingMessage
//    }
}





