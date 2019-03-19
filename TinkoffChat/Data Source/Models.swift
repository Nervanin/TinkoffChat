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

struct UserProfileModel: Codable {
    var image: Data? //UIImage(named: "placeholder-user")
    var name = "Мелешко Константин"
    var description = "👨‍💻 Пытаюсь кодить под ios \n👨‍🎓 Учусь в Тинькофф ФинТех \n👨‍🏫 Помогаю развиваться другим"
}

class ConversationModel: ConversationCellConfiguration {
    var name: String?
    var messages: [MessageModel]?
    var message: String?
    var date: Date?
    var online: Bool?
    var hasUnreadMessge: Bool?
    var userImage: String?
    var id: String?
//
//    init?(name: String?, message: [MessageModel]?, date: Date?, online: Bool?, hasUnreadMessge: Bool?, userImage: String?) {
//        
//        self.name = name
//        self.messages = message
//        self.date = date
//        self.online = online
//        self.hasUnreadMessge = hasUnreadMessge
//        self.userImage = userImage
//    }
//
    init?(name: String?, messages: [MessageModel]?, message: String?, date: Date?, online: Bool?, hasUnreadMessge: Bool?, userImage: String?, id: String?) {
        self.name = name
        self.messages = messages
        self.message = message
        self.date = date
        self.online = online
        self.id = id
        self.hasUnreadMessge = hasUnreadMessge
    }
}

class MessageModel {
    
    var messageID: String?
    var text: String?
    var incomingMessage: Bool
    var date: Date?
    
    init(text: String?, incomingMessage: Bool, messageID: String?, date: Date?) {
        self.text = text
        self.incomingMessage = incomingMessage
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





