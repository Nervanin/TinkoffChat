//
//  Models.swift
//  TinkoffChat
//
//  Created by Konstantin on 17/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit
import Foundation

class UserProfileModel {
    var image = UIImage(named: "placeholder-user")
    var name = "Мелешко Константин"
    var discription = "👨‍💻 Пытаюсь кодить под ios \n👨‍🎓 Учусь в Тинькофф ФинТех \n👨‍🏫 Помогаю развиваться другим"
}

class ConversationModel: ConversationCellConfiguration {
    var name: String?
    var message: String?
    var date: Date?
    var online: Bool?
    var hasUnreadMessge: Bool?
    var userImage: String?
    
    init?(name: String?, message: String?, date: Date?, online: Bool?, hasUnreadMessge: Bool?, userImage: String?) {

        self.name = name
        self.message = message
        self.date = date
        self.online = online
        self.hasUnreadMessge = hasUnreadMessge
        self.userImage = userImage
    }
}
    
    class MessageModel {
        var text: String?
        var incomingMessage: Bool
        
        init(text: String?, incomingMessage: Bool) {
            self.text = text
            self.incomingMessage = incomingMessage
        }
    }

